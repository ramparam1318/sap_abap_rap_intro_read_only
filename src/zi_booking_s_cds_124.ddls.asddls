@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'booking sup interface cds'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zi_booking_s_cds_124
  as select from zbook_sup_m_124
  association        to parent zi_booking_cds_124 as _booking        on  $projection.TravelId  = _booking.TravelId
                                                                     and $projection.BookingId = _booking.BookingId
  association [1..1] to zi_travel_cds_124         as _travel         on  $projection.TravelId = _travel.TravelId
  association [1..1] to /DMO/I_Supplement         as _supplement     on  $projection.SupplementId = _supplement.SupplementID
  association [1..*] to /DMO/I_SupplementText     as _supplementtext on  $projection.SupplementId = _supplementtext.SupplementID
{
  key travel_id             as TravelId,
  key booking_id            as BookingId,
  key booking_supplement_id as BookingSupplementId,
      supplement_id         as SupplementId,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price                 as Price,
      currency_code         as CurrencyCode,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at       as LastChangedAt,
      _travel,
      _supplement,
      _supplementtext,
      _booking
}
