import ceylon.buffer {
    ByteBuffer
}
import ceylon.buffer.charset {
    utf8
}
import com.sun.jna {
    Memory
}

void setIovecToString(Iovec iovec, String string, ByteBuffer? prefix = null) {
    value prefixLength = prefix?.available else 0;
    value encodedString = utf8.encodeBuffer(string);
    value stringLength = encodedString.available;
    value totalLength = prefixLength + stringLength;
    value memory = Memory(totalLength);
    
    if (exists prefix) {
        for (i in 0:prefixLength) {
            memory.setByte(i, prefix.get());
        }
    }
    for (i in prefixLength:stringLength) {
        memory.setByte(i, encodedString.get());
    }
    
    iovec.base = memory;
    iovec.length = totalLength;
}
