CREATE OR REPLACE PROCEDURE p_addNewBook(
    book_name IN VARCHAR2,
    author_proc IN VARCHAR2,
    book_year IN INT,
    isbn_proc IN VARCHAR2,
    publisher_proc IN VARCHAR2,
    is_written OUT BOOLEAN
)
AS

    v_book_name VARCHAR2(100);
    v_author VARCHAR2(50);
    v_isbn  VARCHAR2(13);
    v_publisher VARCHAR2(70);


    v_current_year INT := EXTRACT(YEAR FROM SYSDATE);

    invalid_name Exception;
    PRAGMA exception_init(invalid_name, -20001);

    invalid_author Exception;
    PRAGMA exception_init(invalid_author, -20002);

    invalid_isbn Exception;
    PRAGMA exception_init(invalid_isbn, -20003);

    invalid_year Exception;
    PRAGMA exception_init(invalid_year, -20004);

    invalid_publisher Exception;
    PRAGMA exception_init(invalid_author, -20005);




BEGIN

    v_book_name := TRIM(book_name);
    v_author := TRIM(author_proc);
    v_isbn := TRIM(isbn_proc);
    v_publisher := TRIM(publisher_proc);


    IF f_CheckForNullVarChar(v_author) or not is_valid_name(v_author) THEN
        RAISE invalid_author;
    end if;

    if f_CheckForNullVarChar(v_book_name) or not is_valid_name(v_book_name) then
        RAISE invalid_name;
    end if;

    IF f_checkForNullVarChar(publisher_proc) = FALSE THEN
        if not is_valid_name(publisher_proc) then
            raise invalid_publisher;
        end if;
    end if;

    IF book_year IS NOT NULL AND (book_year < 1000 OR book_year > v_current_year) THEN
        RAISE invalid_year;
    END IF;

    IF f_CheckForNullVarChar(isbn_proc) <> TRUE AND LENGTH(isbn_proc) > 13 THEN
        RAISE invalid_isbn;
    ELSIF f_CheckForNullVarChar(isbn_proc) = FALSE then
        if not is_valid_name(isbn_proc) then
            raise invalid_isbn;
        end if; 
    END IF;
    


    INSERT INTO BOOKS(BookName, AUTHOR, BOOKYEAR, ISBN, PUBLISHER)
    VALUES (v_book_name, v_author, book_year, v_isbn, v_publisher);

    COMMIT;

    is_written := TRUE;
    

EXCEPTION
    when invalid_name THEN
        ROLLBACK;
        dbms_output.put_line('Error adding new book: Invalid name');
        is_written := FALSE;
    WHEN invalid_author THEN
        ROLLBACK;
        dbms_output.put_line('Error adding new book: Invalid author');
        is_written := FALSE;
    WHEN invalid_isbn THEN
        ROLLBACK;
        dbms_output.put_line('Error adding new book: Invalid ISBN');
        is_written := FALSE;
    WHEN invalid_year THEN
        ROLLBACK;
        dbms_output.put_line('Error adding new book: Invalid year');
        is_written := FALSE;
    when OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error adding new book: ' || SQLERRM);
        is_written := FALSE;

END;
/