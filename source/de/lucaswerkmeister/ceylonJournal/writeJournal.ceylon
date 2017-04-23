import java.lang {
    ObjectArray
}

shared void writeJournal(message, messageId = null, fields = {}) {
    String message;
    MessageId? messageId;
    // TODO more parameters
    {<String->String>*} fields;
    
    value fieldsSeq = fields.sequence();
    variable value nFields = fieldsSeq.size;
    nFields += 1; // message
    if (messageId exists) {
        nFields += 1;
    }
    assert (is ObjectArray<Iovec> iovecsArray = Iovec().toArray(nFields));
    variable List<Iovec?> remainingIovecs = iovecsArray.array;
    
    assert (exists iov1 = remainingIovecs.first);
    setIovecToByteBufferPlusString(iov1, messageBytes, message);
    messageBytes.flip();
    remainingIovecs = remainingIovecs.rest;
    
    if (exists messageId) {
        assert (exists iov = remainingIovecs.first);
        setIovecToByteBuffer(iov, messageId.encodedField);
        messageId.encodedField.flip();
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
