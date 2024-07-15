

CREATE OR REPLACE PROCEDURE p_CheckEmail(
    p_email VARCHAR2
) AS

BEGIN

    if not REGEXP_LIKE(p_email, '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$') then
        raise_application_error(-20002, 'Email is not valid.');
    end if;


    for i in (select * from MEMBERS where EMAIL = p_email) loop
        
        raise_application_error(-20003, 'Email already exists.');
        
    END loop;
EXCEPTION
    when OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('p_CheckEmail: ' || SQLERRM);

END;
/


CREATE OR REPLACE PROCEDURE p_registerNewMember(
    first_name VARCHAR2,
    last_name VARCHAR2,
    p_EMAIL VARCHAR2,
    p_PhoneNumber VARCHAR2
) AS


    v_email VARCHAR2(60);
    v_phone_number VARCHAR2(9);
BEGIN
    
    v_email := TRIM(p_EMAIL);
    v_phone_number := TRIM(p_PhoneNumber);

    p_CheckEmail(v_email);

    if not REGEXP_LIKE(v_phone_number, '^[0-9]{3}-[0-9]{3}-[0-9]{3}$') then
        raise_application_error(-20004, 'Phone number is not valid.');
    end if;

    p_ValidationForVarchar2(first_name, 'First Name or/and Last Name cannot be null.', -20001, TRUE);
    p_ValidationForVarchar2(last_name, 'First Name or/and Last Name cannot be null.', -20001, TRUE);
    

    INSERT INTO MEMBERS(FIRSTNAME, LASTNAME, EMAIL, PHONENUMBER)
    VALUES(first_name, last_name, v_email, v_phone_number);

    COMMIT;

EXCEPTION

    when VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('First name or Last name have null value.');
        ROLLBACK;

    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error in registering new member. Ocurred error : ' || SQLERRM);

END;
/