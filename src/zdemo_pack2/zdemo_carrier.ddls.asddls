@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'carrier view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zdemo_carrier
  as select from /dmo/carrier
{
  key carrier_id    as CarrierId,
      @Semantics.text: true
      name          as Name,
      currency_code as CurrencyCode
      //    local_created_by as LocalCreatedBy,
      //    local_created_at as LocalCreatedAt,
      //    local_last_changed_by as LocalLastChangedBy,
      //    local_last_changed_at as LocalLastChangedAt,
      //    last_changed_at as LastChangedAt
}
