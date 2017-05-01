`de.lucaswerkmeister.ceylonJournal`
===================================

A module that lets you send messages with structured information to the systemd system journal.

Current status
--------------

Prototype / pre-release candidate.
You can use it, but I don’t promise a stable interface yet.
The `run` function definitely has to be removed before release,
and automated tests are definitely necessary.

Usage
-----

```ceylon
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
```

You can then search for all additions performed by user `joe` with the following command:
```sh
journalctl MESSAGE_ID=9f28d5bcffcb4700ac8909b4ca208676 USER=joe OPERATOR=+
```

License
-------

The content of this repository is released under the LGPL v3.0
as provided in the LICENSE file that accompanied this code,
or (at your option) any later version.

By submitting a "pull request" or otherwise contributing to 
this repository, you agree to license your contribution under 
the license mentioned above.
