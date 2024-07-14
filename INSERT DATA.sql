

-- Insert sample data into Books table
INSERT INTO Books (BookName, Author, BookYear, ISBN, Publisher)
SELECT 'To Kill a Mockingbird', 'Harper Lee', 1960, '9780446310789',  'AA Publisher' FROM DUAL UNION ALL
SELECT '1984', 'George Orwell', 1949, '9780451524935', 'Science Fiction Media' FROM DUAL UNION ALL
SELECT 'Pride and Prejudice', 'Jane Austen', 1813, '9780141439518', 'RC Company' FROM DUAL UNION ALL
SELECT 'The Great Gatsby', 'F. Scott Fitzgerald', 1925, '9780743273565', 'AA Publisher' FROM DUAL UNION ALL
SELECT 'The Catcher in the Rye', 'J.D. Salinger', 1951, '9780316769174', 'MegaMedia' FROM DUAL;


--INSERT DATA TO STAFF TABLE
INSERT INTO Staff (FirstName, LastName, Position, Email) 
SELECT 'Alice', 'Brown', 'Librarian', 'alice.brown@library.com' FROM DUAL UNION ALL
SELECT 'Bob', 'Wilson', 'Assistant Librarian', 'bob.wilson@library.com' FROM DUAL UNION ALL
SELECT 'Carol', 'Taylor', 'IT Specialist', 'carol.taylor@library.com' FROM DUAL;


INSERT INTO Members (FirstName, LastName, Email, PhoneNumber) 
SELECT 'John', 'Doe', 'john.doe@email.com', '456-789' FROM DUAL UNION ALL
SELECT 'Jane', 'Smith', 'jane.smith@email.com', '987-654' FROM DUAL UNION ALL
SELECT 'Mike', 'Johnson', 'mike.johnson@email.com', '456-987'  FROM DUAL;



INSERT INTO Loans (BookID, MemberID, DateFrom, DueDate, ReturnDate, Returned)
with names (BookID, MemberID, DateFrom, DueDate, ReturnDate, Returned) AS 
(
    SELECT 1, 1, TO_DATE('2023-04-01', 'YYYY-MM-DD'), TO_DATE('2023-04-15', 'YYYY-MM-DD'), NULL, '0' FROM DUAL UNION ALL
    SELECT 2, 2, TO_DATE('2023-04-05', 'YYYY-MM-DD'), TO_DATE('2023-04-19', 'YYYY-MM-DD'), TO_DATE('2023-04-18', 'YYYY-MM-DD'), '1' FROM DUAL UNION ALL
    SELECT 3, 3, TO_DATE('2023-04-10', 'YYYY-MM-DD'), TO_DATE('2023-04-24', 'YYYY-MM-DD'), NULL, '0' FROM DUAL
)


--added new record to Loans table
INSERT INTO Loans (BookID, MemberID, DateFrom, DueDate, ReturnDate, Returned)
WITH names (BookID, MemberID, DateFrom, DueDate, ReturnDate, Returned) AS
(
    SELECT 2, 3, TO_DATE('2023-04-18', 'YYYY-MM-DD'), TO_DATE('2023-05-13', 'YYYY-MM-DD'), NULL, '0' FROM DUAL
)
SELECT * FROM names;
