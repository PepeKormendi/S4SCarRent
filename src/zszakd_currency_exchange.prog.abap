*&---------------------------------------------------------------------*
*& Report ZSZAKD_CURRENCY_EXCHANGE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zszakd_currency_exchange.

DATA(exchangeclass) = NEW zcl_szakd_call_currency_app( iv_currency = 'EUR' iv_requesttype = zcl_szakd_call_currency_app=>latest ).
DATA(success) = exchangeclass->main( ).
