@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'comsumption cds view for composition'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity zc_booking_cds_124
  as projection on zi_booking_cds_124
{
  key TravelId,
  key BookingId,
      BookingDate,
      @ObjectModel.text.element: [ 'customername' ]
      CustomerId,
      _customer.LastName as customername,
      @ObjectModel.text.element: [ 'carriername' ]
      CarrierId,
      _carrier.Name      as carriername,
      ConnectionId,
      FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      FlightPrice,
      CurrencyCode,
      @ObjectModel.text.element: [ 'book_sta' ]
      BookingStatus,
      _status._Text.Text as book_sta : localized,
      LastChangedAt,
      /* Associations */
      _book_sup : redirected to composition child zc_booking_s_cds_124,
      _carrier,
      _connection,
      _customer,
      _status,
      _travel   : redirected to parent zc_travel_cds_124
}
