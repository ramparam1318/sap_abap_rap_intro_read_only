@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'booking interface cds'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zi_booking_cds_124
  as select from zbooking_m_124
  association        to parent zi_travel_cds_124 as _travel     on  $projection.TravelId = _travel.TravelId
  composition [0..*] of zi_booking_s_cds_124     as _book_sup
  association [1..1] to /DMO/I_Carrier           as _carrier    on  $projection.CarrierId = _carrier.AirlineID
  association [1..1] to /DMO/I_Customer          as _customer   on  $projection.CustomerId = _customer.CustomerID
  association [1..1] to /DMO/I_Connection        as _connection on  $projection.CarrierId    = _connection.AirlineID
                                                                and $projection.ConnectionId = _connection.ConnectionID
  association [1..1] to /DMO/I_Booking_Status_VH as _status     on  $projection.BookingStatus = _status.BookingStatus

{
  key travel_id       as TravelId,
  key booking_id      as BookingId,
      booking_date    as BookingDate,
      customer_id     as CustomerId,
      carrier_id      as CarrierId,
      connection_id   as ConnectionId,
      flight_date     as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      flight_price    as FlightPrice,
      currency_code   as CurrencyCode,
      booking_status  as BookingStatus,
      last_changed_at as LastChangedAt,
      _carrier,
      _customer,
      _connection,
      _status,
      _travel,
      _book_sup
}
