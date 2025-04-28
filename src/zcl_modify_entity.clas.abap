CLASS zcl_modify_entity DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_modify_entity IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    MODIFY ENTITY zi_travel_cds_124
    CREATE FROM VALUE #( ( %cid = 'cid123'
                           %data-BeginDate = '20250202'
                           %control-BeginDate = if_abap_behv=>mk-on
                       ) )
    FAILED FINAL(it_failed)
    MAPPED FINAL(it_mapped)
    REPORTED FINAL(it_result).


    IF it_failed IS NOT INITIAL.
      out->write( it_failed ).
    ELSE.

      "need to have to reflect change in db
      COMMIT ENTITIES.
      out->write( it_mapped-zi_travel_cds_124 ).

    ENDIF.


  ENDMETHOD.
ENDCLASS.
