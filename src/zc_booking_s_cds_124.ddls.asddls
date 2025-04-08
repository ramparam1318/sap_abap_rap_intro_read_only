@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'booking sup cds projection'
@Metadata.ignorePropagatedAnnotations: true
define view entity zc_booking_s_cds_124
  as projection on zi_booking_s_cds_124
{
  key TravelId,
  key BookingId,
  key BookingSupplementId,
      SupplementId,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
      CurrencyCode,
      LastChangedAt,
      /* Associations */
      _booking :  redirected to parent zc_booking_cds_124,
      _supplement,
      _supplementtext,
      _travel : redirected to ZC_TRAVEL_cds_124
}
