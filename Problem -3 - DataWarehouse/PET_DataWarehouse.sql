
/*Sample queires for PetUniversity Datawarehouse using star schema */

/* create table COURSE_DETAILS*/

CREATE TABLE COURSE_DETAILS (
   Course_id int NOT NULL,
   Course_name varchar(100) NULL,
   Course_instructor varchar(100) NOT NULL,
   Course_price int NOT NULL,
   Pet_type varchar(100) NOT NULL,
   CONSTRAINT COURSE_DETAILS_pk PRIMARY KEY (Course_id)
);

/* insert sample records into table */

insert into course_details Values (1,'First Aid and Safety','Tom Sandy','$100','Dog' );
insert into course_details Values (2,'CPR','Tom Sandy','$100','cats' );
insert into course_details Values (3,'Pet Grooming','Scott Kirk','$100','birds' );
insert into course_details Values (4,'Pet Grooming','Scott Kirk','$100','horses' );
insert into course_details Values (5,'Pet Sitting and Dog Walking','Sam','$150','Dog' );
insert into course_details Values (6,'Dog Grooming','Jim James','$150','Dog' );
insert into course_details Values (7,'Dog Training 101','Jim James','$150','Dog' );
insert into course_details Values (8,'Advanced Dog Training','John Cena','$150','Dog' );

/* select data from table */

select * from course_details; 

/* create table to store locations */

CREATE TABLE TRAINING_LOCATION (
   Location_id int NOT NULL,
   Location varchar(100) NOT NULL,
   Pet_type varchar(100) NOT NULL,
   CONSTRAINT TRAINING_LOCATION_pk PRIMARY KEY (Location_id)
);	

/* insert sample records into trinaing_location table */ 

insert into training_location values (1,'New Haven','Dog');
insert into training_location values (2,'Hamden','Cat');
insert into training_location values (3,'Woodbridge','Dog');
insert into training_location values (4,'Woodbridge','Cat');
insert into training_location values (5,'Orange','birds');
insert into training_location values (6,'Orange','horses');

/* select data from trinaing_location table */

select * from training_location;

/* create Pet enrollment table */

CREATE TABLE PET_ENROLL (
   Pet_id int NOT NULL,
   Pet_type varchar(100) NOT NULL,
   Pet_first_name varchar(100) NOT NULL,
   Pet_last_name varchar(100),
   Owner_ID int NULL,
   Owner_firt_name varchar(100) NOT NULL,
   Owner_last_name varchar(100),
   CONSTRAINT PET_ENROLL_pk PRIMARY KEY (Pet_id)
);


/* insert sample records into enrollment table */

insert into pet_enroll values (1,'Dog','Dolly','D','101','Suresh','Reddy');
insert into pet_enroll values (2,'Cat','Kiity',NULL,'102','Ken','Hendry');	
insert into pet_enroll values (3,'birds','sim',NULL,'103','Sam','Daly');
insert into pet_enroll values (4,'horses','Jack','Ryan','104','Noma','Kurushi');	
insert into pet_enroll values (5,'Dog','Lilly',NULL,'105','Ryan','Scott');
insert into pet_enroll values (6,'horses','king','Kong','105','Ryan','Scott');

/* select the data from pet enrollment table */

select * from pet_enroll; 

/* create Course enrollment table */

CREATE TABLE COURSE_ENROLL (
   Enroll_id int NOT NULL,
   Enroll_start_date date NOT NULL,
   Grade varchar(10) NOT NULL,
   Course_name varchar(100) NOT NULL,
   Course_instructor varchar(100) NOT NULL,
   Pet_first_name varchar(100) NOT NULL,
   Pet_last_name varchar(100),
   Owner_first_name varchar(100) NOT NULL,
   Location varchar(100) NOT NULL,
   Pet_type varchar(100) NOT NULL,
   CONSTRAINT COURSE_ENROLL_pk PRIMARY KEY (Enroll_id)
);	

/* insert sample records into course enrollment table */

insert into course_enroll values (1,'2019-01-01','PASS','First Aid and Safety','Tom Sandy','Dolly','D','Suresh','New Haven','Dog');
insert into course_enroll values (2,'2018-12-01','PASS','CPR','Tom Sandy','Kiity',NULL,'Ken','Hamden','Cat');
insert into course_enroll values (3,'2019-01-01','PASS','Pet Grooming','Scott Kirk','sim',NULL,'Sam','Orange','birds');
insert into course_enroll values (4,'2019-01-01','PASS','Pet Grooming','Scott Kirk','Jack','Ryan','Noma','Orange','horses');
insert into course_enroll values (5,'2019-01-01','PASS','Dog Grooming','Jim James','Dolly','D','Suresh','New Haven','Dog');
insert into course_enroll values (6,'2018-10-01','FAIL','Advanced Dog Training','John Cena','Lilly',NULL,'Ryan','Woodbridge','Dog');	
insert into course_enroll values (7,'2018-10-01','FAIL','Pet Sitting and Dog Walking','Sam','Lilly',NULL,'Ryan','Woodbridge','Dog');	

/* select data from course enrollemnt */

select * from course_enroll 	;

/* create the table for course hold details */ 

CREATE TABLE COURSE_HOLD (
   Hold_id int NOT NULL,
   Hold_type varchar(100) NOT NULL,
   Hold_description varchar(200) NOT NULL,
   Date date NOT NULL,
   Course_name varchar(100) NOT NULL,
   Course_Instructor varchar(100) NOT NULL,
   Pet_type varchar(100) NOT NULL,
   Pet_first_name varchar(100) NOT NULL,
   Pet_last_name varchar(100),
   Owner_first_name varchar(100) NOT NULL,
   CONSTRAINT COURSE_HOLD_pk PRIMARY KEY (Hold_id)
);

/* insert the sample data into course hold table */

insert into course_hold values (1,'Financial Hold','full tuition is not paid','2018-12-10','CPR','Tom Sandy','Cat','Kiity',NULL,'Ken');
insert into course_hold values (2,'Registration Hold','registration information is missing','2018-10-10','Advanced Dog Training',
	'John Cena','Dog','Lilly',NULL,'Ryan');
insert into course_hold values (3,'Vaccination Hold ','if missing vaccination information','2018-10-10','Pet Sitting and Dog Walking',
	'Sam','Dog','Lilly',NULL,'Ryan');	


/* select the data for course hold details */

select * from course_hold 


/* create the fact table to hold the Pet University details */


CREATE TABLE PET_FACT_TABLE (
   Pet_id int NOT NULL,
   Owner_id int NOT NULL,
   Course_id int NOT NULL,
   Enroll_id int NOT NULL,
   Hold_id int,
   Location_id int NOT NULL,
   Total_amount int DEFAULT '0',
   Fact_key int NOT NULL,
   CONSTRAINT PET_FACT_TABLE_pk PRIMARY KEY (Fact_key)
);

/* insert the sample data based on dimension tables */ 


insert into PET_FACT_TABLE values (1,101,1,1,NULL,1,'$100','1001');
insert into PET_FACT_TABLE values (2,102,2,2,1,2,'$0','1002');
insert into PET_FACT_TABLE values (1,101,6,5,NULL,1,'$150','1003');
insert into PET_FACT_TABLE values (5,105,8,6,2,3,'$150','1004');
insert into PET_FACT_TABLE values (5,105,5,7,3,3,'$150','1005');


/* select the sample fact data */ 

select * from pet_fact_table;
	

/*
1.	How many new pets are enrollment in each course per month?
o	Pet_first_name, Pet_last_name, Pet_type, Owner_fist_name, Owner_last_name, Enrollment_date, Month, location.
*/

select pet_dim.Pet_first_name,
pet_dim.Pet_last_name,
pet_dim.Pet_type, 
pet_dim.Owner_firt_name, 
pet_dim.Owner_last_name,
enrol_dim.Enroll_start_date, 
extract(month from enroll_start_date) as Month,
enrol_dim.location 
from PET_FACT_TABLE  pet_fact 
JOIN PET_ENROLL pet_dim
ON pet_fact.Pet_id=pet_dim.Pet_id
JOIN COURSE_ENROLL enrol_dim
ON pet_fact.Enroll_id=enrol_dim.Enroll_id;


/*
2.	Missing grades report?
o	Pet_first_name, Pet_last_name, Owner_fist_name, Owner_last_name, course_name, course_instructor
*/

select pet_dim.Pet_first_name,
pet_dim.Pet_last_name, 
pet_dim.Owner_firt_name, 
pet_dim.Owner_last_name,
enrol_dim.Course_name, 
enrol_dim.Course_instructor
from PET_FACT_TABLE  pet_fact 
JOIN PET_ENROLL pet_dim
ON pet_fact.Pet_id=pet_dim.Pet_id
JOIN COURSE_ENROLL enrol_dim
ON pet_fact.Enroll_id=enrol_dim.Enroll_id
WHERE enrol_dim.grade IS NULL /* enrol_dim.grade IS NULL ='FAIL'*/
;

/*
3.	Are there holds (financial hold, vaccinations) on the pets that would prevent them from continuing with their training?
o	Pet_first_name, Pet_last_name, Owner_fist_name, Owner_last_name, hold_type, hold_description, month, hold_date, course_price
*/

select pet_dim.Pet_first_name,
pet_dim.Pet_last_name, 
pet_dim.Owner_firt_name, 
pet_dim.Owner_last_name,
hold_dim.Hold_type,
hold_dim.Hold_description,
extract(month from hold_dim.Date) as month,
hold_dim.Date as hold_date,
course_dim.Course_price
from PET_FACT_TABLE  pet_fact 
JOIN PET_ENROLL pet_dim
ON pet_fact.Pet_id=pet_dim.Pet_id
JOIN COURSE_HOLD hold_dim
ON pet_fact.Hold_id=hold_dim.Hold_id
JOIN COURSE_DETAILS course_dim
ON pet_fact.Course_id=course_dim.Course_id;



