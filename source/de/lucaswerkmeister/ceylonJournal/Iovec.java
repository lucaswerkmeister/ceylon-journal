package de.lucaswerkmeister.ceylonJournal;

import java.util.Arrays;
import java.util.List;

import com.sun.jna.Pointer;
import com.sun.jna.Structure;

public class Iovec extends Structure {
    
    public static class ByReference extends Iovec implements Structure.ByReference {
        public ByReference(Pointer base, int length) {
            super(base, length);
        }
    }
    
    public Pointer base;
    public int length;
    
    public Iovec(Pointer base, int length) {
        this.base = base;
        this.length = length;
    }

    @Override
    protected List<String> getFieldOrder() {
        return Arrays.asList("base", "length");
    }

}
