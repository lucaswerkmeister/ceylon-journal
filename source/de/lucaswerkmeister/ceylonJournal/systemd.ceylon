import java.lang {
    Types
}
import com.sun.jna {
    Native
}

Systemd systemd = Native.loadLibrary("systemd", Types.classForType<Systemd>());
