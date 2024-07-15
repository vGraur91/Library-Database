create or REPLACE TRIGGER t_LOANSDML
AFTER INSERT or UPDATE OR DELETE
ON LOANS
FOR EACH ROW
BEGIN

    IF INSERTING THEN
        INSERT INTO LOG_LOANS
        VALUES (:new.loanid, :new.bookid, :new.memberid, :new.datefrom, :new.duedate, :new.returndate, :new.returned, :new.staffid, SYSDATE, 'INSERT');
    ELSIF UPDATING THEN
        INSERT INTO LOG_LOANS
        VALUES (:old.loanid, :old.bookid, :old.memberid, :old.datefrom, :old.duedate, :old.returndate, :old.returned, :old.staffid, SYSDATE, 'DELETE');
    ELSIF DELETING THEN
        INSERT INTO LOG_LOANS
        VALUES (:old.loanid, :old.bookid, :old.memberid, :old.datefrom, :old.duedate, :old.returndate, :old.returned, :old.staffid, SYSDATE, 'DELETE');
    END IF;

   
END;
/
