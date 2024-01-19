*&---------------------------------------------------------------------*
*& Report ZSZAKD_MISSED_BOOKING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zszakd_missed_booking.

DATA: lv_yest TYPE datum.
DATA: ls_bal_log    TYPE bal_s_log,
      lv_log_handle TYPE balloghndl,
      ls_bal_msg    TYPE bal_s_msg,
      lt_log_handle TYPE bal_t_logh.


ls_bal_log-object = 'ZSZAKD'.
ls_bal_log-subobject = 'ZSZAKD_SUB'.

CALL FUNCTION 'BAL_LOG_CREATE'
  EXPORTING
    i_s_log                 = ls_bal_log
  IMPORTING
    e_log_handle            = lv_log_handle
  EXCEPTIONS
    log_header_inconsistent = 1
    OTHERS                  = 2.
IF sy-subrc = 0.
  INSERT lv_log_handle INTO TABLE lt_log_handle.
ENDIF.

IF lv_log_handle IS NOT INITIAL.
  ls_bal_msg-msgty = 'I'.
  ls_bal_msg-msgid = 'ZSZAKD_MSG'.
  ls_bal_msg-msgno = '001'.

  CALL FUNCTION 'BAL_LOG_MSG_ADD'
    EXPORTING
      i_log_handle = lv_log_handle
      i_s_msg      = ls_bal_msg.
ENDIF.

lv_yest = sy-datum - 1.
"get every missed booking
SELECT *
  FROM zszakdcarbokings
  INTO TABLE @DATA(lt_bookings)
  WHERE booking_status EQ ''
  AND   booked_from EQ @lv_yest.

LOOP AT lt_bookings ASSIGNING FIELD-SYMBOL(<fs_bookings>).
  <fs_bookings>-booking_status = '03'.
ENDLOOP.

MODIFY zszakdcarbokings FROM TABLE lt_bookings.
IF sy-subrc = 0.
  IF lv_log_handle IS NOT INITIAL.
    ls_bal_msg-msgty = 'I'.
    ls_bal_msg-msgid = 'ZSZAKD_MSG'.
    ls_bal_msg-msgno = '002'.

    CALL FUNCTION 'BAL_LOG_MSG_ADD'
      EXPORTING
        i_log_handle = lv_log_handle
        i_s_msg      = ls_bal_msg.
  ENDIF.
ENDIF.

CALL FUNCTION 'BAL_DB_SAVE'
  EXPORTING
    i_t_log_handle = lt_log_handle.
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
