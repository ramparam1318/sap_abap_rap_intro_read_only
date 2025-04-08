CLASS zcl_demo_pac2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_demo_pac2 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    TYPES : ty_tab TYPE TABLE OF ztdemo_pack WITH DEFAULT KEY.
    DATA(it_tab) = VALUE ty_tab( ( client = 100 empid = 1 empname = 'emp1' )
    ( client = 100 empid = 2 empname = 'emp2' )
    ( client = 100 empid = 3  empname = 'emp3' ) ).

    IF sy-subrc IS INITIAL.
      INSERT ztdemo_pack FROM TABLE @it_tab.
      IF sy-subrc IS INITIAL.
        out->write( 'ghus gaya' ).
      ENDIF.
    ENDIF.

  ENDMETHOD.
ENDCLASS.









