import java.lang {
    Types
}
import com.sun.jna {
    Native
}

C c = Native.loadLibrary("c", Types.classForType<C>());
