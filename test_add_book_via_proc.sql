DECLARE
    v_b_name Varchar2(100) default 'Twilight';
    v_author Varchar(60) default 'Stephenie Meyer';
    count_n int := 1;
BEGIN

    /*
    for i in 2015..2024 LOOP
        p_addNewBook(v_b_name || ' ' || TO_CHAR(count_n), v_author, i, null, null);
        count_n:=count_n + 1;
    end LOOP;
    */

    UPDATE BOOKS
    SET ISBN = '7542314664'
    WHERE BOOKID = 30;


END;
/