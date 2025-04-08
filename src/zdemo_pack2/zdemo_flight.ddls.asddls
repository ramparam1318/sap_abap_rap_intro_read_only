@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'flight interface view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zdemo_flight
  as select from /dmo/flight
  association [1] to zdemo_carrier as _airline on $projection.CarrierId = _airline.CarrierId
{
      @UI.lineItem: [{ position:10}]
      @ObjectModel.text.association: '_airline'
  key carrier_id     as CarrierId,
      @UI.lineItem: [{ position:20}]
  key connection_id  as ConnectionId,
      @UI.lineItem: [{ position:30}]
  key flight_date    as FlightDate,
      @UI.lineItem: [{ position:40}]
      @Semantics.amount.currencyCode: 'currencyCode'
      price          as Price,
      currency_code  as CurrencyCode,
      @UI.lineItem: [{ position:50}]
      plane_type_id  as PlaneTypeId,
      @UI.lineItem: [{ position:60}]
      seats_max      as SeatsMax,
      @UI.lineItem: [{ position:70}]
      seats_occupied as SeatsOccupied,
      _airline
}
