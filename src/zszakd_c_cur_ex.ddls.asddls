@EndUserText.label: 'valkutaváltás projection nézet'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@Search.searchable: true
@ObjectModel.semanticKey: ['CurrencyCode']
define root view entity ZSZAKD_C_CUR_EX
  provider contract transactional_query
  as projection on ZSZAKD_I_CUR_EX
{
      @Search.defaultSearchElement: true
  key CurrencyCode,
      ExchangeRate
}
