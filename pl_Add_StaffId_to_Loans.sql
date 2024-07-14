DECLARE

BEGIN

    FOR i in 3..6 LOOP
        UPDATE LOANS
        SET STAFFID = 1
        WHERE LOANID = i;
    END LOOP;


END;

/

select * from Loans;