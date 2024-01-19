@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help for Cars'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSZAKD_I_VH_FIRSTNAME
  as select from zszakd_customer
{
      @Semantics.text: true
  key first_name         as FirstName,
      max( postal_code ) as PostalCode

}
group by
  first_name,
  postal_code
