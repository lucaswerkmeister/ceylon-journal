import java.lang {
    ObjectArray
}

"Whether to include location information in journal messages.
 
 If [[true]] (default),
 the file name of the [[writeJournal]] invocation is stored in the `CODE_FILE` field,
 the line number of the [[writeJournal]] invocation is stored in the `CODE_LINE` field,
 and the function name of the [[writeJournal]] invocation is stored in the `CODE_FUNC` field."
shared variable Boolean includeLocation = true;

"""Send a message to the system journal.
   Certain well-known fields are available as named parameters,
   and custom fields may be specified using the iterable [[fields]] parameter.
   
   Usage example:
   
       writeJournal {
           "User ``user`` requested calculation: ``operand1`` ``operator`` ``operand2`` = ``result``";
           messageId = message_calculation; // toplevel value
           priority = Priority.info;
           "USER"->user,
           "OPERAND1"->operand1.string,
           "OPERAND2"->operand2.string,
           "OPERATOR"->operator,
           "RESULT"->result
       };
   
   You can then search for all additions performed by user `joe` with the following command:
   ~~~sh
   journalctl USER=joe OPERATOR=+
   ~~~
   (Ideally, you would also add a match for `MESSAGE_ID` with the value of `message_calculation`.)"""
throws (`class AssertionError`, "If the underlying `sd_journal_sendv` function returns an error.")
shared void writeJournal(message, messageId = null, priority = null, fields = {}) {
    String message;
    MessageId? messageId;
    Priority? priority;
    {<String->String>*} fields;
    
    value fieldsSeq = fields.sequence();
    variable value nFields = fieldsSeq.size;
    nFields += 1; // message
    if (messageId exists) {
        nFields += 1;
    }
    if (priority exists) {
        nFields += 1;
    }
    if (includeLocation) {
        nFields += 3;
    }
    assert (is ObjectArray<Iovec> iovecsArray = Iovec().toArray(nFields));
    variable List<Iovec?> remainingIovecs = iovecsArray.array;
    
    assert (exists iov1 = remainingIovecs.first);
    setIovecToByteBufferPlusString(iov1, messageBytes, message);
    remainingIovecs = remainingIovecs.rest;
    
    if (exists messageId) {
        assert (exists iov = remainingIovecs.first);
        setIovecToByteBuffer(iov, messageId.encodedField);
        remainingIovecs = remainingIovecs.rest;
    }
    
    if (exists priority) {
        assert (exists iov = remainingIovecs.first);
        setIovecToByteBuffer(iov, priority.encodedField);
        remainingIovecs = remainingIovecs.rest;
    }
    
    if (includeLocation) {
        value [codeFile, codeLine, className, methodName] = getCodeInformation();
        assert (exists iovFile = remainingIovecs.first);
        setIovecToByteBufferPlusString(iovFile, codeFileBytes, codeFile);
        remainingIovecs = remainingIovecs.rest;
        assert (exists iovLine = remainingIovecs.first);
        setIovecToByteBufferPlusString(iovLine, codeLineBytes, codeLine.string);
        remainingIovecs = remainingIovecs.rest;
        assert (exists iovFunc = remainingIovecs.first);
        setIovecToByteBufferPlusString(iovFunc, codeFuncBytes, methodName);
        remainingIovecs = remainingIovecs.rest;
    }
    
    for (field->iov in zipEntries(fieldsSeq, remainingIovecs)) {
        assert (exists iov);
        value fieldKey->fieldValue = field;
        setIovecToString(iov, fieldKey + "=" + fieldValue);
    }
    
    value ret = systemd.sd_journal_sendv(iovecsArray, iovecsArray.size);
    if (ret < 0) {
        throw AssertionError("sd_journal_sendv(): `` c.strerror(-ret) ``");
    }
}
