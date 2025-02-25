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

