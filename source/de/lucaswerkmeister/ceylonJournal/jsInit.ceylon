import ref {
    types
}
import ref.struct {
    refStruct
}
import ref.array {
    refArray
}

native ("js") dynamic Libsystemd {
    shared formal Integer sd_journal_sendv(dynamic iov, Integer n);
}

native ("js") dynamic iovec = (function() {
        dynamic {
            dynamic size_t = (types).size_t;
            dynamic string = (types).\iCString;
            return refStruct(dynamic [
                    iov_base = string;
                    iov_len = size_t;
                ]);
        }
    })();
native ("js") dynamic iovecArray = (function() {
        dynamic {
            return refArray(iovec);
        }
    })();
native ("js") Libsystemd libsystemd = (function() {
    // TODO import ffi { Library } instead of using require() below once ceylon/ceylon#7047 is fixed
        dynamic {
            dynamic int = (types).int;
            return require("ffi").\iLibrary("libsystemd", dynamic [
                    sd_journal_sendv = dynamic [ int, dynamic [ iovecArray, int ] ];
                ]);
        }
    })();
