@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help for Cars'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSZAKD_I_VH_CARS
  as select from zszakd_cars
{
      @Semantics.text: true
  key brand             as Brand,
      max( kilometers ) as Km

}
group by
  brand,
  kilometers
