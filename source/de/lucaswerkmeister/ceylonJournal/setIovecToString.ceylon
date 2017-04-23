import ceylon.buffer.charset {
    utf8
}
import com.sun.jna {
    Memory
}

void setIovecToString(Iovec iovec, String string) {
    value buf = utf8.encodeBuffer(string);
    value cnt = buf.available;
    value mem = Memory(cnt);
    for (i in 0:cnt) {
        mem.setByte(i, buf.get());
    }
    iovec.base = mem;
    iovec.length = cnt;
}
