
CREATE OR REPLACE PROCEDURE p_AddLoan(
    p_book_id INT,
    p_member_id INT,
    p_date_to DATE,
    p_due_date DATE,
    p_stuff_id INT
) AS

    lib_policy_interval INTERVAL DAY TO SECOND := '14 00:00:00';
    v_member_loaned INT;
BEGIN

    IF p_book_id IS NULL OR  p_book_id <=0 THEN
        raise_application_error(-20001, 'Invalid input. BookID should be digit > 0 ');
    END IF;

    FOR rec in (SELECT * FROM VIEW_ACTIVELOANS where BOOKID = p_book_id) LOOP
        raise_application_error(-20005, 'Book is already loaned.');
    END LOOP;

    IF  p_member_id IS NULL OR p_member_id <=0 THEN
        raise_application_error(-20002, 'Invalid input. MemberID should be digit > 0 ');
    END IF;

    IF p_date_to IS NULL THEN
        raise_application_error(-20003, 'Invalid input. Date to is null');
    END IF;

    IF p_due_date IS NULL THEN
        raise_application_error(-20003, 'Invalid input. Due Date is null');
    END IF;

    IF p_due_date < p_date_to THEN
        raise_application_error(-20004, 'Invalid input. Due Date can not be less than date to.');
    END IF;

    IF p_due_date - p_date_to > lib_policy_interval THEN
        raise_application_error(-20006, 'Invalid input. Due Date can not be more than 14 days after date to.');
    END IF;

    SELECT count(*)
    into v_member_loaned
    from VIEW_ACTIVELOANS
    where MEMBERID = p_member_id;

    IF v_member_loaned >= 3 THEN
        raise_application_error(-20007, 'Member can not have more than 3 active loans.');
    END IF;

    INSERT INTO LOANS (bookid, memberid, datefrom, duedate, STAFFID)
    VALUES (p_book_id, p_member_id, p_date_to, p_due_date, p_stuff_id);

    COMMIT;

EXCEPTION
    when value_error THEN
        DBMS_OUTPUT.PUT_LINE('Error with data validation :' || SQLERRM);
        ROLLBACK;
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('An error has occured : ' || SQLERRM);

END;

/
