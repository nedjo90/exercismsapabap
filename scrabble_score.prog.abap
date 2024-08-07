CLASS zcl_scrabble_score DEFINITION PUBLIC .

  PUBLIC SECTION.
    METHODS score
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_scrabble_score IMPLEMENTATION.
  METHOD score.
    " add solution here
        TYPES: BEGIN OF ls_score,
             char  TYPE c,
             score TYPE i,
           END OF ls_score,
           lt_c TYPE STANDARD TABLE OF ls_score WITH EMPTY KEY.

    DATA(one) = VALUE lt_c(
                                    ( char = 'A' score = 1 )
                                    ( char = 'E' score = 1 )
                                    ( char = 'I' score = 1 )
                                    ( char = 'O' score = 1 )
                                    ( char = 'U' score = 1 )
                                    ( char = 'L' score = 1 )
                                    ( char = 'N' score = 1 )
                                    ( char = 'R' score = 1 )
                                    ( char = 'S' score = 1 )
                                    ( char = 'T' score = 1 )
                                    ( char = 'D' score = 2 )
                                    ( char = 'G' score = 2 )
                                    ( char = 'B' score = 3 )
                                    ( char = 'C' score = 3 )
                                    ( char = 'M' score = 3 )
                                    ( char = 'P' score = 3 )
                                    ( char = 'F' score = 4 )
                                    ( char = 'H' score = 4 )
                                    ( char = 'V' score = 4 )
                                    ( char = 'W' score = 4 )
                                    ( char = 'Y' score = 4 )
                                    ( char = 'K' score = 5 )
                                    ( char = 'J' score = 8 )
                                    ( char = 'X' score = 8 )
                                    ( char = 'Q' score = 10 )
                                    ( char = 'Z' score = 10 )
                          ).

    DATA(_u) = to_upper( input ).
    result = 0.
    DATA(ind) = 0.
    DO strlen( _u ) TIMES.
      READ TABLE one INTO DATA(wa) WITH KEY char = _u+ind(1).
      IF wa IS NOT INITIAL.
        result += wa-score.
      ENDIF.
      ind += 1.
    ENDDO.
  ENDMETHOD.

ENDCLASS.

