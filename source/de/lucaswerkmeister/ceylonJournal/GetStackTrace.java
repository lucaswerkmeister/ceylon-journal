package de.lucaswerkmeister.ceylonJournal;

class GetStackTrace {
    public static StackTraceElement[] getStackTrace() {
        return new Exception().getStackTrace();
    }
}
