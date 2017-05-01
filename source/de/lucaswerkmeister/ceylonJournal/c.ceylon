native ("jvm") C c = (function() {
        import java.lang {
            Types
        }
        import com.sun.jna {
            Native
        }
        return Native.loadLibrary("c", Types.classForType<C>());
    })();
