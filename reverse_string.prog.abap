CLASS zcl_reverse_string DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS reverse_string
      IMPORTING
        input         TYPE string
      RETURNING
        VALUE(result) TYPE string.
ENDCLASS.

CLASS zcl_reverse_string IMPLEMENTATION.

  METHOD reverse_string.
    " Please complete the implementation of the reverse_string method
    DATA: len   TYPE i.

    len = strlen( input ) - 1.
    result = ''.
    WHILE len >= 0.
      CONCATENATE result input+len(1) INTO result.
      len -= 1.
    ENDWHILE.
  ENDMETHOD.

ENDCLASS.

