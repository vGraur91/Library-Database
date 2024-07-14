

CREATE OR REPLACE PROCEDURE p_registerNewMember(
    first_name VARCHAR2,
    last_name VARCHAR2,
    p_EMAIL VARCHAR2,
    p_PhoneNumber VARCHAR2
) AS

    v_first_name VARCHAR2(40);
    v_last_name VARCHAR2(40);
    v_email VARCHAR2(60);
    v_phone_number VARCHAR2(9);
BEGIN
    v_first_name := DBMS_ASSERT.SIMPLE_SQL_NAME(first_name);
    v_last_name := DBMS_ASSERT.SIMPLE_SQL_NAME(last_name);
    v_email := TRIM(p_EMAIL);
    v_phone_number := TRIM(p_PhoneNumber);

    if not REGEXP_LIKE(v_email, '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$') then
        raise_application_error(-20002, 'Email is not valid.');
    end if;

    if not REGEXP_LIKE(v_phone_number, '^[0-9]{3}-[0-9]{3}-[0-9]{3}$') then
        raise_application_error(-20004, 'Phone number is not valid.');
    end if;


    for i in (select * from MEMBERS where EMAIL = v_email) loop
        if i.EMAIL = v_email then
            raise_application_error(-20003, 'Email already exists.');
        end if;
    END loop;

    IF v_first_name IS NULL OR v_last_name IS NULL THEN
        raise_application_error(-20001, 'First Name and Last Name cannot be null.');
    end if;


    INSERT INTO MEMBERS(FIRSTNAME, LASTNAME, EMAIL, PHONENUMBER)
    VALUES(v_first_name, v_last_name, v_email, v_phone_number);

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