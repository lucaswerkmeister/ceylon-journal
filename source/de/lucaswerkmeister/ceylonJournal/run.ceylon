shared void run() {
    writeJournal {
        "This is a test message from Ceylon.";
        "FIELD1"->"testfield one",
        "FIELD2"->"testfield number two"
    };
    writeJournal {
        "This is a second test message from Ceylon.";
        "FIELD1"->"second testfield one",
        "FIELD2"->"second testfield number two"
    };
}
