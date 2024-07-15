create or REPLACE TRIGGER t_BooksDML
AFTER INSERT or UPDATE OR DELETE
ON BOOKS
FOR EACH ROW
BEGIN

    IF INSERTING THEN
        INSERT INTO LOG_BOOKS
        VALUES (:new.bookid, :new.bookname, :new.author, :new.bookyear, :new.isbn, :new.publisher, SYSDATE, 'INSERT');
    ELSIF UPDATING THEN
        INSERT INTO LOG_BOOKS
        VALUES (:old.bookid, :old.bookname, :old.author, :old.bookyear, :old.isbn, :old.publisher, SYSDATE, 'UPDATE');
    ELSIF DELETING THEN
        INSERT INTO lOG_BOOKS
        VALUES (:old.bookid, :old.bookname, :old.author, :old.bookyear, :old.isbn, :old.publisher, SYSDATE, 'DELETE');
    END IF;

   
END;
