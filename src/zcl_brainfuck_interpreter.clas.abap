CLASS zcl_brainfuck_interpreter DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

    TYPES: BEGIN OF kvp,
             key   TYPE int4,
             value TYPE int4,
           END OF kvp.

    TYPES: dictionary TYPE SORTED TABLE OF kvp WITH UNIQUE KEY key.

    TYPES: bytememory TYPE STANDARD TABLE OF char1 WITH NON-UNIQUE DEFAULT KEY.

    METHODS: constructor
      IMPORTING source TYPE string OPTIONAL
                stdin  TYPE string OPTIONAL.

    METHODS set_source
      IMPORTING source TYPE string.

    METHODS set_stdin
      IMPORTING stdin TYPE string.

    METHODS get_stdout
      RETURNING VALUE(stdout) TYPE string.

    METHODS process.

  PROTECTED SECTION.
    METHODS decrement_current_cell.
    METHODS increment_current_cell.
    METHODS append_to_stdout.

  PRIVATE SECTION.
    DATA memory TYPE dictionary.
    DATA memoryindex TYPE int4.

    DATA source TYPE bytememory.
    DATA sourceindex TYPE int4.

    DATA stdin TYPE bytememory.
    DATA stdinindex TYPE int4.

    DATA stdout TYPE string.

ENDCLASS.



CLASS zcl_brainfuck_interpreter IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(hello_world_source) = |++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.+++.|.

    out->write( |Running 'Hello World' Example| ).
    out->write( |Sourcecode: { hello_world_source }| ).

    set_source( hello_world_source ).

    process( ).

    out->write( |Stdout: { get_stdout( ) }| ).

  ENDMETHOD.

  METHOD decrement_current_cell.
    IF ( line_exists( memory[ key = memoryindex ] ) ).
      IF ( memory[ key = memoryindex ]-value = 0 ).
        memory[ key = memoryindex ]-value = 255.
      ELSE.
        memory[ key = memoryindex ]-value -= 1.
      ENDIF.
    ELSE.
      INSERT VALUE #( key = memoryindex value = 255 ) INTO TABLE memory.
    ENDIF.
  ENDMETHOD.

  METHOD increment_current_cell.
    IF ( line_exists( memory[ key = memoryindex ] ) ).
      IF ( memory[ key = memoryindex ]-value = 255 ).
        memory[ key = memoryindex ]-value = 0.
      ELSE.
        memory[ key = memoryindex ]-value += 1.
      ENDIF.
    ELSE.
      INSERT VALUE #( key = memoryindex value = 1 ) INTO TABLE memory.
    ENDIF.
  ENDMETHOD.

  METHOD constructor.

    set_source( source ).
    set_stdin( stdin ).

    memoryindex = 1.

  ENDMETHOD.

  METHOD set_source.

    DO strlen( source ) TIMES.
      DATA(index) = sy-index + 1.

      APPEND substring( val = source off = sy-index - 1 len = 1 ) TO me->source.
    ENDDO.

    sourceindex = 1.

  ENDMETHOD.

  METHOD set_stdin.

    DO strlen( stdin ) TIMES.
      DATA(index) = sy-index + 1.

      APPEND substring( val = stdin off = sy-index - 1 len = 1 ) TO me->stdin.
    ENDDO.

    stdinindex = 1.

  ENDMETHOD.

  METHOD get_stdout.
    stdout = me->stdout.
  ENDMETHOD.

  METHOD append_to_stdout.

    DATA char2output TYPE char1.
    DATA(fieldvalue) = memory[ key = memoryindex ]-value.

    IF ( fieldvalue = 32 ).

      stdout = stdout && ` `.

    ELSE.

      cl_abap_conv_in_ce=>create( encoding = 'UTF-8' )->convert( EXPORTING input = CONV #( fieldvalue )
                                                       IMPORTING data  = char2output ).

      stdout = |{ stdout }{ char2output }|.

    ENDIF.
  ENDMETHOD.

  METHOD process.

    DATA exit_program TYPE abap_bool VALUE abap_false.
    DATA current_command TYPE char1.
    DATA temp_command TYPE char1.
    DATA fieldvalue TYPE int4 VALUE 0.

    WHILE exit_program <> abap_true.

      IF ( line_exists( me->source[ sourceindex ] ) ).
        current_command = me->source[ sourceindex ].


        CASE current_command.

          WHEN '>'.
            memoryindex += 1.

          WHEN '<'.
            memoryindex -= 1.

          WHEN '+'.
            increment_current_cell(  ).

          WHEN '-'.
            decrement_current_cell(  ).

          WHEN '.'.
            append_to_stdout( ).

          WHEN ','.
            FIELD-SYMBOLS : <conver_fs> TYPE x.

            IF ( NOT line_exists( stdin[ stdinindex ] ) ).
              WRITE: |Missing STDIN Data|.
              RETURN.
            ENDIF.

            ASSIGN stdin[ stdinindex ] TO <conver_fs> CASTING.

            memory[ key = memoryindex ]-value = <conver_fs>.

            stdinindex += 1.

          WHEN '['.
            fieldvalue = 0.
            IF ( line_exists( memory[ key = memoryindex ] ) ).
              fieldvalue = memory[ key = memoryindex ]-value.
            ENDIF.

            IF ( fieldvalue = 0 ).
              temp_command = ''.
              WHILE temp_command <> ']'.
                sourceindex += 1.

                IF ( NOT line_exists( me->source[ sourceindex ] ) ).
                  stdout = |Syntax Error|.
                  RETURN.
                ENDIF.

                temp_command = me->source[ sourceindex ].
              ENDWHILE.
            ENDIF.

          WHEN ']'.
            fieldvalue = 0.
            IF ( line_exists( memory[ key = memoryindex ] ) ).
              fieldvalue = memory[ key = memoryindex ]-value.
            ENDIF.

            IF ( fieldvalue <> 0 ).
              temp_command = ''.
              WHILE temp_command <> '['.
                sourceindex -= 1.

                IF ( NOT line_exists( me->source[ sourceindex ] ) ).
                  stdout = |Syntax Error|.
                  RETURN.
                ENDIF.

                temp_command = me->source[ sourceindex ].
              ENDWHILE.
            ENDIF.

          WHEN OTHERS.
            "ignore.
        ENDCASE.

        sourceindex += 1.
      ELSE.
        exit_program = abap_true.
      ENDIF.

    ENDWHILE.

  ENDMETHOD.

ENDCLASS.
