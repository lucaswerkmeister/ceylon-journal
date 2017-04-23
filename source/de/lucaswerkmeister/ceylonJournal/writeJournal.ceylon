import java.lang {
    ObjectArray
}

shared void writeJournal(message, fields = {}) {
    String message;
    // TODO more parameters
    {<String->String>*} fields;
    
    value fieldsSeq = fields.sequence();
    value nFields = 1 + fieldsSeq.size;
    assert (is ObjectArray<Iovec> iovecs = Iovec().toArray(nFields));
    
    assert (exists iov1 = iovecs[0]);
    setIovecToString(iov1, message, messageBytes);
    
    for (field->iov in zipEntries(fieldsSeq, iovecs.array.rest)) {
        assert (exists iov);
        value fieldKey->fieldValue = field;
        setIovecToString(iov, fieldKey + "=" + fieldValue);
    }
    
    value ret = systemd.sd_journal_sendv(iovecs, iovecs.size);
    if (ret < 0) {
        throw AssertionError("sd_journal_sendv returned error `` -ret ``"); // TODO strerror
    }
}
