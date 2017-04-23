import ceylon.buffer {
    ByteBuffer
}
import ceylon.buffer.charset {
    ascii
}

// ASCII encodings of some well-known fields (see man:systemd.journal-fields(7))
// so that they don’t have to be re-encoded each time they are logged.

ByteBuffer messageBytes = ascii.encodeBuffer("MESSAGE=");
ByteBuffer messageIdBytes = ascii.encodeBuffer("MESSAGE_ID=");
ByteBuffer priorityBytes = ascii.encodeBuffer("PRIORITY=");
ByteBuffer codeFileBytes = ascii.encodeBuffer("CODE_FILE=");
ByteBuffer codeLineBytes = ascii.encodeBuffer("CODE_LINE=");
ByteBuffer codeFuncBytes = ascii.encodeBuffer("CODE_FUNC=");
