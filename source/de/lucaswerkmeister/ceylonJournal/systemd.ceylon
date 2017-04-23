import java.lang {
    Types
}
import com.sun.jna {
    Native
}

shared Systemd systemd = Native.loadLibrary("systemd", Types.classForType<Systemd>());
