MessageId message_messageAndMessageId = MessageId.fromString("95157acbf1a146349aded4734827bb18");
MessageId message_messageMessageIdAndField = MessageId.fromString("f4ea0340035349e797cd1e633e218170");

shared void run() {
    writeJournal {
        "Just message.";
    };
    writeJournal {
        "Message and message ID.";
        messageId = message_messageAndMessageId;
    };
    writeJournal {
        "Message and field.";
        "FIELD1"->"field one"
    };
    writeJournal {
        "Message, message ID and field,";
        messageId = message_messageMessageIdAndField;
        "FIELD1"->"field one"
    };
}
