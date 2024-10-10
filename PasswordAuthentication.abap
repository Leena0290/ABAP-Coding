*****************************************************************************************************************
*You are working on an authentication system and there is a set of rules the users have to follow when picking a new password:
*
*1. It has to be at least 16 characters long.
*2. The password cannot contain the word "password". This rule is not case-sensitive.
*3. The same character cannot be used more than 4 times. This rule is case-sensitive, "a" and "A" are different characters.
*4. The password has to contain at least one uppercase and one lowercase letter.
*5. The password has to contain at least one of the following special characters "*","#","@".
*
*Write a function that takes in a password and returns a collection of any rule numbers that are not met.
*
*password_1 = "Srtongpwd9999#abc"             ==> []
*password_2 = "Aess10#"                       ==> [1]
*password_3 = "Password@"                     ==> [1,2]
*password_4 = "#PassWord011111112222223x"     ==> [2,3]
*password_5 = "PASSWORDz#1111111"             ==> [2,3]
*password_6 = "aaaapassword$$"                ==> [1,2,3,4,5]
*password_7 = "LESS10#"                       ==> [1,4]
*password_8 = "SsSSSt#passWord"               ==> [1,2]
*password_9 = "SsSSSt#passWordpassword"       ==> [2,3]
*password_10 = "aZ*"                          ==> [1]
*
*
*All test cases:
*
*validate(password_1) ==> []
*validate(password_2) ==> [1]
*validate(password_3) ==> [1,2]
*validate(password_4) ==> [2,3]
*validate(password_5) ==> [2,3]
*validate(password_6) ==> [1,2,3,4,5]
*validate(password_7) ==> [1,4]
*validate(password_8) ==> [1,2]
*validate(password_9) ==> [2,3]
*validate(password_10) ==> [1]
*
*Complexity variables:
*
*N = length of the password
*****************************************************************************************************************


CLASS zcl_password_validation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PRIVATE SECTION.
    " To perform password authentication
    METHODS: Validate IMPORTING input_string          TYPE string
                      RETURNING VALUE(display_result) TYPE string.
ENDCLASS.

CLASS zcl_password_validation IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    out->write( Validate( 'Srtongpwd999#abc' ) ).           "             ==> []
    out->write( Validate( 'Aess10#' ) ).                    "      ==> [1]
    out->write( Validate( 'Password@' ) ) .                 "       ==> [1,2]
    out->write( Validate( '#PassWord011111112222223x' ) ).  "    ==> [2,3]
    out->write( Validate( 'aaaapassword$$' ) ).             "          ==> [1,2,3,4,5]
    out->write( Validate( 'LESS10#' ) ) .                   " ==> [1,4]
    out->write( Validate( 'aZ*' ) ) .                       "   ==> [1]

  ENDMETHOD.

  METHOD Validate.
    CLEAR display_result.

    "String length
    DATA(input_length) = strlen( input_string ).

    "Rule 1
    IF input_length < 16 .
      DATA(rule1) = abap_true.
    ENDIF.

    "Rule 2
    DATA(lower_string) = to_lower( input_string ).
    IF lower_string CS 'password'.
      DATA(rule2) = abap_true.
    ENDIF.

    "Rule 3
    DO input_length TIMES .
      DATA(indx) = sy-index - 1. "current index of string
      DATA(curr_char) = input_string+indx(1).
      IF curr_char CA '0123456789' OR curr_char CA to_lower( sy-abcde ) OR curr_char CA sy-abcde.
        DATA(cnt) =  count( val = input_string sub = curr_char ).
        IF cnt >= 4.
          DATA(rule3) = abap_true.
          EXIT.
        ENDIF.
      ENDIF.
    ENDDO.

    "Rule 4
    IF input_string CA sy-abcde AND input_string CA to_lower( sy-abcde ).
      DATA(rule4) = abap_false.
    ELSE.
      rule4 = abap_true.
    ENDIF.

    "Rule 5
    IF input_string NA '*,#,@'.
      DATA(rule5) = abap_true.
    ENDIF.

    IF rule1 IS NOT INITIAL.
      display_result = |{ '1' }|.
    ENDIF.

    IF rule2 IS NOT INITIAL.
      display_result = COND #( WHEN display_result IS INITIAL THEN '2'
                               ELSE |{ display_result }{ ',2' }| ).
    ENDIF.

    IF rule3 IS NOT INITIAL.
      display_result = COND #( WHEN display_result IS INITIAL THEN '3'
                               ELSE |{ display_result }{ ',3' }| ).
    ENDIF.
    IF rule4 IS NOT INITIAL.
      display_result = COND #( WHEN display_result IS INITIAL THEN '4'
                          ELSE |{ display_result }{ ',4' }| ).
    ENDIF.

    IF rule5 IS NOT INITIAL.
      display_result = COND #( WHEN display_result IS INITIAL THEN '5'
                               ELSE |{ display_result }{ ',5' }| ).
    ENDIF.
   " Display result
    IF display_result IS NOT INITIAL.
      display_result = |{ '[' }{ display_result }{ ']' }|.
    ELSE.
      IF rule1 IS INITIAL AND rule2 IS INITIAL AND rule3 IS INITIAL AND rule4 IS INITIAL.
        display_result = |{ '[]' }|.
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
