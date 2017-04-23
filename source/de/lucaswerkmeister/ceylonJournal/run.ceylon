import com.sun.jna {
    Memory,
    Native
}
import java.lang {
    ObjectArray,
    Types
}
import ceylon.buffer.charset {
    utf8
}

shared Systemd systemd = Native.loadLibrary("systemd", Types.classForType<Systemd>());

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

shared void run() {
    assert (is ObjectArray<Iovec> iovecs = Iovec(null, 0).toArray(2));
    
    assert (exists iov1 = iovecs[0]);
    setIovecToString(iov1, "MESSAGE=A big \{ELEPHANT}-y Hello from Ceylon!");
    assert (exists iov2 = iovecs[1]);
    setIovecToString(iov2, "CODE_FILE=run.ceylon");
    
    systemd.sd_journal_sendv(iovecs, iovecs.size);
}
