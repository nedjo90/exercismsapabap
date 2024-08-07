*&---------------------------------------------------------------------*
*& Include z_testing_nehan_cl
*&---------------------------------------------------------------------*

CLASS zcl_high_scores DEFINITION.
*  PUBLIC
*  FINAL
*  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    METHODS constructor
      IMPORTING
        scores TYPE integertab.

    METHODS list_scores
      RETURNING
        VALUE(result) TYPE integertab.

    METHODS latest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personalbest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personaltopthree
      RETURNING
        VALUE(result) TYPE integertab.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA scores_list TYPE integertab.

ENDCLASS.


CLASS zcl_high_scores IMPLEMENTATION.

  METHOD constructor.
    me->scores_list = scores.
  ENDMETHOD.

  METHOD list_scores.
    result = scores_list.
  ENDMETHOD.

  METHOD latest.
    " add solution here
    result = scores_list[ lines( scores_list ) ].
  ENDMETHOD.

  METHOD personalbest.
    " add solution here

    result = scores_list[ 1 ].

    LOOP AT scores_list INTO DATA(wa).
      IF wa > result.
        result = wa.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD personaltopthree.
    " add solution here

    " better solution
    DATA(list) = scores_list.
    SORT list BY table_line DESCENDING.

* better loop (modern)

 result = value #( for i = 1 while i < 4 and i <= lines( list ) ( list[ i ] ) ).

* Different modern loop

*    DO COND i( WHEN lines( list ) < 3 THEN lines( list ) ELSE 3 ) TIMES.
*      APPEND list[ sy-index ] TO result.
*    ENDDO.

* oldschool loop

*    LOOP AT list INTO DATA(wa).
*      IF sy-tabix > 3.
*        EXIT.
*      ENDIF.
*      APPEND wa TO result.
*    ENDLOOP.


* tricked

*    DELETE list from 4.
*    
*    result = list.



    " traditional sorting

*    DATA(_i) = 1.
*    DATA(_j) = 1.
*    DATA(tmp) = scores_list[ _i ].
*    DATA(tab_len) = lines( scores_list ).
*    WHILE _i <= tab_len.
*      _j = _i.
*      WHILE _j <= tab_len.
*        IF scores_list[ _j ] > scores_list[ _i ].
*          tmp = scores_list[ _j ].
*          scores_list[ _j ] = scores_list[ _i ].
*          scores_list[ _i ] = tmp.
*        ENDIF.
*        _j += 1.
*      ENDWHILE.
*      _i += 1.
*    ENDWHILE.
*    _i = 1.
*    WHILE _i < 4 AND _i <= tab_len.
*      APPEND INITIAL LINE TO result.
*      result[ _i ] = scores_list[ _i ].
*      _i += 1.
*    ENDWHILE.
  ENDMETHOD.

ENDCLASS.
