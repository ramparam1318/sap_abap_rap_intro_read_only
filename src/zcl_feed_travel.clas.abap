CLASS zcl_feed_travel DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_feed_travel IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*  select * from /dmo/travel into table @data(it_travel).

    INSERT ztravel_m_124 FROM ( SELECT * FROM /dmo/travel ).

    INSERT zbooking_m_124 FROM ( SELECT * FROM /dmo/booking ).

    INSERT zbook_sup_m_124 FROM ( SELECT * FROM /dmo/booksuppl_m ).


  ENDMETHOD.
ENDCLASS.
