import java.lang {
    ObjectArray
}

"Whether to include location information in journal messages.
 
 If [[true]] (default),
 the file name of the [[writeJournal]] invocation is stored in the `CODE_FILE` field,
 the line number of the [[writeJournal]] invocation is stored in the `CODE_LINE` field,
 and the function name of the [[writeJournal]] invocation is stored in the `CODE_FUNC` field."
shared variable Boolean includeLocation = true;

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
        throw AssertionError("sd_journal_sendv returned error `` -ret ``"); // TODO strerror
    }
}
