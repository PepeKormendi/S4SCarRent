@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help for Cars'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSZAKD_I_VH_CUSTOMERALL
  as select from zszakd_customer
{
       @Semantics.text: true
  key  last_name          as LastName,
  key  max( postal_code ) as PostalCode,
       customer_uuid      as CustomerUuid

}
group by
  last_name,
  postal_code,
  customer_uuid
