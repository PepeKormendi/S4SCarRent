@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VH currency ex'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZSZAKD_I_CUR_EXVH
  as select from ZSZAKD_I_CUR_EX
{
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @UI.lineItem: [{ position: 10, importance: #HIGH }]
  key CurrencyCode,
      @UI.lineItem: [{ position: 20, importance: #HIGH }]
      ExchangeRate
}
