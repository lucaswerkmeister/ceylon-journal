import ceylon.buffer {
    ByteBuffer
}
import ceylon.buffer.charset {
    ascii
}

"A 128-bit message identifier, which may be used to recognize different message types in the journal.
 
 The intended usage is to define message ID objects as toplevel values,
 and to pass them to [[writeJournal]] with the associated message.
 Each message should have a different, distinct ID."
shared class MessageId {
    
    "This field is for internal use only."
    shared ByteBuffer encodedField;
    
    "Create a new ID from a hexadecimal (lowercase) string.
     You can generate a new ID with the command `journalctl --new-id128`;
     the first printed format (“as string”) is suitable for this constructor."
    shared new fromString(String hexadecimal) {
        assert (hexadecimal.size == 2*16);
        assert (hexadecimal.every("0123456789abcdef".contains));
        
        value encodedHexadecimal = ascii.encodeBuffer(hexadecimal);
        encodedField = ByteBuffer.ofSize(messageIdBytes.available + 2*16);
        while (messageIdBytes.hasAvailable) {
            encodedField.put(messageIdBytes.get());
        }
        messageIdBytes.flip();
        while (encodedHexadecimal.hasAvailable) {
            encodedField.put(encodedHexadecimal.get());
        }
        encodedField.flip();
    }
}
