native ("jvm") Systemd systemd = (function() {
        import java.lang {
            Types
        }
        import com.sun.jna {
            Native
        }
        
        return Native.loadLibrary("systemd", Types.classForType<Systemd>());
    })();
