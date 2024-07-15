
create or REPLACE PROCEDURE p_registerNewStaff(
    FIRSTNAME IN VARCHAR2,
    LASTNAME IN VARCHAR2,
    POSITION In VARCHAR2,
    EMAIL IN VARCHAR2,
    is_written OUT BOOLEAN
) AS
    v_email VARCHAR2(60);
    v_first_name VARCHAR(40);
    v_last_name VARCHAR2(40);
    v_position  VARCHAR2(60);

    invalid_email EXCEPTION;
    PRAGMA exception_init(invalid_email, -20001);

    invalid_name EXCEPTION;
    PRAGMA exception_init(invalid_name, -20002);


BEGIN
    
    v_first_name := DBMS_ASSERT.SIMPLE_SQL_NAME(FIRSTNAME);
    v_last_name := DBMS_ASSERT.SIMPLE_SQL_NAME(LASTNAME);

    if f_CheckForNullVarChar(POSITION) = FALSE then
        v_position := DBMS_ASSERT.SIMPLE_SQL_NAME(POSITION);
    end if;

    v_email := TRIM(EMAIL);
    v_email := REGEXP_SUBSTR(v_email, '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$');
    
    --check email if is valid
    if f_CheckForNullVarChar(v_email) then
        RAISE invalid_email;
    end if;


    --check first and last name on null
    IF f_CheckForNullVarChar(v_first_name) OR f_CheckForNullVarChar(v_last_name) OR LENGTH(v_first_name)=0 OR LENGTH(v_last_name)=0 THEN 
        RAISE invalid_name;
    END IF;
    
    

    INSERT INTO staff(FIRSTNAME, LASTNAME, POSITION, EMAIL)
    VALUES (v_first_name, v_last_name, v_position, v_email);

    COMMIT;
    is_written := TRUE;
EXCEPTION

    WHEN invalid_email THEN
        DBMS_OUTPUT.PUT_LINE('Email is invalid.');
        is_written := FALSE;
        ROLLBACK;
    WHEN invalid_name THEN
        DBMS_OUTPUT.PUT_LINE('Violation in field first name and/or last name.');
        ROLLBACK; 
        is_written := FALSE;       
    WHEN OTHERS THEN
        ROLLBACK;
        is_written := FALSE;
        DBMS_OUTPUT.PUT_LINE('An error occured : ' || SQLERRM);



END;
/