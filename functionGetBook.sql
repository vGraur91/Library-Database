CREATE OR REPLACE TYPE book_record AS OBJECT (
    BookID INT,
    BookName VARCHAR2(100),
    Author VARCHAR2(50),
    BookYear INT,
    ISBN VARCHAR2(13),
    Publisher VARCHAR2(70)
);
/

CREATE OR REPLACE FUNCTION f_getBook(
    book_id IN INT,
    book_name IN VARCHAR2,
    book_author IN VARCHAR2
) RETURN book_record
IS
    v_book book_record;
BEGIN
    SELECT book_record(BOOKID, BOOKNAME, AUTHOR, BOOKYEAR, ISBN, PUBLISHER)
    INTO v_book
    FROM BOOKS b
    WHERE (book_id IS NULL OR BOOKID = book_id)
      AND (book_name IS NULL OR UPPER(BOOKNAME) = UPPER(book_name))
      AND (book_author IS NULL OR UPPER(AUTHOR) = UPPER(book_author))
    FETCH FIRST 1 ROW ONLY;

    RETURN v_book;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, 'An error occurred: ' || SQLERRM);
END f_getBook;
/
