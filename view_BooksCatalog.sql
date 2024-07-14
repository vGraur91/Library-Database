
CREATE OR REPLACE VIEW view_BooksCatalog AS
SELECT b.BOOKID, b.BOOKNAME, b.AUTHOR, b.BOOKYEAR, L.DateFrom, L.DueDate, case(RETURNED) when '0' then 'Loaned' else 'Available' end as STATUS
FROM BOOKS B
LEFT  JOIN (
        select BOOKID, DateFrom, DueDate, RETURNED from LOANS WHERE RETURNED = '0'
    ) L ON B.BOOKID = L.BOOKID;