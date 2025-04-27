CREATE TABLE Employee1 (
    EID NUMBER PRIMARY KEY,
    ENAME VARCHAR2(50),
    CITY VARCHAR2(50),
    DESIGNATION VARCHAR2(50),
    SALARY NUMBER(10,2),
    PERKS NUMBER(10,2)
);

-- Insert sample data
INSERT INTO Employee1 VALUES (1, 'John', 'Kolkata', 'Manager', 12000, 450);
INSERT INTO Employee1 VALUES (2, 'Riya', 'Mumbai', 'Analyst', 9000, 600);
INSERT INTO Employee1 VALUES (3, 'Sam', 'Delhi', 'Clerk', 500, 400);

COMMIT;

/*
+-----+-------+---------+------------+--------+-------+
| EID | ENAME | CITY    | DESIGNATION| SALARY | PERKS |
+-----+-------+---------+------------+--------+-------+
|  1  | John  | Kolkata | Manager    | 12000  | 450   |
|  2  | Riya  | Mumbai  | Analyst    | 9000   | 600   |
|  3  | Sam   | Delhi   | Clerk      | 500    | 400   |
+-----+-------+---------+------------+--------+-------+
*/

CREATE OR REPLACE TRIGGER trg_salary_deduction
BEFORE INSERT ON Employee1
FOR EACH ROW
BEGIN
    IF :NEW.PERKS > 500 THEN
        :NEW.SALARY := :NEW.SALARY - 300;
    END IF;
END;
/

INSERT INTO Employee1 VALUES (4, 'Anya', 'Delhi', 'Lead', 13000, 600);
-- Check the data
SELECT * FROM Employee1;

/* 
EID ENAME  CITY      DESIGNATION SALARY PERKS 
--- ------ --------- ----------- ------ ----- 
1   John   Kolkata   Manager     12000  450   
2   Riya   Mumbai    Analyst     9000   600   
3   Sam    Delhi     Clerk       500    400   
4   Anya   Delhi     Lead        12700  600   
*/

CREATE OR REPLACE TRIGGER trg_salary_update
BEFORE UPDATE OF SALARY ON Employee1
FOR EACH ROW
BEGIN
    IF :NEW.SALARY <= 500 THEN
        :NEW.SALARY := 10000;
    ELSE
        :NEW.SALARY := 15000;
    END IF;
END;
/

UPDATE Employee1 SET SALARY = 400 WHERE EID = 2;
-- Check the updated data
SELECT * FROM Employee1;

/*
EID ENAME  CITY      DESIGNATION SALARY PERKS 
--- ------ --------- ----------- ------ ----- 
1   John   Kolkata   Manager     12000  450   
2   Riya   Mumbai    Analyst     10000  600   
3   Sam    Delhi     Clerk       500    400   
4   Anya   Delhi     Lead        12700  600   
*/

-- EMP Table
CREATE TABLE EMP (
    EMPID NUMBER PRIMARY KEY,
    ENAME VARCHAR2(50),
    SALARY NUMBER(10,2)
);

-- EMP_BACKUP Table
CREATE TABLE EMP_BACKUP (
    EMPID NUMBER,
    ENAME VARCHAR2(50),
    SALARY NUMBER(10,2)
);

CREATE OR REPLACE TRIGGER trg_emp_backup
AFTER INSERT ON EMP
FOR EACH ROW
BEGIN
    INSERT INTO EMP_BACKUP (EMPID, ENAME, SALARY)
    VALUES (:NEW.EMPID, :NEW.ENAME, :NEW.SALARY);
END;
/

INSERT INTO EMP VALUES (101, 'Rohan', 12000);
INSERT INTO EMP VALUES (102, 'Meera', 9000);

-- Check both tables
SELECT * FROM EMP;
SELECT * FROM EMP_BACKUP;
/*
EMPID ENAME   SALARY 
----- ------- ------ 
101   Rohan   12000  
102   Meera   9000   

EMPID ENAME   SALARY 
----- ------- ------ 
101   Rohan   12000  
102   Meera   9000   
*/

