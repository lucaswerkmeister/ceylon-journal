import com.sun.jna {
    Memory,
    Native
}
import java.lang {
    ObjectArray,
    Types
}
import ceylon.buffer.charset { utf8 }

shared Systemd systemd = Native.loadLibrary("systemd", Types.classForType<Systemd>());

shared void run() {
    value msg = "MESSAGE=A big \{ELEPHANT}-y Hello from Ceylon!";
    value buf = utf8.encodeBuffer(msg);
    value cnt = buf.available;
    value mem = Memory(cnt);
    for (i in 0:cnt) {
        mem.setByte(i, buf.get());
    }
    value iovec = Iovec(mem, cnt);
    assert (is ObjectArray<Iovec> iovecs = iovec.toArray(1));
    systemd.sd_journal_sendv(iovecs, 1);
}
