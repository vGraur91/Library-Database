
CREATE or REPLACE FUNCTION f_addNewBook(
    book_name IN VARCHAR2,
    author_proc IN VARCHAR2,
    book_year IN INT,
    isbn_proc IN VARCHAR2,
    publisher_proc IN VARCHAR2
) RETURN BOOLEAN
AS

    v_BookName VARCHAR2(100);
    v_Author VARCHAR2(50);
    v_Publisher VARCHAR2(70);
    v_isbn VARCHAR2(13);
    v_current_year INT := EXTRACT(YEAR FROM SYSDATE);
BEGIN

    v_BookName := dbms_assert.simple_sql_name(book_name);   
    v_Author := dbms_assert.simple_sql_name(author_proc);
    v_isbn := dbms_assert.simple_sql_name(isbn_proc);
    v_Publisher := dbms_assert.simple_sql_name(publisher_proc);

    IF v_BookName IS NULL OR v_Author IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'Book and Author name cannot be null');
    END IF;

    IF book_year IS NOT NULL AND (book_year < 1000 OR book_year > v_current_year) THEN
        RAISE_APPLICATION_ERROR(-20004, 'BookYear must be between 1000 and the current year');
    END IF;

    IF v_isbn IS NOT NULL AND LENGTH(v_isbn) > 13 THEN
        RAISE_APPLICATION_ERROR(-20005, 'ISBN must be no more than 13 characters');
    END IF;
    


    INSERT INTO BOOKS(BookName, AUTHOR, BOOKYEAR, ISBN, PUBLISHER)
    VALUES (v_BookName, v_Author, book_year, v_isbn, v_Publisher);

    COMMIT;

    RETURN TRUE;

EXCEPTION
    when OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error adding new book: ' || SQLERRM);
        RETURN FALSE;

END f_addNewBook;
/





