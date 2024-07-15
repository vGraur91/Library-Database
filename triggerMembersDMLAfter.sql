create or REPLACE TRIGGER t_MEMBERSDML
AFTER INSERT or UPDATE OR DELETE
ON MEMBERS
FOR EACH ROW
BEGIN

    IF INSERTING THEN
        INSERT INTO LOG_MEMBERS
        VALUES (:new.memberid, :new.firstname, :new.lastname, :new.email, :new.phonenumber, SYSDATE, 'INSERT');
    ELSIF UPDATING THEN
        INSERT INTO LOG_MEMBERS
        VALUES (:old.memberid, :old.firstname, :old.lastname, :old.email, :old.phonenumber, SYSDATE, 'UPDATE');
    ELSIF DELETING THEN
        INSERT INTO LOG_MEMBERS
        VALUES (:old.memberid, :old.firstname, :old.lastname, :old.email, :old.phonenumber, SYSDATE, 'DELETE');
    END IF;

   
END;
/
