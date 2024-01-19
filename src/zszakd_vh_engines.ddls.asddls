@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value help for film genre'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity ZSZAKD_VH_ENGINES
  as select from dd07t
{
    @ObjectModel.text.element: ['Text']
     key cast( domvalue_l as zszakd_engine_type ) as Enginetype,
     key ddlanguage                                  as lang,   
      @Semantics.text: true
      ddtext                                         as Text

}
where domname = 'ZSZAKD_ENGINE_TYPE'
