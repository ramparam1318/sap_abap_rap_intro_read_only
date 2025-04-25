CLASS lhc_zi_travel_cds_124 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_travel_cds_124 RESULT result.
    METHODS accept_travel FOR MODIFY
      IMPORTING keys FOR ACTION zi_travel_cds_124~accept_travel RESULT result.

    METHODS copy_travel FOR MODIFY
      IMPORTING keys FOR ACTION zi_travel_cds_124~copy_travel.

    METHODS recal_total_price FOR MODIFY
      IMPORTING keys FOR ACTION zi_travel_cds_124~recal_total_price.

    METHODS reject_travel FOR MODIFY
      IMPORTING keys FOR ACTION zi_travel_cds_124~reject_travel RESULT result.
    METHODS earlynumbering_cba_booking FOR NUMBERING
      IMPORTING entities FOR CREATE zi_travel_cds_124\_booking.
    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE zi_travel_cds_124.

ENDCLASS.

CLASS lhc_zi_travel_cds_124 IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.
    DATA(lt_entities) = entities.

    DELETE lt_entities WHERE TravelId IS NOT INITIAL.

    TRY.
        cl_numberrange_runtime=>number_get(
          EXPORTING
*      ignore_buffer     =
            nr_range_nr       = '01'
            object            = '/DMO/TRV_M'
            quantity          = CONV #( lines( lt_entities ) )
*      subobject         =
*      toyear            =
          IMPORTING
            number            = DATA(lv_last_num)
            returncode        = DATA(lv_return)
            returned_quantity = DATA(lv_ret_qty)
        ).
      CATCH cx_nr_object_not_found.
      CATCH cx_number_ranges INTO DATA(lo_error).

        LOOP AT lt_entities INTO DATA(ls_entities).

          APPEND VALUE #( %cid = ls_entities-%cid
                          %key = ls_entities-%key
                        ) TO failed-zi_travel_cds_124.

          APPEND VALUE #( %cid = ls_entities-%cid
                                    %key = ls_entities-%key
                                    %msg = lo_error
                                  ) TO reported-zi_travel_cds_124.
        ENDLOOP.
        EXIT.
    ENDTRY.

    ASSERT lv_ret_qty = lines( lt_entities ).

    DATA : lt_travel TYPE TABLE FOR MAPPED EARLY zi_travel_cds_124,
           ls_travel LIKE LINE OF lt_travel.

    DATA(lv_curr_no) = lv_last_num - lv_ret_qty.

    LOOP AT lt_entities INTO DATA(wa_entities).
      lv_curr_no += 1.
      APPEND VALUE #( %cid = wa_entities-%cid
                           TravelId = lv_curr_no
                         ) TO mapped-zi_travel_cds_124.



    ENDLOOP.

  ENDMETHOD.

  METHOD earlynumbering_cba_Booking.

    DATA : lv_max_booking TYPE /dmo/booking_id.

    READ ENTITIES OF zi_travel_cds_124 IN LOCAL MODE
     ENTITY zi_travel_cds_124 BY \_booking
     FROM CORRESPONDING #( entities )
     LINK DATA(lt_link_data).

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<ls_group_entity>)
                               GROUP BY <ls_group_entity>-TravelId .


      lv_max_booking = REDUCE #( INIT lv_max = CONV /dmo/booking_id( '0' )
                                 FOR ls_link IN lt_link_data USING KEY entity
                                      WHERE ( source-TravelId = <ls_group_entity>-TravelId  )
                                 NEXT  lv_max = COND  /dmo/booking_id( WHEN lv_max < ls_link-target-BookingId
                                                                       THEN ls_link-target-BookingId
                                                                        ELSE lv_max ) ).

      "useful for draft scenario
      lv_max_booking  = REDUCE #( INIT lv_max = lv_max_booking
                                   FOR ls_entity IN entities USING KEY entity
                                       WHERE ( TravelId = <ls_group_entity>-TravelId  )
                                     FOR ls_booking IN ls_entity-%target
                                     NEXT lv_max = COND  /dmo/booking_id( WHEN lv_max < ls_booking-BookingId
                                                                        THEN ls_booking-BookingId
                                                                         ELSE lv_max )
       ).

      LOOP AT entities ASSIGNING FIELD-SYMBOL(<ls_entities>)
                        USING KEY entity
                         WHERE TravelId = <ls_group_entity>-TravelId.

        LOOP AT <ls_entities>-%target ASSIGNING FIELD-SYMBOL(<ls_booking>).
          APPEND CORRESPONDING #( <ls_booking> )  TO   mapped-zi_booking_cds_124
             ASSIGNING FIELD-SYMBOL(<ls_new_map_book>).
          IF <ls_booking>-BookingId IS INITIAL.
            lv_max_booking += 10.


            <ls_new_map_book>-BookingId = lv_max_booking.
          ENDIF.

        ENDLOOP.



      ENDLOOP.

    ENDLOOP.

  ENDMETHOD.

  METHOD accept_travel.
  ENDMETHOD.

  METHOD copy_travel.
  ENDMETHOD.

  METHOD recal_total_price.
  ENDMETHOD.

  METHOD reject_travel.
  ENDMETHOD.

ENDCLASS.
