CREATE TABLE ZIPCODES_SS66 (
    ZIP NUMBER(10) PRIMARY KEY,
    CITY VARCHAR(50)
);

CREATE TABLE EMPLOYEES_SS66 (
    ENO NUMBER(10) PRIMARY KEY,
    ENAME VARCHAR(50),
    ZIP NUMBER(10),
    HDATE DATE,
    FOREIGN KEY (ZIP) REFERENCES ZIPCODES_SS66(ZIP)
);

CREATE TABLE PARTS_SS66 (
    PNO NUMBER(10) PRIMARY KEY,
    PNAME VARCHAR(50),
    QOH NUMBER(10),  
    PRICE NUMBER(10,2),
    LEVELNO NUMBER(10)
);

CREATE TABLE CUSTOMERS_SS66 (
    CNO NUMBER(10) PRIMARY KEY,
    CNAME VARCHAR(50),
    STREET VARCHAR(100),
    ZIP NUMBER(10),
    PHONE VARCHAR(20),
    FOREIGN KEY (ZIP) REFERENCES ZIPCODES_SS66(ZIP)
);

CREATE TABLE ORDERS_SS66 (
    ONO NUMBER(10) PRIMARY KEY,
    CNO NUMBER(10),
    ENO NUMBER(10),
    PRECEIVED DATE,
    SHIPPED DATE,
    FOREIGN KEY (CNO) REFERENCES CUSTOMERS_SS66(CNO),
    FOREIGN KEY (ENO) REFERENCES EMPLOYEES_SS66(ENO)
);

CREATE TABLE ODETAILS_SS66 (
    ONO NUMBER(10),
    PNO NUMBER(10),
    QTY NUMBER(10),
    PRIMARY KEY (ONO, PNO),
    FOREIGN KEY (ONO) REFERENCES ORDERS_SS66(ONO),
    FOREIGN KEY (PNO) REFERENCES PARTS_SS66(PNO)
);

INSERT INTO ZIPCODES_SS66 VALUES (400001, 'Mumbai');
INSERT INTO ZIPCODES_SS66 VALUES (560001, 'Bangalore');
INSERT INTO ZIPCODES_SS66 VALUES (110001, 'Delhi');
INSERT INTO ZIPCODES_SS66 VALUES (600001, 'Chennai');
INSERT INTO ZIPCODES_SS66 VALUES (700001, 'Kolkata');
INSERT INTO ZIPCODES_SS66 VALUES (122001, 'Gurgaon');

INSERT INTO EMPLOYEES_SS66 VALUES (101, 'Amit', 400001, '23-JUN-2015');
INSERT INTO EMPLOYEES_SS66 VALUES (102, 'Ravi', 560001, '19-JUL-2016');
INSERT INTO EMPLOYEES_SS66 VALUES (103, 'Sita', 110001, '15-FEB-2017');
INSERT INTO EMPLOYEES_SS66 VALUES (104, 'John', 600001, '30-MAR-2018');
INSERT INTO EMPLOYEES_SS66 VALUES (105, 'Mary', 700001, '10-MAY-2019');
INSERT INTO EMPLOYEES_SS66 VALUES (106, 'Krishna', 122001, '01-AUG-2020');

INSERT INTO PARTS_SS66 VALUES (10601, 'Bolt', 500, 5.50, 100);
INSERT INTO PARTS_SS66 VALUES (10602, 'Nut', 300, 2.75, 50);
INSERT INTO PARTS_SS66 VALUES (10603, 'Screw', 700, 9.20, 150);
INSERT INTO PARTS_SS66 VALUES (10604, 'Washer', 900, 50, 200);
INSERT INTO PARTS_SS66 VALUES (10605, 'Clamp', 150, 25000, 80);
INSERT INTO PARTS_SS66 VALUES (10606, 'Bracket', 200, 30000, 60);

INSERT INTO CUSTOMERS_SS66 VALUES (301, 'Samir', 'MG Road', 400001, '9876543210');
INSERT INTO CUSTOMERS_SS66 VALUES (302, 'Sneha', 'Brigade Road', 560001, '8765432109');
INSERT INTO CUSTOMERS_SS66 VALUES (303, 'Vikas', 'Connaught Place', 110001, '7654321098');
INSERT INTO CUSTOMERS_SS66 VALUES (304, 'Ramesh', 'T Nagar', 600001, '6543210987');
INSERT INTO CUSTOMERS_SS66 VALUES (305, 'Pooja', 'Salt Lake', 700001, '5432109876');
INSERT INTO CUSTOMERS_SS66 VALUES (306, 'Kiran', 'Cyber Hub', 122001, '4321098765');

INSERT INTO ORDERS_SS66 VALUES (401, 301, 101, '15-JAN-2024', '20-JAN-2024');
INSERT INTO ORDERS_SS66 VALUES (402, 302, 102, '10-FEB-2024', NULL);
INSERT INTO ORDERS_SS66 VALUES (403, 303, 103, '05-MAR-2024', '08-MAR-2024');
INSERT INTO ORDERS_SS66 VALUES (404, 304, 104, '12-APR-2024', '18-APR-2024');
INSERT INTO ORDERS_SS66 VALUES (405, 305, 105, '08-MAY-2024', NULL);
INSERT INTO ORDERS_SS66 VALUES (406, 306, 106, '02-JUN-2024', '10-JUN-2024');

INSERT INTO ODETAILS_SS66 VALUES (401, 10601, 10);
INSERT INTO ODETAILS_SS66 VALUES (401, 10602, 20);
INSERT INTO ODETAILS_SS66 VALUES (402, 10603, 30);
INSERT INTO ODETAILS_SS66 VALUES (403, 10604, 40);
INSERT INTO ODETAILS_SS66 VALUES (404, 10605, 50);
INSERT INTO ODETAILS_SS66 VALUES (405, 10606, 60);

SELECT PNO, PNAME
FROM PARTS_SS66
WHERE PRICE < 20;
/*
     PNO PNAME
---------- --------------------------------------------------
     10601 Bolt
     10602 Nut
     10603 Screw
*/
SELECT DISTINCT PNO
FROM ODETAILS_SS66;
/*
 PNO
----------
     10602
     10604
     10603
     10605
     10606
     10601
*/
SELECT *
FROM CUSTOMERS_SS66
WHERE CNAME LIKE 'S%';
/*
CNO CNAME                                              STREET         ZIP PHONE
---------- -------------------------------------------------- ---------------------------------------------------------------------------------------------------- ---------- --------------------
       301 Samir                                              MG Road             400001 9876543210
       302 Sneha                                              Brigade Road        560001 8765432109
*/
SELECT O.ONO, C.CNAME
FROM ORDERS_SS66 O
INNER JOIN CUSTOMERS_SS66 C ON O.CNO = C.CNO
WHERE O.SHIPPED IS NULL;
/*
       ONO CNAME
---------- --------------------------------------------------
       402 Sneha
       405 Pooja
*/
SELECT C.CNAME, E.ENAME
FROM ORDERS_SS66 O
INNER JOIN CUSTOMERS_SS66 C ON O.CNO = C.CNO
INNER JOIN EMPLOYEES_SS66 E ON O.ENO = E.ENO;
/*
CNAME                                              ENAME
-------------------------------------------------- --------------------------------------------------
Samir                                              Amit
Sneha                                              Ravi
Vikas                                              Sita
Ramesh                                             John
Pooja                                              Mary
Kiran                                              Krishna
*/
SELECT ENAME
FROM EMPLOYEES_SS66
WHERE HDATE = (SELECT MIN(HDATE) FROM EMPLOYEES_SS66);
/*
ENAME
--------------------------------------------------
Amit
*/
SELECT PNO, PNAME, PRICE
FROM PARTS_SS66
WHERE PRICE > 20000
ORDER BY PNO ASC;
/*
       PNO PNAME                                                   PRICE
---------- -------------------------------------------------- ----------
     10605 Clamp                                                   25000
     10606 Bracket                                                 30000
*/
SELECT P.PNO, P.PNAME, SUM(O.QTY) AS TOTAL_SALES
FROM PARTS_SS66 P
INNER JOIN ODETAILS_SS66 O ON P.PNO = O.PNO
GROUP BY P.PNO, P.PNAME;
/*
       PNO PNAME                                              TOTAL_SALES
---------- -------------------------------------------------- -----------
     10604 Washer                                                      40
     10605 Clamp                                                       50
     10601 Bolt                                                        10
     10603 Screw                                                       30
     10606 Bracket                                                     60
     10602 Nut                                                         20
*/
SELECT SUM(QTY) AS TOTAL_QUANTITY
FROM ODETAILS_SS66
WHERE PNO = 10601;
/*
TOTAL_QUANTITY
--------------
            10
*/
SELECT E.ENO
FROM EMPLOYEES_SS66 E
NATURAL JOIN ZIPCODES_SS66 Z
WHERE Z.CITY = 'Mumbai';
/*
       ENO
----------
       101
*/
