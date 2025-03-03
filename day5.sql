CREATE TABLE SAILORS_SS66(
s_id NUMBER(5) PRIMARY KEY,
s_name VARCHAR2(50),
rating NUMBER(2),
age  NUMBER(3)
);

CREATE TABLE BOATS_SS66 (
b_id NUMBER(5) PRIMARY KEY,
b_name VARCHAR2(50),
color VARCHAR2(20)
);

CREATE TABLE RESERVES_SS66(
s_id NUMBER(5), 
b_id NUMBER(5), 
day VARCHAR2(20),
FOREIGN KEY (s_id) REFERENCES SAILORS_SS66(s_id),
FOREIGN KEY (b_id) REFERENCES BOATS_SS66(b_id)
);

INSERT INTO SAILORS VALUES (10001, 'Tarun', 5, 25);
INSERT INTO SAILORS VALUES (10002, 'Amit', 4, 30);
INSERT INTO SAILORS VALUES (10003, 'Ravi', 3, 65);
INSERT INTO SAILORS VALUES (10004, 'Karan', 2, 45);

INSERT INTO BOATS VALUES (20001, 'Titanic', 'Red');
INSERT INTO BOATS VALUES (20002, 'Voyager', 'Green');
INSERT INTO BOATS VALUES (20003, 'Poseidon', 'Blue');

INSERT INTO RESERVES VALUES (10001, 20001, 'Monday');
INSERT INTO RESERVES VALUES (10001, 20002, 'Tuesday');
INSERT INTO RESERVES VALUES (10002, 20002, 'Wednesday');
INSERT INTO RESERVES VALUES (10003, 20003, 'Friday');

SELECT B.color
FROM SAILORS_SS66 S
INNER JOIN RESERVES_SS66 R ON S.s_id = R.s_id
INNER JOIN BOATS_SS66 B ON R.b_id = B.b_id
WHERE S.s_name = 'Tarun';
/*
COLOR
--------------------
Red
Green
*/

SELECT S.s_id, S.s_name
FROM SAILORS_SS66 S
INNER JOIN RESERVES_SS66 R ON S.s_id = R.s_id
WHERE R.day = 'Monday';
/*
S_ID S_NAME
---------- --------------------------------------------------
     10001 Tarun
*/

SELECT b_id, b_name
FROM BOATS_SS66
WHERE color IN ('Red', 'Green');
/*B_ID B_NAME
---------- --------------------------------------------------
     20001 Titanic
     20002 Voyager
*/
DELETE FROM RESERVES_SS66
WHERE s_id IN (SELECT s_id FROM SAILORS_SS66 WHERE age > 60);

DELETE FROM SAILORS_SS66
WHERE age > 60;
/*---------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE Teacher_SS66 (
    Tid NUMBER(5) PRIMARY KEY,
    Name VARCHAR(50),
    Dept VARCHAR(50)
);

CREATE TABLE Subject_SS66 (
    Subno NUMBER(5) PRIMARY KEY,
    Subtitle VARCHAR(50)
);

CREATE TABLE TaughtBy_SS66 (
    Tid NUMBER(5),
    Subno NUMBER(5),
    PRIMARY KEY (Tid, Subno),
    FOREIGN KEY (Tid) REFERENCES Teacher_SS66(Tid),
    FOREIGN KEY (Subno) REFERENCES Subject_SS66(Subno)
);

CREATE TABLE Student_SS66 (
    Rollno NUMBER(5) PRIMARY KEY,
    Sname VARCHAR(50),
    City VARCHAR(50)
);

INSERT INTO Teacher_SS66 VALUES (1, 'Dr. Nisha', 'Physics');
INSERT INTO Teacher_SS66 VALUES (2, 'Dr. Sharma', 'Computer_Science');
INSERT INTO Teacher_SS66 VALUES (3, 'Dr. Gupta', 'Chemistry');
INSERT INTO Teacher_SS66 VALUES (4, 'Dr. Bose', 'Physics');
INSERT INTO Teacher_SS66 VALUES (5, 'Dr. Rao', 'Computer_Science');
INSERT INTO Teacher_SS66 VALUES (6, 'Dr. Mishra', 'Physics');
INSERT INTO Teacher_SS66 VALUES (7, 'Dr. Sen', 'Physics');

INSERT INTO Subject_SS66 VALUES (101, 'Thermodynamics');
INSERT INTO Subject_SS66 VALUES (102, 'DBMS');
INSERT INTO Subject_SS66 VALUES (103, 'Organic Chemistry');
INSERT INTO Subject_SS66 VALUES (104, 'Genetics');
INSERT INTO Subject_SS66 VALUES (105, 'Quantum Physics');
INSERT INTO Subject_SS66 VALUES (106, 'Linear Algebra');
INSERT INTO Subject_SS66 VALUES (107, 'Electromagnetism');

INSERT INTO TaughtBy_SS66 VALUES (1, 101);
INSERT INTO TaughtBy_SS66 VALUES (4, 101);
INSERT INTO TaughtBy_SS66 VALUES (6, 101);
INSERT INTO TaughtBy_SS66 VALUES (2, 102);
INSERT INTO TaughtBy_SS66 VALUES (3, 103);
INSERT INTO TaughtBy_SS66 VALUES (5, 102);
INSERT INTO TaughtBy_SS66 VALUES (7, 107);

INSERT INTO Student_SS66 VALUES (20, 'Alice', 'Kolkata');
INSERT INTO Student_SS66 VALUES (21, 'Bob', 'Kolkata');
INSERT INTO Student_SS66 VALUES (22, 'Charlie', 'Kolkata');
INSERT INTO Student_SS66 VALUES (23, 'David', 'Kolkata');
INSERT INTO Student_SS66 VALUES (24, 'Eve', 'Kolkata');
INSERT INTO Student_SS66 VALUES (25, 'Frank', 'Kolkata');
INSERT INTO Student_SS66 VALUES (26, 'Grace', 'Mumbai');
