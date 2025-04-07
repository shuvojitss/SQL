CREATE TABLE SALESPEOPLE_SS662  (
    SNUM NUMBER PRIMARY KEY,
    SNAME VARCHAR2(50),
    CITY VARCHAR2(50),
    COMM NUMBER
);

CREATE TABLE CUSTOMER_SS662  (
    CNUM NUMBER PRIMARY KEY,
    CNAME VARCHAR2(50),
    CITY VARCHAR2(50),
    RATING NUMBER,
    SNUM NUMBER REFERENCES SALESPEOPLE(SNUM)
);

CREATE TABLE ORDERS_SS662  (
    ONUM NUMBER PRIMARY KEY,
    AMT NUMBER,
    ODATE DATE,
    CNUM NUMBER REFERENCES CUSTOMER(CNUM),
    SNUM NUMBER REFERENCES SALESPEOPLE(SNUM)
);

INSERT INTO SALESPEOPLE_SS662 (SNUM, SNAME, CITY, COMM) VALUES (1001, 'Rahul Sharma', 'Delhi', 1500);
INSERT INTO SALESPEOPLE_SS662 (SNUM, SNAME, CITY, COMM) VALUES (1002, 'Sneha Verma', 'Mumbai', 1800);
INSERT INTO SALESPEOPLE_SS662 (SNUM, SNAME, CITY, COMM) VALUES (1003, 'Amit Joshi', 'Bangalore', 1200);
INSERT INTO SALESPEOPLE_SS662 (SNUM, SNAME, CITY, COMM) VALUES (1004, 'Neha Singh', 'Chennai', 2000);
INSERT INTO SALESPEOPLE_SS662 (SNUM, SNAME, CITY, COMM) VALUES (1005, 'Vikram Mehta', 'Kolkata', 1700);

INSERT INTO CUSTOMER_SS662 (CNUM, CNAME, CITY, RATING, SNUM) VALUES (201, 'GlobalTech Ltd', 'Delhi', 300, 1001);
INSERT INTO CUSTOMER_SS662 (CNUM, CNAME, CITY, RATING, SNUM) VALUES (202, 'NextGen Corp', 'Mumbai', 250, 1002);
INSERT INTO CUSTOMER_SS662 (CNUM, CNAME, CITY, RATING, SNUM) VALUES (203, 'BrightWorks', 'Bangalore', 350, 1003);
INSERT INTO CUSTOMER_SS662 (CNUM, CNAME, CITY, RATING, SNUM) VALUES (204, 'NeoSystems', 'Chennai', 280, 1004);
INSERT INTO CUSTOMER_SS662 (CNUM, CNAME, CITY, RATING, SNUM) VALUES (205, 'GreenEdge Inc', 'Kolkata', 310, 1005);

INSERT INTO ORDERS_SS662 (ONUM, AMT, ODATE, CNUM, SNUM) 
VALUES (301, 5000, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 201, 1001);

INSERT INTO ORDERS_SS662 (ONUM, AMT, ODATE, CNUM, SNUM) 
VALUES (302, 7500, TO_DATE('2024-02-20', 'YYYY-MM-DD'), 202, 1002);

INSERT INTO ORDERS_SS662 (ONUM, AMT, ODATE, CNUM, SNUM) 
VALUES (303, 6400, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 203, 1003);

INSERT INTO ORDERS_SS662 (ONUM, AMT, ODATE, CNUM, SNUM) 
VALUES (304, 8200, TO_DATE('2024-04-05', 'YYYY-MM-DD'), 204, 1004);

INSERT INTO ORDERS_SS662 (ONUM, AMT, ODATE, CNUM, SNUM) 
VALUES (305, 9000, TO_DATE('2024-05-01', 'YYYY-MM-DD'), 205, 1005);

SELECT * FROM SALESPEOPLE_SS662;

/*
      SNUM SNAME                                              CITY                                                     COMM
---------- -------------------------------------------------- -------------------------------------------------- ----------
      1001 Rahul Sharma                                       Delhi                                                    1500
      1002 Sneha Verma                                        Mumbai                                                 1800
      1003 Amit Joshi                                         Bangalore                                                1200
      1004 Neha Singh                                         Chennai                                                  2000
      1005 Vikram Mehta                                       Kolkata                                                  1700
*/
SELECT * FROM CUSTOMER_SS662;
/*
      CNUM CNAME                                              CITY                       RATING        SNUM
---------- -------------------------------------------------- -------------------------------------------------- ---------- ----------
       201 GlobalTech Ltd                                     Delhi                 300        1001
       202 NextGen Corp                                       Mumbai                250        1002
       203 BrightWorks                                        Bangalore             350        1003
       204 NeoSystems                                         Chennai               280        1004
       205 GreenEdge Inc                                      Kolkata               310        1005
*/
SELECT * FROM ORDERS_SS662;
/*
      ONUM        AMT ODATE           CNUM       SNUM
---------- ---------- --------- ---------- ----------
       301       5000 15-JAN-24        201       1001
       302       7500 20-FEB-24        202       1002
       303       6400 10-MAR-24        203       1003
       304       8200 05-APR-24        204       1004
       305       9000 01-MAY-24        205       1005
*/
CREATE VIEW Highest_Rated_Customers_SS662 AS
SELECT * 
FROM CUSTOMER_SS662 
WHERE RATING = (SELECT MAX(RATING) FROM CUSTOMER_SS662);
/*
CNUM CNAME                                              CITY                                                   RATING       SNUM
---------- -------------------------------------------------- -------------------------------------------------- ---------- ----------
203 BrightWorks                                      Bangalore                                                   350       1003
*/
CREATE VIEW Salespersons_By_City_SS662 AS
SELECT CITY, SNAME 
FROM SALESPEOPLE_SS662;
/*
CITY                                               SNAME
-------------------------------------------------- --------------------------------------------------
Delhi                                              Rahul Sharma
Mumbai                                             Sneha Verma
Bangalore                                          Amit Joshi
Chennai                                            Neha Singh
Kolkata                                            Vikram Mehta
*/
CREATE VIEW SP_Order_Summary_SS662 AS
SELECT SNUM,
       COUNT(*) AS Total_Orders,
       AVG(AMT) AS Average_Order_Amount,
       SUM(AMT) AS Total_Order_Amount
FROM ORDERS_SS662
GROUP BY SNUM;
/*
      SNUM TOTAL_ORDERS AVERAGE_ORDER_AMOUNT TOTAL_ORDER_AMOUNT
---------- ------------ -------------------- ------------------
      1003            1                 6400               6400
      1001            1                 5000               5000
      1002            1                 7500               7500
      1004            1                 8200               8200
      1005            1                 9000               9000
*/
CREATE VIEW SP_Multi_Cust_SS662 AS
SELECT SNUM
FROM CUSTOMER_SS662
GROUP BY SNUM
HAVING COUNT(*) > 1;
/*
no rows selected
*/
CREATE VIEW SP_Cust_Orders_SS662 AS
SELECT S.SNAME AS SalespersonName,
       C.CNAME AS CustomerName,
       O.ONUM AS OrderNumber
FROM SALESPEOPLE_SS662 S
JOIN CUSTOMER_SS662 C ON S.SNUM = C.SNUM
JOIN ORDERS_SS662 O ON C.CNUM = O.CNUM;
/*
SALESPERSONNAME                                    CUSTOMERNAME                                       ORDERNUMBER
-------------------------------------------------- -------------------------------------------------- -----------
Rahul Sharma                                       GlobalTech Ltd                                             301
Sneha Verma                                        NextGen Corp                                               302
Amit Joshi                                         BrightWorks                                                303
Neha Singh                                         NeoSystems                                                 304
Vikram Mehta                                       GreenEdge Inc                                              305
*/
CREATE OR REPLACE VIEW SALESPEOPLE_VIEW_SS662 AS
SELECT SNUM, COMM
FROM SALESPEOPLE_SS662
WHERE COMM BETWEEN 1000 AND 2000
WITH CHECK OPTION;
/*
      SNUM       COMM
---------- ----------
      1001       1500
      1002       1800
      1003       1200
      1004       2000
      1005       1700
*/



