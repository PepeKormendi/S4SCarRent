CLASS zcl_customer_generator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_customer_generator IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    " Travels
    out->write( ' --> zszakd_customer' ).


    DELETE FROM zszakd_customer.                        "#EC CI_NOWHERE

    " Add some comments here

    DELETE FROM zszakd_customer.                        "#EC CI_NOWHERE


    DATA: lt_customer TYPE STANDARD TABLE OF zszakd_customer.


    lt_customer = VALUE #(
    ( customer_uuid = '9BFE3AF01C5CD99E180040C2EA63A2F7'
     first_name = 'András'
     last_name  = 'Appelshoffer'
     street     = 'Alma utca 15.'
     postal_code = '1111'
     city = 'Budapest'
     country_code = '36'
     phone_number = '06-66-1111-121'
     email_address = 'andras.appelshoffer@fake.com'
      ) ).



    INSERT zszakd_customer FROM TABLE @lt_customer.
    COMMIT WORK.



    " bookings
    out->write( ' --> /DMO/A_BOOKING_D' ).





  ENDMETHOD.
ENDCLASS.
