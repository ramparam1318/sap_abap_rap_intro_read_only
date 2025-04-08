CLASS zcl_demo_pac1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_demo_pac1 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    out->write( 'ram ram' ).
    DATA : lv_var1 TYPE REF TO string.
    CREATE DATA : lv_var1.

    ASSIGN lv_var1->* TO FIELD-SYMBOL(<fs>).

    <fs> = 'ram'.

    out->write( lv_var1->* ).




    TYPES : ty_tab TYPE TABLE OF ztdemo_pack WITH DEFAULT KEY.
    DATA : it_tab TYPE REF TO ztdemo_pack.

    DATA(it_tab1) = NEW ty_tab( ( client = 100 empid = 1 empname = 'emp1' )
    ( client = 100 empid = 2 empname = 'emp2' ) ).

    DATA(it_tab2) = VALUE ty_tab( ( client = 100 empid = 1 empname = 'emp1' )
    ( client = 100 empid = 2 empname = 'emp2' ) ).

    out->write( it_tab1->* ).
    out->write( it_tab2 ).

  ENDMETHOD.
ENDCLASS.
