CLASS zcl_read_entity DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_read_entity IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*    READ ENTITY zc_travel_cds_124
*    FROM VALUE #( ( %key-travelid = '00000115'
*                    %control = VALUE #( AgencyId = if_abap_behv=>mk-on
*                                        CustomerId = if_abap_behv=>mk-on
*                                        BeginDate = if_abap_behv=>mk-on
*                                      )
*                  )
*                )
*    RESULT DATA(lt_result)
*    FAILED DATA(lt_failed).


*    READ ENTITY zi_travel_cds_124
**    BY \_booking
*    ALL FIELDS
*    WITH VALUE #( ( %key-travelid = '00000115' )
*                  ( %key-travelid = '00000021' )
*                )
*    RESULT DATA(lt_result)
*    FAILED DATA(lt_failed).
*
*    IF lt_failed IS NOT INITIAL.
*      out->write( 'failed' ).
*    ELSE.
*      out->write( lt_result
**      EXPORTING
**        data   =
*      ).
*    ENDIF.


*===========================================================================
*read multiple entity

*    READ ENTITIES OF zi_travel_cds_124
*
*    ENTITY zi_travel_cds_124
*    ALL FIELDS
*    WITH VALUE #( ( %key-travelid = '00000115' )
*                      ( %key-travelid = '00000021' )
*                    )
*
*    RESULT DATA(lt_result)
*
*    ENTITY zi_booking_cds_124
*    ALL FIELDS
*    WITH VALUE #( ( %key-travelid = '00000115'
*                     %key-Bookingid = '001'
*                   )
*                 )
*    RESULT DATA(lt_result1)
*
*    ENTITY zi_booking_s_cds_124
*    ALL FIELDS
*    WITH VALUE #( ( %key-travelid = '00000115'
*                     %key-Bookingid = '001'
*                     %key-BookingSupplementId = '01'
*                   )
*                 )
*    RESULT DATA(lt_result2)
*
*    FAILED DATA(lt_failed).
*
*
*    IF lt_failed IS NOT INITIAL.
*      out->write( 'failed' ).
*    ELSE.
*      out->write( lt_result
**      EXPORTING
**        data   =
*      ).
*      out->write( lt_result1 ).
*      out->write( lt_result2 ).
*    ENDIF.

*=================================================================
*dynamic read syntax


    DATA : it_oper_tab      TYPE abp_behv_retrievals_tab,
           it_travel        TYPE TABLE FOR READ IMPORT zi_travel_cds_124,
           it_travel_result TYPE TABLE FOR READ RESULT zi_travel_cds_124.

    it_travel = VALUE #( ( %key-TravelId = '00000115'
                           %control = VALUE #( AgencyId = if_abap_behv=>mk-on
                                               CustomerId = if_abap_behv=>mk-on
                                               BeginDate = if_abap_behv=>mk-on
                                             )
                         )
                       ).

    it_oper_tab = VALUE #( ( op = if_abap_behv=>op-r
                             entity_name = 'ZI_TRAVEL_CDS_124'
                             instances = REF #( it_travel )
                             results = REF #( it_travel_result )
                           )
                         ).

    READ ENTITIES
    OPERATIONS it_oper_tab
    FAILED DATA(lt_failed_dyn).

    out->write( it_travel_result ).


  ENDMETHOD.
ENDCLASS.



