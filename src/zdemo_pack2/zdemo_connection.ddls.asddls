@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CONNECTION DEMO'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

@UI.headerInfo:{
typeName:'',
typeNamePlural:'Connections'
}
define view entity ZDEMO_CONNECTION
  as select from /dmo/connection as connection
  association [1..*] to zdemo_flight  as _FLIGHT  on  $projection.CarrierId    = _FLIGHT.CarrierId
                                                  and $projection.ConnectionId = _FLIGHT.ConnectionId
  association [1]    to zdemo_carrier as _airline on  $projection.CarrierId = _airline.CarrierId
{
      @UI.facet: [{ id:'connection',
      purpose: #STANDARD,
      type:#IDENTIFICATION_REFERENCE,
      position:10,
      label: 'connections details' },

      { id:'flight',
      purpose: #STANDARD,
      type:#LINEITEM_REFERENCE,
      position:20,
      label: 'flight details',
      targetElement:'_FLIGHT'
      }]

      @UI.lineItem: [{ position:10, label:'Airline'}]
      @UI.identification: [{ position: 10, label:'jahaz ka naam' }]
      @ObjectModel.text.association: '_airline'
      @Search.defaultSearchElement: true
  key carrier_id      as CarrierId,
      @UI.lineItem: [{ position:20 }]
      @UI.identification: [{ position: 20 }]
      @Search.defaultSearchElement: true
  key connection_id   as ConnectionId,
      @UI.lineItem: [{ position:30, label:'departure id' }]
      @UI.selectionField: [{ position:10}]
      @UI.identification: [{ position: 30, label:'departure id' }]
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{ entity:{
      name: 'zdemo_airport',
      element: 'AirportId'
      } }]
      airport_from_id as AirportFromId,
      @UI.lineItem: [{ position:40 }]
      @UI.selectionField: [{ position:20 }]
      @UI.identification: [{ position: 40 }]
      @Consumption.valueHelpDefinition: [{ entity:{
      name: 'zdemo_airport',
      element: 'AirportId'
      } }]
      @EndUserText.label:'destination airport id'
      airport_to_id   as AirportToId,
      @UI.lineItem: [{ position:50, label:'Departure time' }]
      @UI.identification: [{ position: 50 }]
      departure_time  as DepartureTime,
      @UI.lineItem: [{ position:60, label:'Arrival time'}]
      @UI.identification: [{ position: 60 }]
      arrival_time    as ArrivalTime,
      @Semantics.quantity.unitOfMeasure: 'DistanceUnit'
      distance        as Distance,
      distance_unit   as DistanceUnit,
      //      expose association
      _FLIGHT,
      @Search.defaultSearchElement: true
      _airline
}
