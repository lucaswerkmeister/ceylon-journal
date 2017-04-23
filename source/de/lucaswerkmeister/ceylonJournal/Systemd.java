package de.lucaswerkmeister.ceylonJournal;

import com.sun.jna.Library;
import com.sun.jna.Pointer;

interface Systemd extends Library {
    public int sd_journal_sendv(Iovec[] iov, int n);
}
