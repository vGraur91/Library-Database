

create or REPLACE PROCEDURE p_registerNewStaff(
    FIRSTNAME VARCHAR2,
    LASTNAME VARCHAR2,
    POSITION VARCHAR2,
    EMAIL VARCHAR2    
) AS

    v_first_name VARCHAR2(40);
    v_last_name VARCHAR2(40);
    v_position VARCHAR2(60);
    v_email VARCHAR2(60);
BEGIN

    

    v_first_name := DBMS_ASSERT.SIMPLE_SQL_NAME(FIRSTNAME);
    v_last_name := dbms_assert.SIMPLE_SQL_NAME(LASTNAME);
    v_position  := dbms_assert.SIMPLE_SQL_NAME(POSITION);
    v_email := TRIM(EMAIL);

    if not REGEXP_LIKE(v_email, '^[a-zA-Z0-9._%-]+@[a-zA-Z0-9._%-]+.[a-zA-Z]{2,6}$') then
        raise_application_error(-20001, 'Invalid email address');
    end if;

    if v_first_name IS NULL OR v_last_name IS NULL OR v_email IS NULL THEN
        raise_application_error(-20002, 'First name, Last name and email cannot be null.');
    end if;

    INSERT INTO staff(FIRSTNAME, LASTNAME, POSITION, EMAIL)
    VALUES (v_first_name, v_last_name, v_position, v_email);

    COMMIT;

EXCEPTION

    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Value error.');
        ROLLBACK;
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('An error occured : ' || SQLERRM);



END;
/