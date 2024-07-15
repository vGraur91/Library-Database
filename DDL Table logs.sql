

CREATE TABLE log_books AS
SELECT *
FROM BOOKS
WHERE 1=2;

ALTER TABLE log_books
ADD Date_Change TIMESTAMP;


CREATE TABLE log_loans AS
select * 
from Loans
where 1=2;

ALTER TABLE log_loans
ADD Date_Change TIMESTAMP;


CREATE TABLE log_members AS
select * 
from MEMBERS
where 1=2;

ALTER TABLE log_members
ADD Date_Change TIMESTAMP;


CREATE TABLE log_staff AS
select * 
from STAFF
where 1=2;

ALTER TABLE log_staff
ADD Date_Change TIMESTAMP;



