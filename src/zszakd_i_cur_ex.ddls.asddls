@EndUserText.label: 'valkutaváltás composite nézet'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZSZAKD_I_CUR_EX
  as select from zszakd_curren_ex
{

  key currency_code as CurrencyCode,

      exchange_rate as ExchangeRate
      
}
