"""This module lets you send messages with structured information to the system journal.
   
   Usage example:
   
       import de.lucaswerkmeister.ceylonJournal { ... }
       // ...
       
       MessageId message_calculation = MessageId.fromString("9f28d5bcffcb4700ac8909b4ca208676");
       
       // ...
       
       void process(Request request) {
           // ...
           writeJournal {
               "User ``user`` requested calculation: ``operand1`` ``operator`` ``operand2`` = ``result``";
               messageId = message_calculation;
               priority = Priority.info;
               "USER"->user,
               "OPERAND1"->operand1.string,
               "OPERAND2"->operand2.string,
               "OPERATOR"->operator,
               "RESULT"->result
           };
           // ...
       }
   
   You can then search for all additions performed by user `joe` with the following command:
   ~~~sh
   journalctl MESSAGE_ID=9f28d5bcffcb4700ac8909b4ca208676 USER=joe OPERATOR=+
   ~~~"""
see (`function writeJournal`, `class MessageId`, `class Priority`)
by ("Lucas Werkmeister <mail@lucaswerkmeister.de>")
license ("https://www.gnu.org/licenses/lgpl-3.0.html")
native ("jvm") module de.lucaswerkmeister.ceylonJournal "0.1.0" {
    import java.base "7";
    shared import ceylon.buffer "1.3.3-SNAPSHOT";
    shared import maven:net.java.dev.jna:"jna" "4.4.0";
}
