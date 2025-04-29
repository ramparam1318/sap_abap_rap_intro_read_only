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

    DATA : lt_booking TYPE TABLE FOR CREATE zi_travel_cds_124\_booking.

    MODIFY ENTITY zi_travel_cds_124
    CREATE FROM VALUE #( ( %cid = 'cid123'
                           %data-BeginDate = '20250202'
                           %control-BeginDate = if_abap_behv=>mk-on
                       ) )
    CREATE BY \_booking
    FROM VALUE #( ( %cid_ref = 'cid123'
                    %target = VALUE #( ( %cid = 'cid121'
                                         BookingDate = '20250202'
                                         %control-BookingDate = if_abap_behv=>mk-on
                                     ) )
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

    IF lines( it_mapped-zi_travel_cds_124 ) = 1.


      "will trigger get instance authorization
      MODIFY ENTITY zi_travel_cds_124
*    DELETE FROM VALUE #( ( %key-TravelId = '00005308' ) )
      DELETE FROM VALUE #( ( %key-TravelId = it_mapped-zi_travel_cds_124[ 1 ]-%key-TravelId ) )
      FAILED FINAL(it_failed1)
      MAPPED FINAL(it_mapped1)
      REPORTED FINAL(it_result1).

      IF it_failed1 IS NOT INITIAL.
        out->write( it_failed1 ).
      ELSE.

        "need to have to reflect change in db
        COMMIT ENTITIES.
        out->write( it_mapped1-zi_travel_cds_124 ).

      ENDIF.

    ENDIF.

    "***************************************************************************
    "delete only child entity
    MODIFY ENTITY zi_booking_cds_124
      DELETE FROM VALUE #( ( %key-TravelId = '00005313'
                             %key-BookingId = '0010'
                         ) )
      FAILED FINAL(it_failed2)
      MAPPED FINAL(it_mapped2)
      REPORTED FINAL(it_result2).

    IF it_failed2 IS NOT INITIAL.
      out->write( it_failed2 ).
    ELSE.

      "need to have to reflect change in db
      COMMIT ENTITIES.
      out->write( it_mapped2-zi_travel_cds_124 ).

    ENDIF.

    "***************************************************************************
    MODIFY ENTITY zi_travel_cds_124
      CREATE AUTO FILL CID WITH VALUE #( (
                                            %data-BeginDate = '20250404'
                                            %control-BeginDate = if_abap_behv=>mk-on
                                       ) )
      FAILED FINAL(it_failed3)
      MAPPED FINAL(it_mapped3)
      REPORTED FINAL(it_result3).

    IF it_failed3 IS NOT INITIAL.
      out->write( it_failed3 ).
    ELSE.

      "need to have to reflect change in db
      COMMIT ENTITIES.
      out->write( it_mapped3-zi_travel_cds_124 ).

    ENDIF.


    "***************************************************************************
*update entity
    MODIFY ENTITIES OF zi_travel_cds_124
    ENTITY zi_travel_cds_124
    UPDATE FIELDS ( BeginDate )
    WITH VALUE #( ( %key-TravelId = '00005313'
                    BeginDate = '20240202'
                ) ).
    COMMIT ENTITIES.


    "***************************************************************************
*update multiple entity at a time

    MODIFY ENTITIES OF zi_travel_cds_124
    ENTITY zi_travel_cds_124
    UPDATE FIELDS ( BeginDate )
    WITH VALUE #( ( %key-TravelId = '00005313'
                    BeginDate = '20240202'
                ) )
    ENTITY zi_travel_cds_124
    DELETE FROM VALUE #( ( TravelId = '00005319' ) )
                .
    COMMIT ENTITIES.


    "***************************************************************************
*take more time
    MODIFY ENTITY zi_travel_cds_124
    UPDATE SET FIELDS WITH VALUE #( ( %key-TravelId = '00005313'
                                      BeginDate = '20250202'
                                  ) ).

    COMMIT ENTITIES.


  ENDMETHOD.
ENDCLASS.



