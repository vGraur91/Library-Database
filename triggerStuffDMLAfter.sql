create or REPLACE TRIGGER t_STUFFDML
AFTER INSERT or UPDATE OR DELETE
ON STAFF
FOR EACH ROW
BEGIN

    IF INSERTING THEN
        INSERT INTO LOG_STAFF
        VALUES (:new.staffid, :new.firstname, :new.lastname, :new.position, :new.email, SYSDATE, 'INSERT');
    ELSIF UPDATING THEN
        INSERT INTO LOG_STAFF
        VALUES (:old.staffid, :old.firstname, :old.lastname, :old.position, :old.email, SYSDATE, 'DELETE');
    ELSIF DELETING THEN
        INSERT INTO LOG_STAFF
        VALUES (:old.staffid, :old.firstname, :old.lastname, :old.position, :old.email, SYSDATE, 'DELETE');
    END IF;

   
END;
/
