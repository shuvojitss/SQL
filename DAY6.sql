CREATE TABLE Customers2_SS66 (
    CustomerID NUMBER(2) PRIMARY KEY,
    CustomerName VARCHAR2(30),
    ContactName VARCHAR2(30),
    Address VARCHAR2(50),
    City VARCHAR2(20),
    PostalCode NUMBER(5),
    Country VARCHAR2(10)
);

CREATE TABLE Suppliers2_SS66 (
    SupplierID NUMBER(2) PRIMARY KEY,
    SupplierName VARCHAR2(30),
    ContactName VARCHAR2(30),
    Address VARCHAR2(50),
    City VARCHAR2(20),
    PostalCode NUMBER(5),
    Country VARCHAR2(10)
);

INSERT INTO Customers2_SS66 VALUES (1, 'Alfreds Futter', 'Maria Anders', 'Obere Str.57', 'Berlin', '12209', 'Germany');
INSERT INTO Customers2_SS66 VALUES (2, 'Ana helados', 'Ana Trujillo', 'Avda. Construccion 2222', 'Mexico D.F', '05021', 'Mexico');
INSERT INTO Customers2_SS66 VALUES (3, 'Antonio Moreno', 'Antonio Moreno', 'Mataderos 2312', 'Mexico D.F', '05023', 'Mexico');

INSERT INTO Suppliers2_SS66 VALUES (1, 'Exotic Liquid', 'Charlotte Cooper', '49 Gilbert St.', 'Berlin', '12209', 'Germany');
INSERT INTO Suppliers2_SS66 VALUES (2, 'New Orleans Cajun Delights', 'Shelley Burke', 'P.O. Box 78934', 'Mexico D.F', '05023', 'Mexico');
INSERT INTO Suppliers2_SS66 VALUES (3, 'Grandma Kelly''s Homestead', 'Regina Murphy', '707 Oxford Rd.', 'Ann Arbor', '48104', 'USA');

SELECT * FROM Customers2_SS66;
/*
CUSTOMERID CUSTOMERNAME                   CONTACTNAME                    ADDRESS                                            CITY                 POSTALCODE COUNTRY
---------- ------------------------------ ------------------------------ -------------------------------------------------- -------------------- ---------- ----------
         1 Alfreds Futter                 Maria Anders                   Obere Str.57                                       Berlin                    12209 Germany
         2 Ana helados                    Ana Trujillo                   Avda. Construccion 2222                            Mexico D.F                 5021 Mexico
         3 Antonio Moreno                 Antonio Moreno                 Mataderos 2312                                     Mexico D.F                 5023 Mexico
*/
SELECT * FROM Suppliers2_SS66;
/*
SUPPLIERID SUPPLIERNAME                   CONTACTNAME                    ADDRESS                                            CITY                 POSTALCODE COUNTRY
---------- ------------------------------ ------------------------------ -------------------------------------------------- -------------------- ---------- ----------
         1 Exotic Liquid                  Charlotte Cooper               49 Gilbert St.                                     Berlin                    12209 Germany
         2 New Orleans Cajun Delights     Shelley Burke                  P.O. Box 78934                                     Mexico D.F                 5023 Mexico
         3 Grandma Kelly's Homestead      Regina Murphy                  707 Oxford Rd.                                     Ann Arbor                 48104 USA
*/

SELECT DISTINCT City FROM Customers2_SS66
UNION
SELECT DISTINCT City FROM Suppliers2_SS66;
/*
CITY
--------------------
Ann Arbor
Berlin
Mexico D.F
  */
SELECT City FROM Customers2_SS66
UNION ALL
SELECT City FROM Suppliers2_SS66;
/*
CITY
--------------------
Berlin
Mexico D.F
Mexico D.F
Berlin
Mexico D.F
Ann Arbor
*/
SELECT DISTINCT City FROM Customers2_SS66 WHERE Country = 'Germany'
UNION
SELECT DISTINCT City FROM Suppliers2_SS66 WHERE Country = 'Germany';
/*
CITY
--------------------
Berlin
*/

SELECT c.CustomerName, s.SupplierName 
FROM Customers2_SS66 c 
JOIN Suppliers2_SS66 s ON c.City = s.City;
/*
CUSTOMERNAME                   SUPPLIERNAME
------------------------------ ------------------------------
Alfreds Futter                 Exotic Liquid
Antonio Moreno                 New Orleans Cajun Delights
Ana helados                    New Orleans Cajun Delights
*/
SELECT DISTINCT Country FROM Suppliers2_SS66
MINUS
SELECT DISTINCT Country FROM Customers2_SS66;
/*
COUNTRY
----------
USA
*/
