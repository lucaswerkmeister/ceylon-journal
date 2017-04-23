shared void run() {
    writeJournal {
        "This is a test message from Ceylon.";
        "FIELD1"->"testfield one",
        "FIELD2"->"testfield number two"
    };
}
