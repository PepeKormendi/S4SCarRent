class ZCL_SZAKD_CALL_CURRENCY_APP definition
  public
  final
  create public .

public section.

  types:
    currencytabletype TYPE STANDARD TABLE OF zszakd_curren_ex .
  types:
    BEGIN OF ENUM  requesttype,
        latest   ,
        enriched ,
        history  ,
        codes    ,
      END OF ENUM requesttype .

  methods CONSTRUCTOR
    importing
      !IV_CURRENCY type /DMO/CURRENCY_CODE
      !IV_REQUESTTYPE type REQUESTTYPE .
  methods MAIN
    returning
      value(RV_SUCCESS) type FLAG .
protected section.

  data GV_REQUESTURL type STRINGVAL .
  data HTTP_CLIENT type ref to IF_HTTP_CLIENT .
  data REST_CLIENT type ref to CL_REST_HTTP_CLIENT .
  data RESPONSEDATA type ref to DATA .
  data CURRENCIES type CURRENCYTABLETYPE .

  methods CREATE_HTTP_CLIENT
    returning
      value(RV_SUCCESS) type FLAG .
  methods HANDLE_HTTP_EXCEPTION .
  methods RECEIVE_RESPONSE
    returning
      value(RV_SUCCESS) type FLAG .
private section.

  constants GC_EXCHANGERATE_APIKEY type STRINGVAL value 'ed7831d8103f8ec63fdfbc62' ##NO_TEXT.
  data GC_EXCHANGE_URL type STRINGVAL value 'https://v6.exchangerate-api.com/v6/' ##NO_TEXT.
  data GV_CURRENCY_BASE type /DMO/CURRENCY_CODE .
  data GV_REQUESTTYPE type REQUESTTYPE .
ENDCLASS.



CLASS ZCL_SZAKD_CALL_CURRENCY_APP IMPLEMENTATION.


  METHOD constructor.
    gv_requesttype   = iv_requesttype.
    gv_currency_base = to_lower( val = iv_currency ).
  ENDMETHOD.


  METHOD create_http_client.

    gv_requesturl = |{ gc_exchange_url }{ gc_exchangerate_apikey }/{ to_lower( val = CONV string( gv_requesttype ) ) }/{ condense( val = gv_currency_base ) }|.

    cl_http_client=>create_by_url(
    EXPORTING
      url                = gv_requesturl
    IMPORTING
      client             = http_client
    EXCEPTIONS
      argument_not_found = 1
      plugin_not_active  = 2
      internal_error     = 3 ).
    IF sy-subrc NE 0.

    ELSE.
      rv_success = abap_true.
    ENDIF.

  ENDMETHOD.


  METHOD handle_http_exception.
    WRITE: / 'Error Number', sy-subrc, /.
    http_client->get_last_error(
      IMPORTING
        message = DATA(lv_error_message) ).
    SPLIT lv_error_message AT cl_abap_char_utilities=>newline INTO TABLE DATA(lt_errors).
    LOOP AT lt_errors INTO lv_error_message.
      WRITE: / lv_error_message.
    ENDLOOP.
    WRITE: / 'Also check transaction SMICM -> Goto -> Trace File -> Display End'.
    RETURN.

  ENDMETHOD.


  METHOD main.

    DATA(success) =  create_http_client( ).
    CHECK success = abap_true.
    http_client->send( ).
    IF sy-subrc IS NOT INITIAL.
      handle_http_exception( ).
    ENDIF.
    rv_success = receive_response( ).

  ENDMETHOD.


  METHOD receive_response.
    DATA ratestring TYPE f.
    http_client->receive(
    EXCEPTIONS
      http_communication_failure = 1
      http_invalid_state = 2
      http_processing_failed = 3
   ).
    IF sy-subrc IS NOT INITIAL.
      handle_http_exception( ).
    ENDIF.
    http_client->response->get_status( IMPORTING code = DATA(status_code)  reason = DATA(status_reason) ).
    responsedata = /ui2/cl_json=>generate( json = http_client->response->get_cdata( ) ).

    SELECT * FROM zszakd_curren_ex INTO TABLE currencies.


    LOOP AT currencies ASSIGNING FIELD-SYMBOL(<currency>).
      CLEAR ratestring.
      /ui2/cl_data_access=>create( ir_data = responsedata iv_component = |conversion_rates-{ condense( val = <currency>-currency_code ) }| )->value( IMPORTING ev_data = ratestring ).
      <currency>-exchange_rate = CONV #( ratestring ).
    ENDLOOP.
    MODIFY zszakd_curren_ex FROM TABLE currencies.

    IF sy-subrc = 0.
      COMMIT WORK.
      rv_success = abap_true.
    ELSE.
      ROLLBACK WORK.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
