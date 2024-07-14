

CREATE OR REPLACE VIEW view_BookAvailability AS
SELECT *
FROM BOOKS
WHERE BOOKID NOT IN (select BOOKID
                     from  LOANS
                     where RETURNED = '0' 
                    );

