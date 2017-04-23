import ceylon.buffer {
    ByteBuffer
}
import ceylon.buffer.charset {
    utf8
}
import com.sun.jna {
    Memory
}

void setIovecToString(Iovec iovec, String string) {
    value encodedString = utf8.encodeBuffer(string);
    value stringLength = encodedString.available;
    value memory = Memory(stringLength);
    
    for (i in 0:stringLength) {
        memory.setByte(i, encodedString.get());
    }
    
    iovec.base = memory;
    iovec.length = stringLength;
}

void setIovecToByteBufferPlusString(Iovec iovec, ByteBuffer byteBuffer, String string) {
    value byteBufferLength = byteBuffer.available;
    value encodedString = utf8.encodeBuffer(string);
    value stringLength = encodedString.available;
    value totalLength = byteBufferLength + stringLength;
    value memory = Memory(totalLength);
    
    for (i in 0:byteBufferLength) {
        memory.setByte(i, byteBuffer.get());
    }
    byteBuffer.flip();
    for (i in byteBufferLength:stringLength) {
        memory.setByte(i, encodedString.get());
    }
    
    iovec.base = memory;
    iovec.length = totalLength;
}

void setIovecToByteBuffer(Iovec iovec, ByteBuffer byteBuffer) {
    value byteBufferLength = byteBuffer.available;
    value memory = Memory(byteBufferLength);
    
    for (i in 0:byteBufferLength) {
        memory.setByte(i, byteBuffer.get());
    }
    byteBuffer.flip();
    
    iovec.base = memory;
    iovec.length = byteBufferLength;
}
