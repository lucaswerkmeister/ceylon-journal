package de.lucaswerkmeister.ceylonJournal;

import com.sun.jna.Library;

public interface C extends Library {
    public String strerror(int errnum);
}
