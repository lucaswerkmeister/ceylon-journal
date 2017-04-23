package de.lucaswerkmeister.ceylonJournal;

import java.util.Arrays;
import java.util.List;

import com.sun.jna.Pointer;
import com.sun.jna.Structure;

public class Iovec extends Structure {
    
    public Pointer base;
    public int length;
    
    public Iovec() {
        this(null, 0);
    }
    
    public Iovec(Pointer base, int length) {
        this.base = base;
        this.length = length;
    }

    @Override
    protected List<String> getFieldOrder() {
        return Arrays.asList("base", "length");
    }

}
