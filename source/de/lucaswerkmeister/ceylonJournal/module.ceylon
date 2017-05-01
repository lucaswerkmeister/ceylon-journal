"""This module lets you send messages with structured information to the systemd system journal.
   
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
native ("jvm", "js") module de.lucaswerkmeister.ceylonJournal "0.2.0" {
    native ("jvm") import java.base "7";
    shared import ceylon.buffer "1.3.3-SNAPSHOT";
    native ("jvm") shared import maven:net.java.dev.jna:"jna" "4.4.0";
    native ("js") import npm:ffi "2.2.0";
    native ("js") import npm:ref "1.3.4";
    native ("js") import npm:"ref-array" "1.2.0";
    native ("js") import npm:"ref-struct" "1.1.0";
}
