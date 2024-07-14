

--create user lib1
CREATE USER lib1 IDENTIFIED BY "lib1";


--create roles for users in library database
CREATE ROLE lib_admin;

--grant ddl privileges to lib_admin role
GRANT CREATE SESSION TO lib_admin;
GRANT CREATE TABLE, CREATE VIEW TO lib_admin;
GRANT CREATE PROCEDURE TO lib_admin;
GRANT CREATE SEQUENCE, CREATE TRIGGER, CREATE TYPE, CREATE SYNONYM TO lib_admin;

--grant roles to users
GRANT lib_admin TO lib1;

grant UNLIMITED tablespace to lib1;


