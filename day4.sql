SELECT TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS') AS current_date_time FROM DUAL;
SELECT 2 * 2 AS result FROM DUAL;
SELECT ABS(-15) AS absolute_value FROM DUAL;
SELECT SQRT(5) AS square_root FROM DUAL;
SELECT SQRT(5) AS square_root FROM DUAL;
SELECT ROUND(15.19, 1) AS rounded_value FROM DUAL;
SELECT LOWER('IVAN BAYROSS') AS lowercase_name FROM DUAL;
SELECT LOWER('IVAN BAYROSS') AS lowercase_name FROM DUAL;
SELECT UPPER('IVAN BAYROSS') AS uppercase_name FROM DUAL;
SELECT ADD_MONTHS(SYSDATE, 5) AS date_plus_5_months FROM DUAL;
SELECT MONTHS_BETWEEN(TO_DATE('02-JUL-01', 'DD-MON-YY'), TO_DATE('02-JAN-01', 'DD-MON-YY')) AS months_between FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'DD/MM/YYYY') AS formatted_date FROM DUAL;

/*
CURRENT_DATE_TIME
--------------------
24-FEB-2025 10:54:35

RESULT
----------
         4

ABSOLUTE_VALUE
--------------
            15

SQUARE_ROOT
-----------
 2.23606798

ROUNDED_VALUE
-------------
         15.2

LOWERCASE_NA
------------
ivan bayross

UPPERCASE_NA
------------
IVAN BAYROSS

DATE_PLUS
---------
24-JUL-25

MONTHS_BETWEEN
--------------
             6
FORMATTED_
----------
24/02/2025
*/
SQL> ALTER TABLE EMP_SS66
  2  MODIFY EMPNO NUMBER(4) CHECK (EMPNO BETWEEN 7000 AND 8000);

Table altered.

SQL> ALTER TABLE EMP_SS66
  2  MODIFY ENAME VARCHAR(10);

Table altered.

         SQL> ALTER TABLE DEPT_SS66 RENAME COLUMN DNAME TO DEPT_NAME;

Table altered.

SQL> SELECT * FROM DEPT_SS66;

    DEPTNO DEPT_NAME            LOC
---------- -------------------- --------------------
        10 Accounting           New York
        20 Research             Dallas
        30 Sales                Chicago
        40 Operations           Boston

f-p
SELECT ENAME
FROM EMP_SS66
WHERE ENAME LIKE '_i%';
/*
ENAME
-----
Allen
Jones
Blake
Clark
Scott
King 
Ford 
*/
SELECT ENAME
FROM EMP_SS66
WHERE JOB != 'Manager';
/*
ENAME 
------
Smith 
Allen 
Ward  
Martin
Scott 
King  
Turner
Adams 
James 
Ford  
Miller
*/
SELECT 
    MAX(SAL) AS "Maximum",
    MIN(SAL) AS "Minimum",
    SUM(SAL) AS "Total",
    AVG(SAL) AS "Average"
FROM EMP_SS66;
/*
Maximum  Minimum  Total  Average         
-------  -------  -----  ----------------
5000     800      29025  2073.21428571429
*/
SELECT 
    JOB,
    MAX(SAL) AS "Maximum",
    MIN(SAL) AS "Minimum",
    SUM(SAL) AS "Total",
    AVG(SAL) AS "Average"
FROM EMP_SS66
GROUP BY JOB;
/*
JOB        Maximum  Minimum  Total  Average         
---------  -------  -------  -----  ----------------
Analyst    3000     3000     6000   3000.0          
Cleark     800      800      800    800.0           
Clerk      1300     950      3350   1116.66666666667
Manager    2975     2450     8275   2758.33333333333
President  5000     5000     5000   5000.0          
Salesman   1600     1250     5600   1400.0      
*/
SELECT COUNT(*) AS "Number of managers"
FROM EMP_SS66
WHERE JOB = 'Manager';
/*
Number of managers
------------------
3   
*/
SELECT ENAME
FROM EMP_SS66
WHERE HIREDATE > TO_DATE('01-JAN-1980', 'DD-MON-YYYY');
/*
ENAME 
------
Allen 
Ward  
Jones 
Martin
Clark 
Scott 
Turner
James 
Ford  
Miller
*/
SELECT ENAME
FROM EMP_SS66
WHERE JOB = 'Salesman'
AND SAL = (SELECT MAX(SAL) FROM EMP_SS66 WHERE JOB = 'Salesman');
/*
ENAME
-----
Allen
*/
SELECT ENAME
FROM EMP_SS66
WHERE JOB = 'Clerk'
AND SAL = (SELECT MIN(SAL) FROM EMP_SS66 WHERE JOB = 'Clerk');
/*
ENAME
-----
James
*/
SELECT DNAME
FROM DEPT_SS66
WHERE DEPTNO = (SELECT DEPTNO FROM EMP_SS66 WHERE ENAME = 'Ford');
/*
DNAME   
--------
Research
*/
SELECT DNAME
FROM DEPT_SS66
WHERE DEPTNO = (SELECT DEPTNO 
                FROM EMP_SS66
                WHERE SAL = (SELECT MAX(SAL) FROM EMP_SS66));
/*
DNAME     
----------
Accounting
*/
SELECT ENAME
FROM EMP_SS66
WHERE SAL > (SELECT SAL FROM EMP_SS66 WHERE ENAME = 'Turner');
/*
ENAME
-----
Allen
Jones
Blake
Clark
Scott
King 
Ford 
*/





