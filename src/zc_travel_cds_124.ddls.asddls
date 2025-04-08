@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'project cds for travel'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zc_travel_cds_124
  provider contract transactional_query
  as projection on zi_travel_cds_124
{
  key TravelId,
      AgencyId,
      CustomerId,
      BeginDate,
      EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      TotalPrice,
      CurrencyCode,
      Description,
      OverallStatus,
      //      CreatedBy,
      //      CreatedAt,
      //      LastChangedBy,
      LastChangedAt,
      /* Associations */
      _agency,
      _booking : redirected to composition child zc_booking_cds_124,
      _currency,
      _customer,
      _status
}
