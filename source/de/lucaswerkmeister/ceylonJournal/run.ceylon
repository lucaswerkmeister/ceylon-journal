MessageId message_messageMessageIdAndPriority = MessageId.fromString("95157acbf1a146349aded4734827bb18");
MessageId message_messageMessageIdPriorityAndField = MessageId.fromString("f4ea0340035349e797cd1e633e218170");

shared void run() {
    writeJournal {
        "Just message.";
    };
    includeLocation = false;
    writeJournal {
        "Message, message ID and priority.";
        messageId = message_messageMessageIdAndPriority;
        priority = Priority.info;
    };
    writeJournal {
        "Message and field.";
        "FIELD1"->"field one"
    };
    includeLocation = true;
    writeJournal {
        "Message, message ID, priority and field.";
        messageId = message_messageMessageIdPriorityAndField;
        priority = Priority.info;
        "FIELD1"->"field one"
    };
}
