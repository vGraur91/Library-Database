
create or replace TYPE book_record AS OBJECT (
    BookID INT,
    BookName VARCHAR2(100),
    Author VARCHAR2(50),
    BookYear INT,
    ISBN VARCHAR2(13),
    Publisher VARCHAR2(70)
);