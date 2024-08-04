CLASS zcl_itab_aggregation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES group TYPE c LENGTH 1.
    TYPES: BEGIN OF initial_numbers_type,
             group  TYPE group,
             number TYPE i,
           END OF initial_numbers_type,
           initial_numbers TYPE STANDARD TABLE OF initial_numbers_type WITH EMPTY KEY.

    TYPES: BEGIN OF aggregated_data_type,
             group   TYPE group,
             count   TYPE i,
             sum     TYPE i,
             min     TYPE i,
             max     TYPE i,
             average TYPE f,
           END OF aggregated_data_type,
           aggregated_data TYPE STANDARD TABLE OF aggregated_data_type WITH EMPTY KEY.

    METHODS perform_aggregation
      IMPORTING
        initial_numbers        TYPE initial_numbers
      RETURNING
        VALUE(aggregated_data) TYPE aggregated_data.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_itab_aggregation IMPLEMENTATION.
  METHOD perform_aggregation.
    " add solution here
    DATA:
      sum     TYPE i,
      min     TYPE i,
      max     TYPE i,
      i       TYPE  i,
      average TYPE f.

    LOOP AT initial_numbers INTO DATA(wa)
    GROUP BY ( group = wa-group
        index = GROUP INDEX
        size = GROUP SIZE )
        ASCENDING
    ASSIGNING FIELD-SYMBOL(<group>).
      CLEAR : sum.
      CLEAR : min.
      CLEAR : max.
      i = 0.
      LOOP AT GROUP <group> ASSIGNING FIELD-SYMBOL(<ls_member>).
        sum += <ls_member>-number.
        IF i = 0.
          max = <ls_member>-number.
        ELSEIF <ls_member>-number > max.
          max = <ls_member>-number.
        ENDIF.
        IF i = 0.
          min = <ls_member>-number.
        ELSEIF <ls_member>-number < min.
          min = <ls_member>-number.
        ENDIF.
        i += 1.
      ENDLOOP.
      average = sum / <group>-size.
      APPEND VALUE #(
                    group   = <group>-group
                    count   = <group>-size
                    sum     = sum
                    min     = min
                    max     = max
                    average = average
      ) TO aggregated_data.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

