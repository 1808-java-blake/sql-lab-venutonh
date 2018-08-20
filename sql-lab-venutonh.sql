Part I – Working with an existing database

1.0	Setting up Oracle Chinook
In this section you will begin the process of working with the Oracle Chinook database
Task – Open the Chinook_Oracle.sql file and execute the scripts within.
2.0 SQL Queries
In this section you will be performing various queries against the Oracle Chinook database.
2.1 SELECT
Task – Select all records from the Employee table.
SET SCHEMA 'chinook';
SELECT*FROM employee;


Task – Select all records from the Employee table where last name is King.
SET SCHEMA 'chinook';
SELECT * FROM employee = ‘King’;


Task – Select all records from the Employee table where first name is Andrew and REPORTSTO is NULL.
SET SCHEMA 'chinook';
SELECT*FROM employee
where firstname = 'Andrew'
and reportsto IS NULL;


2.2 ORDER BY
Task – Select all albums in Album table and sort result set in descending order by title.
SET SCHEMA 'chinook';
SELECT*FROM album
ORDER BY Album DESC;


Task – Select first name from Customer and sort result set in ascending order by city
SET SCHEMA 'chinook';
SELECT firstname FROM Customer
ORDER BY city ASC;


2.3 INSERT INTO
Task – Insert two new records into Genre table
SET SCHEMA 'chinook';
INSERT INTO Genre
VALUES( 26, 'Jazztech'), (27, 'Existential Hip-Hop')


Task – Insert two new records into Employee table
SET SCHEMA 'chinook';
INSERT INTO Employee
VALUES( 9, 'Venuto', 'Nathan','Janitor',1,'1996-10-27 00:00:00'::TIMESTAMP WITHOUT TIME ZONE,'2010-01-17 00:00:00'::TIMESTAMP WITHOUT TIME ZONE,'1086 University Pl', 'Schenectady','NY','USA', 12308, '+1 (403) 564-5432','+1 (403) 564-5433','venuton@gmail.com'), 
(10, 'Clyde', 'Anthony', 'Security Guard', 2,'2010-11-02 00:00:00'::TIMESTAMP WITHOUT TIME ZONE,'2011-01-30 00:00:00'::TIMESTAMP WITHOUT TIME ZONE,'540 Waterfornt Ave','Melboune','FL','USA',32934,'+1 (403) 578-0193','+1 (403) 283-1093','whateveryouwant@msn.com');



Task – Insert two new records into Customer table
SET SCHEMA 'chinook';
INSERT INTO Customer
VALUES( 60, 'Henry', 'Rollins', null ,'223 23rd Ave','Seattle','WA','USA','98421','+1 (403) 564-5432',null,'haroldrb@gmail.com',3), 
(61, 'Timothy', 'Johnson', null ,'540 Waterfornt Ave','Melbourne','FL',null,null,'+1 (403) 283-1093',null,'whateveryouwant@msn.com',5);


2.4 UPDATE
Task – Update Aaron Mitchell in Customer table to Robert Walter
SET SCHEMA 'chinook';
UPDATE Customer
SET firstname = 'Robert', lastname = 'Walter'
WHERE firstname =  ‘Aaron’ and lastname = ‘Mitchell’;


Task – Update name of artist in the Artist table “Creedence Clearwater Revival” to “CCR”
SET SCHEMA 'chinook';
UPDATE Artist
SET name = 'CCR'
WHERE name = 'Creedence Clearwater Revival';

2.5 LIKE
SET SCHEMA 'chinook';
Task – Select all invoices with a billing address like “T%”
SELECT * FROM invoice
WHERE billingaddress LIKE 'T%';

2.6 BETWEEN
Task – Select all invoices that have a total between 15 and 50
SET SCHEMA 'chinook';
SELECT*FROM invoice
WHERE total
BETWEEN 15 AND 50;

Task – Select all employees hired between 1st of June 2003 and 1st of March 2004
SET SCHEMA 'chinook';
SELECT*FROM employee
WHERE hiredate
BETWEEN '2003-06-01 00:00:00'::TIMESTAMP WITHOUT TIME ZONE
AND '2004-03-01 00:00:00'::TIMESTAMP WITHOUT TIME ZONE;


2.7 DELETE
Task – Delete a record in Customer table where the name is Robert Walter (There may be constraints that rely on this, find out how to resolve them).
SET SCHEMA 'chinook';
DELETE FROM invoiceline
WHERE invoiceid in(
SELECT invoiceid FROM invoice WHERE 
Customerid IN(
SELECT customerid FROM customer WHERE
Firstname = ‘Robert’ AND lastname = ‘Walter’);
DELETE FROM customer
WHERE firstname = ‘Robert’ AND lastname = ‘Walter’;


3.0	SQL Functions
In this section you will be using the Oracle system functions, as well as your own functions, to perform various actions against the database
3.1 System Defined Functions
Task – Create a function that returns the current time.
SET SCHEMA 'chinook';
CREATE OR REPLACE FUNCTION return_time()
RETURNS TIME AS $the_current_time$ 
DECLARE the_current_time TIME;
BEGIN SELECT CURRENT_TIME INTO the_current_time;
RETURN The_current_time;
END;
$the_current_time$ 
LANGUAGE plpgsql;


Task – create a function that returns the length of a mediatype from the mediatype table
SET SCHEMA 'chinook';
CREATE FUNCTION get_media_length(media_name VARCHAR)
RETURNS VARCHAR AS $media_length$
DECLARE media_length VARCHAR;
BEGIN SELECT LENGTH(media_name) INTO media_length;
RETURN media_length;
END;
$media_length$ LANGUAGE plpgsql;


3.2 System Defined Aggregate Functions
Task – Create a function that returns the average total of all invoices
3.3 User Defined Scalar Functions
Task – Create a function that returns the average price of invoiceline items in the invoiceline table


3.4 User Defined Table Valued Functions
Task – Create a function that returns all employees who are born after 1968.
SET SCHEMA 'chinook';
CREATE FUNCTION born_after_1968()
RETURNS TABLE
(first_name VARCHAR,
last_name VARCHAR) AS $after1968$
BEGIN
RETURN QUERY SELECT firstname, lastname FROM employee 
WHERE birthdate > '1968-12-31';
$after1968$ LANGUAGE plpgsql;


4.0 Stored Procedures
 In this section you will be creating and executing stored procedures. You will be creating various types of stored procedures that take input and output parameters.
4.1 Basic Stored Procedure
Task – Create a stored procedure that selects the first and last names of all the employees.
SET SCHEMA 'chinook';
CREATE FUNCTION employee_names ()
RETURNS TABLE
(first_name VARCHAR,
last_name VARCHAR) 
AS $e_names$
BEGIN 
RETURN QUERY SELECT firstname, lastname FROM employee;
END;
$e_names$ LANGUAGE plpgsql;
4.2 Stored Procedure Input Parameters
Task – Create a stored procedure that updates the personal information of an employee.
SET SCHEMA 'chinook';
CREATE OR REPLACE FUNCTION update¬_employee(new_employeeid INT, 
new_lastName VARCHAR(20), 
new_firstname VARCHAR(20), 
new_title VARCHAR(30), 
new_reportsto INT, 
new_birthdate TIMESTAMP, 
new_hiredate TIMESTAMP, 
new_address VARCHAR(70), 
new_city VARCHAR(40),
new_state VARCHAR(40),
new_country VARCHAR(40),
new_postalcode VARCHAR(10),
new_fax VARCHAR(24),
new_email VARCHAR(60))
RETURNS NULL AS $$
BEGIN UPDATE 
employee SET
lastname = new_lastname,
firstname = new_firstname,
title = new_title,
reportsto = new_reportsto,
birthdate = new_birthdate,
hiredate = new_hiredate,
address = new_address,
city = new_city,
state = new_state,
country = new_country,
postalcode = new_postalcode,
fax = new_fax,
email = new_email
WHERE employeeid = new_employeeid;
END
$$ LANGUAGE plpgadmin;


Task – Create a stored procedure that returns the managers of an employee.
SET SCHEMA 'chinook';
CREATE OR REPLACE FUNCTION employeeManager(employed_id INT)
RETURNS TABLE( EmployeeId INT,
lastName VARCHAR(20),
firstName VARCHAR(20),
title VARCHAR(30),
reportsTo INT,
birthdate TIMESTAMP,
hiredate TIMESTAMP,
address VARCHAR(70),
city VARCHAR(40),
state VARCHAR(40),
country VARCHAR(40),
postalcode VARCHAR(10),
phone VARCHAR(24),
fax VARCHAR(24),
email VARCHAR(60)) AS $$
BEGIN 
RETURN QUERY
SELECT * FROM employee
WHERE employed_id = employee.employeeid;
END;
$$ LANGUAGE plpgsql;


4.3 Stored Procedure Output Parameters
Task – Create a stored procedure that returns the name and company of a customer.

5.0 Transactions
In this section you will be working with transactions. Transactions are usually nested within a stored procedure. You will also be working with handling errors in your SQL.

Task – Create a transaction that given a invoiceId will delete that invoice (There may be constraints that rely on this, find out how to resolve them).
SET SCHEMA 'chinook';
CREATE OR REPLACE FUNCTION delete_invoice(invoice_id INT)
RETURNS BOOLEAN AS $dinvoice$
BEGIN
DELETE FROM invoiceline
WHERE invoiceid = invoice_id;
DELETE FROM invoice
WHERE invoiceid = invoice_id;
END;
$dinvoice$ LANGUAGE plpgsql;





Task – Create a transaction nested within a stored procedure that inserts a new record in the Customer table
SET SCHEMA 'chinook';
CREATE OR REPLACE FUNCTION logCustomer(new_customerid INT, new_firstname VARCHAR(40), new_lastname VARCHAR(20), new_email VARCHAR(60))
RETURNS void AS $replace_f$
BEGIN INSERT INTO customer(customerid, firstname, lastname, email) 
VALUES(new_CustomerId, new_FirstName, new_LastName, new_Email);
END
$repace_f$ LANGUAGE plpgsql;

6.0 Triggers
In this section you will create various kinds of triggers that work when certain DML statements are executed on a table.
6.1 AFTER/FOR
Task - Create an after insert trigger on the employee table fired after a new record is inserted into the table	
SET SCHEMA 'chinook';
CREATE TRIGGER after_insert_employee
AFTER INSERT ON employee
FOR EACH ROW
EXECUTE PROCEDURE suppress_redundant_updates_trigger();






Task – Create an after update trigger on the album table that fires after a row is inserted in the table
SET SCHEMA 'chinook';
CREATE TRIGGER after_update_album
AFTER UPDATE OR INSERT ON album
FOR EACH ROW
EXECUTE PROCEDURE suppress_redundant_updates_trigger();


Task – Create an after delete trigger on the customer table that fires after a row is deleted from the table.
SET SCHEMA 'chinook';
CREATE TRIGGER after_delete_customer
AFTER DELETE ON customer
FOR EACH ROW
EXECUTE PROCEDURE suppress_redundant_updates_trigger();


6.2 Before OF
Task – Create an instead of trigger that restricts the deletion of any invoice that is priced over 50 dollars.
SET SCHEMA 'chinook';
CREATE VIEW invoice_totals 
AS SELECT total FROM invoice WHERE total > 50;
CREATE TRIGGER instead_of_delete_invoice
INSTEAD OF DELETE ON invoice_totals
FOR EACH ROW
EXECUTE PROCEDURE suppress_redundant_updates_trigger();



7.0 JOINS
In this section you will be working with combing various tables through the use of joins. You will work with outer, inner, right, left, cross, and self joins.

7.1 INNER
Task – Create an inner join that joins customers and orders and specifies the name of the customer and the invoiceId.
SET SCHEMA 'chinook';
SELECT firstname, lastname, invoiceid 
FROM customer INNER JOIN invoice
ON customer.customerid = invoice.customerid;


7.2 OUTER
Task – Create an outer join that joins the customer and invoice table, specifying the CustomerId, firstname, lastname, invoiceId, and total.
SET SCHEMA 'chinook';
SELECT Customer.firstname, Customer.lastname, 
invoice.invoiceid, invoice.customerid, 
invoice.total
FROM Customer
FULL OUTER JOIN invoice ON Customer.Customerid=invoice.Customerid;


7.3 RIGHT
Task – Create a right join that joins album and artist specifying artist name and title.
SET SCHEMA 'chinook';
SELECT artist.name, album.title 
FROM album RIGHT JOIN artist
on album.artistid = artist.artistid;


7.4 CROSS
Task – Create a cross join that joins album and artist and sorts by artist name in ascending order.
SET SCHEMA 'chinook';
SELECT * FROM artist
CROSS JOIN album
ORDER BY artist.name ASC;


7.5 SELF
Task – Perform a self-join on the employee table, joining on the reportsto column.
SET SCHEMA 'chinook';
SELECT * FROM employee
AS X INNER JOIN employee 
AS Y ON 
X.reportsto = Y.employeeid;






