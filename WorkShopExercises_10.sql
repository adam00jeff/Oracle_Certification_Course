-- create a table called book. specify the following columns: book_id(pk), title
-- author
CREATE TABLE osql_book (
    book_id NUMBER(5) CONSTRAINT bk_pk PRIMARY KEY,
    title VARCHAR2(50),
    author VARCHAR2(50))
;
    
-- create an employee dependants table. specify the following columns:
-- dependant number, first name, last name, relationship to employee, sex,
-- date of birth, employee number
CREATE TABLE osql_dependants (
    dependant_nr NUMBER(5) CONSTRAINT dep_pk PRIMARY KEY,
    f_name VARCHAR2(25) NOT NULL,
    l_name VARCHAR2(50),
    emp_relationship VARCHAR2(15),
    sex VARCHAR2(1),
    dob DATE,
    employee_nr NUMBER(5),
    CONSTRAINT dep_fk FOREIGN KEY (employee_nr) 
        REFERENCES osql_employee (employee_nr)
);
-- make a copy of the orders table (called orders2). Add a numeric column called 
-- discount percent to the table. the column must allow for discount rates up to
-- 50% and must NOT accept NULL values.
CREATE TABLE osql_orders2 AS 
    SELECT * FROM osql_orders;

ALTER TABLE osql_orders2 ADD (
    discount_percent NUMBER(4,2) DEFAULT 0 CONSTRAINT not_over_50 CHECK (discount_percent BETWEEN 0 AND 49) NOT NULL
    );
-- Alter the table orders2 so that the discount column is now nullable
ALTER TABLE osql_orders2
MODIFY discount_percent NULL
;

-- Drop the table orders2 and investiaget the contents of the recycle bin.
-- recover the table.
DROP TABLE osql_orders2;

SELECT * FROM RECYCLEBIN;

FLASHBACK TABLE osql_orders2 TO BEFORE DROP;
