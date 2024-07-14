drop type activeLoanTable;
drop type activeLoan;


CREATE OR REPLACE TYPE activeLoan AS OBJECT(
    BOOKID INT,
    BOOKNAME VARCHAR2(100),
    MEMBERID INT,
    FIRSTNAME VARCHAR2(40),
    LASTNAME VARCHAR2(40),
    DATEFROM DATE,
    DUEDATE DATE
);
/

CREATE OR REPLACE TYPE activeLoanTable AS TABLE OF activeloan;
/

CREATE or REPLACE FUNCTION getActiveLoansByMembers(
    f_MemberID INT
) RETURN activeLoanTable
AS
    v_result activeLoanTable := activeLoanTable();
BEGIN

    if f_MemberID is null  or f_MemberID <= 0 then
        raise_application_error(-20001, 'MemberID cannot be null or negative');
    END IF;

    SELECT activeLoan(
        BOOKID,
        BOOKNAME,
        MEMBERID,
        FIRSTNAME,
        LASTNAME,
        DATEFROM,
        DUEDATE)
    BULK COLLECT INTO v_result    
    FROM VIEW_ACTIVELOANS 
    WHERE MEMBERID = f_MemberID;

    RETURN v_result;

EXCEPTION
     WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No active loans found for member ID: ' || f_MemberID);
        RETURN NULL;
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Value error occurred. Check input parameters.');
        RETURN NULL;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLCODE || ' - ' || SQLERRM);
        -- Log the error here if you have a logging mechanism
        RETURN NULL;
end getActiveLoansByMembers;
/

