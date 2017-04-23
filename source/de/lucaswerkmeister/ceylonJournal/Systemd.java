package de.lucaswerkmeister.ceylonJournal;

import com.sun.jna.Library;
import com.sun.jna.Pointer;

public interface Systemd extends Library {
    public int sd_journal_sendv(Iovec[] iov, int n);
}

