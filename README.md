[![en](https://img.shields.io/badge/lang-en-yellow)](README.en.md)

# ABAPFuck - Ein Brainfuck Interpreter für ABAP

## Installation
Der Interpreter kann wie folgt im System importiert werden:
* Entweder mittels [AbapGit](https://docs.abapgit.org/), oder
* manuell, in dem eine neue Klasse am System angelegt und der Code aus [src/zcl_brainfuck_interpreter.clas.abap](src/zcl_brainfuck_interpreter.clas.abap) eingefügt wird.

## Ausführen der Klasse
### Mittels Eclipse
Hierfür die Klasse in Eclipse öffnen und anschließend F9 drücken. Da der Brainfuck Interpreter das Interface `if_oo_adt_classrun` implementiert, wird dadurch die Methode `if_oo_adt_classrun~main` ausgeführt. Folgende Ausgabe sollte erscheinen:

```
Running 'Hello World' Example
Sourcecode: ++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.+++.
Stdout: Hello World!
```

### Mittels Class Builder - Transaktion se24
1. Klasse im Eingabefeld einfügen und F8 drücken.
2. Die Parameter `SOURCE` und optional `STDIN` setzen und erneut F8 drücken.
3. Damit der Code auch verarbeitet wird muss die `PROCESS` Methode aufgerufen werden.
4. Durch das Aufrufen der Methode `GET_STDOUT` wird die generierte Ausgabe abgerufen.

## Anmerkungen
Der Brainfuck Interpreter benötigt ABAP 7.54.
