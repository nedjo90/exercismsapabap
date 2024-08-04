CLASS zcl_itab_combination DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF alphatab_type,
             cola TYPE string,
             colb TYPE string,
             colc TYPE string,
           END OF alphatab_type.
    TYPES alphas TYPE STANDARD TABLE OF alphatab_type.

    TYPES: BEGIN OF numtab_type,
             col1 TYPE string,
             col2 TYPE string,
             col3 TYPE string,
           END OF numtab_type.
    TYPES nums TYPE STANDARD TABLE OF numtab_type.

    TYPES: BEGIN OF combined_data_type,
             colx TYPE string,
             coly TYPE string,
             colz TYPE string,
           END OF combined_data_type.
    TYPES combined_data TYPE STANDARD TABLE OF combined_data_type WITH EMPTY KEY.

    METHODS perform_combination
      IMPORTING
        alphas             TYPE alphas
        nums               TYPE nums
      RETURNING
        VALUE(combined_data) TYPE combined_data.

  PROTECTED SECTION.
  PRIVATE SECTION.


ENDCLASS.

CLASS zcl_itab_combination IMPLEMENTATION.

  METHOD perform_combination.
    DATA: index      TYPE i VALUE 1,
          max_length TYPE i,
          wa         TYPE combined_data_type.
    max_length = lines( alphas ).
    IF max_length < lines( nums ).
      max_length = lines( nums ).
    ENDIF.
    WHILE index <= max_length.
      APPEND INITIAL LINE TO combined_data REFERENCE INTO DATA(wa_c).
      READ TABLE alphas INDEX index INTO DATA(wa_a).
      READ TABLE nums INDEX index INTO DATA(wa_n).
      CONCATENATE wa_a-cola wa_n-col1 INTO wa_c->colx.
      CONCATENATE wa_a-colb wa_n-col2 INTO wa_c->coly.
      CONCATENATE wa_a-colc wa_n-col3 INTO wa_c->colz.
      index += 1.
    ENDWHILE. 

* meilleur solution
*  combined_data = VALUE #( for i = 1 until i > lines( alphas ) or i > lines( nums )
*    (
*     colx = |{ alphas[ i ]-cola }{ nums[ i ]-col1 }|
*     coly = |{ alphas[ i ]-colb }{ nums[ i ]-col2 }|
*     colz = |{ alphas[ i ]-colc }{ nums[ i ]-col3 }|
* )
*   ).


  ENDMETHOD.

ENDCLASS.

