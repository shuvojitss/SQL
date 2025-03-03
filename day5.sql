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





