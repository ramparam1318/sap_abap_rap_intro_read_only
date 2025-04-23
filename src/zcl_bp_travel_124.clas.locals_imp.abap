CLASS lhc_zi_travel_cds_124 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_travel_cds_124 RESULT result.
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

ENDCLASS.
