CREATE TABLE SAILORS (
    s_id NUMBER(5) PRIMARY KEY,
    s_name VARCHAR2(50),
    rating NUMBER(2),
    age NUMBER(3)
);

CREATE TABLE BOATS (
    b_id NUMBER(5) PRIMARY KEY,
    b_name VARCHAR2(50),
    color VARCHAR2(20)
);

CREATE TABLE RESERVES (
    s_id NUMBER(5),
    b_id NUMBER(5),
    day VARCHAR2(20),
    PRIMARY KEY (s_id, b_id),
    FOREIGN KEY (s_id) REFERENCES SAILORS(s_id),
    FOREIGN KEY (b_id) REFERENCES BOATS(b_id)
);

-- SAILORS table
INSERT INTO SAILORS VALUES (101, 'Tarun', 5, 25);
INSERT INTO SAILORS VALUES (102, 'Rahul', 4, 30);
INSERT INTO SAILORS VALUES (103, 'Amit', 3, 65);
INSERT INTO SAILORS VALUES (104, 'Pooja', 2, 28);
INSERT INTO SAILORS VALUES (105, 'Rohit', 4, 55);
INSERT INTO SAILORS VALUES (106, 'Neha', 3, 40);

-- BOATS table
INSERT INTO BOATS VALUES (201, 'Speedster', 'red');
INSERT INTO BOATS VALUES (202, 'Wave Rider', 'green');
INSERT INTO BOATS VALUES (203, 'Blue Whale', 'blue');
INSERT INTO BOATS VALUES (204, 'Ocean King', 'red');
INSERT INTO BOATS VALUES (205, 'Sea Breeze', 'green');
INSERT INTO BOATS VALUES (206, 'Storm Breaker', 'yellow');

-- RESERVES table
INSERT INTO RESERVES VALUES (101, 201, 'Monday');
INSERT INTO RESERVES VALUES (102, 202, 'Monday');
INSERT INTO RESERVES VALUES (101, 203, 'Tuesday');
INSERT INTO RESERVES VALUES (103, 204, 'Sunday');
INSERT INTO RESERVES VALUES (105, 205, 'Wednesday');
INSERT INTO RESERVES VALUES (106, 206, 'Friday');

SELECT * FROM SAILORS;

/*s_id  s_name  rating  age
----  ------  ------  ---
101   Tarun   5       25 
102   Rahul   4       30 
103   Amit    3       65
104   Pooja   2       28 
105   Rohit   4       55 
106   Neha    3       40 
*/

SELECT * FROM BOATS;

/*
b_id  b_name         color 
----  -------------  ------
201   Speedster      red   
202   Wave Rider     green 
203   Blue Whale     blue  
204   Ocean King     red   
205   Sea Breeze     green 
206   Storm Breaker  yellow
*/

SELECT * FROM RESERVES;

/* 
s_id  b_id  day      
----  ----  ---------
103   201   Monday   
102   202   Monday   
101   203   Tuesday  
104   204   Sunday   
105   205   Wednesday
106   206   Friday 
*/

SELECT BOATS.color 
FROM SAILORS 
INNER JOIN RESERVES ON SAILORS.s_id = RESERVES.s_id 
INNER JOIN BOATS ON RESERVES.b_id = BOATS.b_id 
WHERE SAILORS.s_name = 'Tarun';
/*
color
-----
red  
blue
*/

SELECT DISTINCT SAILORS.s_id, SAILORS.s_name 
FROM SAILORS 
INNER JOIN RESERVES ON SAILORS.s_id = RESERVES.s_id 
WHERE RESERVES.day = 'Monday';
/*
s_id  s_name
----  ------
101   Tarun 
102   Rahul
*/

SELECT b_id, b_name 
FROM BOATS 
WHERE color IN ('red', 'green');
/*
b_id  b_name    
----  ----------
201   Speedster 
202   Wave Rider
204   Ocean King
205   Sea Breeze
*/

DELETE FROM SAILORS  
WHERE age > 60;
------------------------------------------------------------------------------------------------
CREATE TABLE TEACHER (
    Tid NUMBER(5) PRIMARY KEY,
    Name VARCHAR2(50),
    Dept VARCHAR2(50)
);

CREATE TABLE SUBJECT (
    Subno NUMBER(5) PRIMARY KEY,
    Subtitle VARCHAR2(50)
);

CREATE TABLE TAUGHTBY (
    Tid NUMBER(5),
    Subno NUMBER(5),
    PRIMARY KEY (Tid, Subno),
    FOREIGN KEY (Tid) REFERENCES TEACHER(Tid),
    FOREIGN KEY (Subno) REFERENCES SUBJECT(Subno)
);

CREATE TABLE STUDENT (
    Rollno NUMBER(5) PRIMARY KEY,
    Sname VARCHAR2(50),
    City VARCHAR2(50)
);

-- TEACHER table
INSERT INTO TEACHER VALUES (301, 'Dr. Sharma', 'Physics');
INSERT INTO TEACHER VALUES (302, 'Dr. Verma', 'Physics');
INSERT INTO TEACHER VALUES (303, 'Dr. Singh', 'Mathematics');
INSERT INTO TEACHER VALUES (304, 'Dr. Patel', 'Computer Science');
INSERT INTO TEACHER VALUES (305, 'Dr. Gupta', 'Physics');
INSERT INTO TEACHER VALUES (306, 'Dr. Mehta', 'Chemistry');

-- SUBJECT table
INSERT INTO SUBJECT VALUES (401, 'Thermodynamics');
INSERT INTO SUBJECT VALUES (402, 'DBMS');
INSERT INTO SUBJECT VALUES (403, 'Data Structures');
INSERT INTO SUBJECT VALUES (404, 'Machine Learning');
INSERT INTO SUBJECT VALUES (405, 'Quantum Physics');
INSERT INTO SUBJECT VALUES (406, 'Statistics');

-- TAUGHTBY table
INSERT INTO TAUGHTBY VALUES (301, 401);
INSERT INTO TAUGHTBY VALUES (302, 401);
INSERT INTO TAUGHTBY VALUES (305, 405);
INSERT INTO TAUGHTBY VALUES (304, 402);
INSERT INTO TAUGHTBY VALUES (303, 403);
INSERT INTO TAUGHTBY VALUES (306, 406);

-- STUDENT table
INSERT INTO STUDENT VALUES (22, 'Ankit', 'Kolkata');
INSERT INTO STUDENT VALUES (23, 'Neha', 'Kolkata');
INSERT INTO STUDENT VALUES (24, 'Ravi', 'Mumbai');
INSERT INTO STUDENT VALUES (25, 'Swati', 'Kolkata');
INSERT INTO STUDENT VALUES (26, 'Vikas', 'Kolkata');
INSERT INTO STUDENT VALUES (27, 'Priya', 'Delhi');

SELECT * FROM SUBJECT;

/*
Subno  Subtitle        
-----  ----------------
401    Thermodynamics  
402    RDBMS           
403    Data Structures 
404    Machine Learning
405    Quantum Physics 
406    Statistics   
*/

SELECT * FROM TAUGHTBY;

/*
Tid  Subno
---  -----
301  401  
302  401  
305  405  
304  402  
303  403  
306  406  
*/

SELECT * FROM STUDENT;

/*
Rollno  Sname  City   
------  -----  -------
22     Ankit  Kolkata
23     Neha   Kolkata
24     Ravi   Mumbai 
25     Swati  Kolkata
26     Vikas  Kolkata
27     Priya  Delhi  
*/

SELECT * FROM TEACHER;

/*
Tid  Name        Dept            
---  ----------  ----------------
301  Dr. Sharma  Physics         
302  Dr. Verma   Physics         
303  Dr. Singh   Mathematics     
304  Dr. Patel   Computer Science
305  Dr. Gupta   Physics         
306  Dr. Mehta   Chemistry 
*/

SELECT TEACHER.Name 
FROM TEACHER 
INNER JOIN TAUGHTBY ON TEACHER.Tid = TAUGHTBY.Tid 
INNER JOIN SUBJECT ON TAUGHTBY.Subno = SUBJECT.Subno 
WHERE TEACHER.Dept = 'Physics' 
AND SUBJECT.Subtitle = 'Thermodynamics';
/*
Name      
----------
Dr. Sharma
Dr. Verma 
*/

UPDATE SUBJECT 
SET Subtitle = 'RDBMS' 
WHERE Subtitle = 'DBMS';

/*
SELECT * FROM SUBJECT;
Subno  Subtitle        
-----  ----------------
401    Thermodynamics  
402    RDBMS           
403    Data Structures 
404    Machine Learning
405    Quantum Physics 
406    Statistics 
*/

SELECT * FROM Students WHERE City='Kolkata' AND Rollno BETWEEN 20 AND 25;
SELECT * FROM Students WHERE City ='Kolkata' ORDER BY Rollno DESC;


