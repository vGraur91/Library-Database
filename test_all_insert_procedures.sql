set SERVEROUT on;

DECLARE
    v_n BOOLEAN DEFAULT FALSE;
BEGIN

    /*

    P_REGISTERNEWSTAFF(FIRSTNAME  => 'John',
                       LASTNAME  => 'Cena',
                       POSITION  => null,
                       EMAIL  => 'cena.john@gmail.com',
                       is_written  => v_n);*/


    p_addNewBook('New Era', 'Kamikadze Lance', 1937, '1212390523', 'Micro Publish', v_n);


    if v_n THEN
        DBMS_OUTPUT.PUT_LINE(A  => 'Hello');
    ELSE
        DBMS_OUTPUT.PUT_LINE(A  => 'Goodbye');
    end if;
    /*

    for i in (SELECT * FROM STAFF WHERE email='carol.taylor@library.com') LOOP
        DBMS_OUTPUT.PUT_LINE(A  => 'Hello');
    END LOOP;*/

END;

