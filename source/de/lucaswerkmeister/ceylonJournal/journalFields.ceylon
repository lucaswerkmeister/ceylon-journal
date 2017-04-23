import ceylon.buffer {
    ByteBuffer
}
import ceylon.buffer.charset {
    utf8
}

// UTF-8 encodings of some well-known fields (see man:systemd.journal-fields(7))
// so that they don’t have to be re-encoded each time they are logged.

ByteBuffer messageBytes = utf8.encodeBuffer("MESSAGE=");
ByteBuffer messageIdBytes = utf8.encodeBuffer("MESSAGE_ID=");
ByteBuffer priorityBytes = utf8.encodeBuffer("PRIORITY=");
