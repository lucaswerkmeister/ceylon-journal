import ceylon.buffer {
    ByteBuffer
}

native ("js") dynamic makeIovecFromString(String string) {
    import ref {
        allocCString
    }
    dynamic {
        dynamic cString = allocCString(string, "utf8");
        return iovec(dynamic [
                iov_base = cString;
                iov_len = cString.length - 1; // exclude null byte
            ]);
    }
}

native ("js") dynamic makeIovecFromByteBufferPlusString(ByteBuffer byteBuffer, String string) {
    import ref {
        refType,
        types,
        writeCString
    }
    dynamic {
        value byteBufferLength = byteBuffer.available;
        Integer stringLength = Buffer.byteLength(string, "utf8");
        dynamic nodeBuffer = Buffer.allocUnsafe(byteBufferLength + stringLength + 1); // include null byte in length because writeCString writes it
        for (i in 0:byteBufferLength) {
            nodeBuffer[i] = byteBuffer.get().unsigned;
        }
        byteBuffer.flip();
        writeCString(nodeBuffer, byteBufferLength, string, "utf8");
        nodeBuffer.type = refType((types).char); // the ()s work around ceylon/ceylon#7050; TODO remove
        return iovec(dynamic [
                iov_base = nodeBuffer;
                iov_len = byteBufferLength + stringLength; // don’t include null byte in length here
            ]);
    }
}

native ("js") dynamic makeIovecFromByteBuffer(ByteBuffer byteBuffer) {
    import ref {
        refType,
        types
    }
    dynamic {
        value byteBufferLength = byteBuffer.available;
        dynamic nodeBuffer = Buffer.allocUnsafe(byteBufferLength);
        for (i in 0:byteBufferLength) {
            nodeBuffer[i] = byteBuffer.get().unsigned;
        }
        byteBuffer.flip();
        nodeBuffer.type = refType((types).char); // the ()s work around ceylon/ceylon#7050; TODO remove
        return iovec(dynamic [
                iov_base = nodeBuffer;
                iov_len = byteBufferLength;
            ]);
    }
}
