# ABAPFuck - Brainfuck Interpreter for ABAP

[![srb.at](assets/srb_logo.png)](https://www.srb.at)

[![Blog](https://img.shields.io/static/v1.svg?color=f5d410&labelColor=11215a&logoColor=ffffff&style=for-the-badge&label=srb.at&message=Blog)](https://www.srb.at/blog--events/)
[![GitHub](https://img.shields.io/static/v1.svg?color=f5d410&labelColor=11215a&logoColor=ffffff&style=for-the-badge&label=srb.at&message=github&logo=github)](https://github.com/SRBConsultingTeam/)
[![License](https://img.shields.io/static/v1.svg?color=f5d410&labelColor=11215a&logoColor=ffffff&style=for-the-badge&label=License&message=MIT)](LICENSE)
![ABAP](https://img.shields.io/static/v1.svg?color=f5d410&labelColor=11215a&logoColor=ffffff&style=for-the-badge&label=ABAP&message=7.54)
[![README.md](https://img.shields.io/static/v1.svg?color=f5d410&labelColor=11215a&logoColor=ffffff&style=for-the-badge&label=README&message=de)](README.md)

## Installation
* Either clone the repository using [AbapGit](https://docs.abapgit.org/), or
* create a new class and copy the source code from [src/zcl_brainfuck_interpreter.clas.abap](src/zcl_brainfuck_interpreter.clas.abap).

## Running the brainfuck interpreter
### Eclipse
Open the class in Eclipse and hit `F9` to run it. Since the class implements the interface `if_oo_adt_classrun`,
the method `if_oo_adt_classrun~main` will be called. The console view should output the following text:

```
Running 'Hello World' Example
Sourcecode: ++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.+++.
Stdout: Hello World!
```

### Class Builder - Transaction se24
1. Enter class name and hit `F8`.
2. Maintain `SOURCE` und optional `STDIN` and again hit `F8`.
3. To process the Brainfuck code run method `PROCESS`.
4. To read the standard output of the interpreter run method `GET_STDOUT`.

## Remarks
At least ABAP 7.54 is required.

