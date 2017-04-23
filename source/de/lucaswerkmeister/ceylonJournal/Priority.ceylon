import ceylon.buffer {
    ByteBuffer
}

"A *syslog(3)* priority."
shared class Priority
        of debug | info | notice | warning | err | crit | alert | emerg {
    
    "This field is for internal use only."
    shared ByteBuffer encodedField;
    
    abstract new ofLevel(Integer level) {
        encodedField = ByteBuffer.ofSize(priorityBytes.available + 1);
        while (priorityBytes.hasAvailable) {
            encodedField.put(priorityBytes.get());
        }
        priorityBytes.flip();
        encodedField.put('0'.integer.byte + level.byte);
        encodedField.flip();
    }
    
    "debug-level message"
    shared new debug extends ofLevel(0) {}
    "informational message"
    shared new info extends ofLevel(1) {}
    "normal, but significant, condition"
    shared new notice extends ofLevel(2) {}
    "warning conditions"
    shared new warning extends ofLevel(3) {}
    "error conditions"
    shared new err extends ofLevel(4) {}
    "critical conditions"
    shared new crit extends ofLevel(5) {}
    "action must be taken immediately"
    shared new alert extends ofLevel(6) {}
    "system is unusable"
    shared new emerg extends ofLevel(7) {}
}
