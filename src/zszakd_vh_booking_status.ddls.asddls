@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Foglalás státusz keresési segítség'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZSZAKD_VH_BOOKING_STATUS
  as select from dd07t
{  
    @ObjectModel.text.element: ['Text']
     key cast( domvalue_l as zszakd_booking_status ) as BookingStatus,
     key ddlanguage                                  as lang,   
      @Semantics.text: true
      ddtext                                         as Text

}
where
      domname    = 'ZSZAKD_BOOKING_STATUS'

