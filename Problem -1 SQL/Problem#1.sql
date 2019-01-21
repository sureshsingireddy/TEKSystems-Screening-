/* Create a table called PERSON */

create table PERSON (
    person_id             NUMBER(10)    NOT NULL PRIMARY KEY,
    first_name            VARCHAR2(100),
    preferred_first_name  VARCHAR2(100),
    last_name             VARCHAR2(100) NOT NULL,
    date_of_birth         DATE,
    hire_date             DATE,
    occupation            VARCHAR2(1)
    );

/* Create a table called ADDRESS */

create table ADDRESS ( 
	address_id            NUMBER(10)    NOT NULL,
	person_id             NUMBER(10)    NOT NULL,
    address_type          VARCHAR2(4)   NOT NULL,
    street_line_1         VARCHAR2(100),
    city                  VARCHAR2(100),
    state                 VARCHAR2(100),
    zip_code              VARCHAR2(30),
    PRIMARY KEY (address_id),
    FOREIGN KEY (person_id) REFERENCES Person(person_id)
    );

/* Insert few records in PERSON table */

insert into person values(1,'suresh reddy','suresh','singireddy','1992-06-05','2019-01-17','Software Developer');
insert into person values(2,'samul','sam','adam','1989-11-01','2018-01-11',NULL);
insert into person values(3,'mark','mark','randy','1990-05-11','2018-01-12','Analyst');
insert into person values(4,'Tom',null,'Bruce','1988-02-01','2019-01-01','Tech Lead');

/* Insert few records in ADDRESS table */

insert into address values (1,1,'HOME','89 Lyon Circle','Clifton', 'VA','12345');
insert into address values (2,2,'HOME','212 Maple Ave','Manassas', 'VA','22033');
insert into address values (3,1,'BILL','25 Science Park','New Haven', 'CT','06511');
insert into address values (4,2,'BILL','275 Winchester Ave','New Haven', 'CT','06511');
insert into address values (5,3,'HOME','9405 White Cedar Dr','Owings Mills', 'MA','21117');

/* 1)  Write a query to select all rows from person.  If the person row has a value in preferred_first_name, select the preferred name instead of the value in first name.  Alias the column as REPORTING_NAME. */

SELECT  
CASE WHEN preferred_first_name IS NOT NULL 
THEN preferred_first_name 
ELSE first_name
END AS REPORTING_NAME
FROM PERSON;


/* 2)   Write a query to select all rows from person that have a NULL occupation. */

SELECT * FROM person WHERE occupation IS NULL;


/* 3)  Write a query to select all rows from person that have a date_of_birth before August 7th, 1990.     */ 
       
SELECT * FROM person WHERE date_of_birth <'1990-08-07';

/* 4)  Write a query to select all rows from person that have a hire_date in the past 100 days. */

SELECT * FROM PERSON WHERE HIRE_DATE >= DATE('now','-100 day');

/* 5)  Write a query to select rows from person that also have a row in address with address_type = 'HOME' */

Select * From PERSON P JOIN ADDRESS A ON P.person_id=A.person_id WHERE a.address_type='HOME';


/* 6)  Write a query to select all rows from person and only those rows from address that have a matching billing address (address_type = 'BILL').  If a matching billing address does not exist, display 'NONE' in the address_type column. */

SELECT P.*, CASE WHEN A. address_type IS NULL  
THEN 'NONE' ELSE address_type END AS address_type
FROM PERSON P LEFT OUTER JOIN ADDRESS A ON P.person_id=A.person_id AND a. address_type = 'BILL';


/* 7)  Write a query to count the number of addresses per address type.
    Output:

    address_type     count
       -------------   ------
       HOME                99
       BILL               150 */

SELECT address_type, COUNT(*)  AS count FROM ADDRESS GROUP BY address_type;


/* 8)  Write a query to select data in the following format:

last_name           home_address                          billing_address
------------------  ------------------------------------  ---------------------------------------
Smith               89 Lyon Circle, Clifton, VA 12345     25 Science Park, New Haven, CT 06511
Jones               212 Maple Ave, Manassas, VA 22033     275 Winchester Ave, New Haven, CT 06511 */


/*using joins */
SELECT p.last_name,  
CASE WHEN a.ADDRESS_type='HOME' THEN a.street_line_1||','||a.city||','||a.state||','||a.zip_code END 
AS home_address, 
CASE WHEN b.ADDRESS_type='BILL' THEN b.street_line_1||','||b.city||','||b.state||','||b.zip_code END 
AS billing_address 
FROM person p JOIN address a ON p.person_id=a.person_id
JOIN address b ON a.person_id=b.person_id
WHERE a.ADDRESS_type='HOME' AND b.ADDRESS_type='BILL' 
GROUP BY a.person_id

/* using CTE */
WITH adress_value AS (
SELECT a.person_Id,  
CASE WHEN a.ADDRESS_type='HOME' THEN a.street_line_1||','||a.city||','||a.state||','||a.zip_code 
END AS home_address ,
CASE WHEN b.ADDRESS_type='BILL' THEN b.street_line_1||','||b.city||','||b.state||','||b.zip_code 
END AS billing_address 
FROM address a JOIN address b ON a.person_id=b.person_id WHERE a.ADDRESS_type='HOME' AND b.ADDRESS_type='BILL'
GROUP BY a.person_Id )
SELECT p.last_name, a.home_address,a.billing_address FROM person p JOIN adress_value a ON a.person_id=p.person_id;


/* 9)  Write a query to update the person.occupation column to ‘X’ for all rows that have a ‘BILL’ address in the address table. */

UPDATE person
SET occupation='X'
WHERE person_id IN (SELECT person_id FROM address WHERE address_type='BILL');
