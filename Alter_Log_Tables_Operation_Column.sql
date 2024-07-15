

ALTER TABLE log_books
add Operation Varchar(20) not null;

ALTER TABLE log_loans
add Operation Varchar(20) not null;

ALTER TABLE log_members
add Operation Varchar(20) not null;

ALTER TABLE log_staff
add Operation Varchar(20) not null;