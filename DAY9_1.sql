CREATE TABLE emp (
    empno NUMBER PRIMARY KEY,
    ename VARCHAR2(50),
    job VARCHAR2(30),
    mgr NUMBER,
    hiredate DATE,
    sal NUMBER,
    comm NUMBER,
    deptno NUMBER,
    grade NUMBER
);

INSERT INTO emp VALUES (101, 'ALICE', 'SALESMAN', 100, TO_DATE('10-JAN-1981', 'DD-MON-YYYY'), 14000, NULL, 10, 1);
INSERT INTO emp VALUES (102, 'BOB', 'MANAGER', 100, TO_DATE('23-MAY-1981', 'DD-MON-YYYY'), 20000, NULL, 10, 2);
INSERT INTO emp VALUES (103, 'CARL', 'CLERK', 102, TO_DATE('12-DEC-1982', 'DD-MON-YYYY'), 9000, NULL, 20, 3);
INSERT INTO emp VALUES (104, 'DAVID', 'SALESMAN', 100, TO_DATE('05-FEB-1981', 'DD-MON-YYYY'), 13000, NULL, 10, 2);
INSERT INTO emp VALUES (105, 'EMMA', 'ANALYST', 102, TO_DATE('19-APR-1980', 'DD-MON-YYYY'), 24000, NULL, 30, 1);
INSERT INTO emp VALUES (106, 'FIONA', 'CLERK', 104, TO_DATE('09-NOV-1981', 'DD-MON-YYYY'), 8500, NULL, 20, 5);
INSERT INTO emp VALUES (107, 'GEORGE', 'SALESMAN', 100, TO_DATE('11-JUL-1981', 'DD-MON-YYYY'), 12000, NULL, 10, 5);

COMMIT;

DECLARE
    v_acct_no NUMBER := 101; -- example
    v_balance NUMBER := 90;  -- example
    v_min_balance CONSTANT NUMBER := 100;
BEGIN
    IF v_balance < v_min_balance THEN
        v_balance := v_balance - 100;
    END IF;
    DBMS_OUTPUT.PUT_LINE('Account: ' || v_acct_no || ', Balance: ' || v_balance);
END;
/

-- Account: 101, Balance: -10

BEGIN
    FOR rec IN (SELECT ename, SUBSTR(ename,1,3) AS nickname 
                FROM emp 
                WHERE TO_CHAR(hiredate, 'YYYY') = '1981') 
    LOOP
        DBMS_OUTPUT.PUT_LINE('Employee: ' || rec.ename || ', Nickname: ' || rec.nickname);
    END LOOP;
END;
/

/*
Employee: ALICE, Nickname: ALI
Employee: BOB, Nickname: BOB
Employee: DAVID, Nickname: DAV
Employee: FIONA, Nickname: FIO
Employee: GEORGE, Nickname: GEO
*/
BEGIN
    FOR rec IN (SELECT * FROM (
                    SELECT * FROM emp ORDER BY sal DESC
                ) WHERE ROWNUM <= 7)
    LOOP
        DBMS_OUTPUT.PUT_LINE('Employee: ' || rec.ename || ', Salary: ' || rec.sal);
    END LOOP;
END;
/

/*
Employee: EMMA, Salary: 24000
Employee: BOB, Salary: 20000
Employee: ALICE, Salary: 14000
Employee: DAVID, Salary: 13000
Employee: GEORGE, Salary: 12000
Employee: CARL, Salary: 9000
Employee: FIONA, Salary: 8500
*/
CREATE TABLE bonus (
    empno NUMBER,
    ename VARCHAR2(50),
    job VARCHAR2(30),
    sal NUMBER,
    bonus_amount NUMBER
);
BEGIN
    FOR rec IN (SELECT empno, ename, job, sal 
                FROM emp 
                WHERE job = 'SALESMAN' AND sal <= 15000)
    LOOP
        INSERT INTO bonus (empno, ename, job, sal, bonus_amount)
        VALUES (rec.empno, rec.ename, rec.job, rec.sal, rec.sal * 0.2);

        -- PRINT output
        DBMS_OUTPUT.PUT_LINE('Inserted Bonus -> ' || rec.ename || ', Bonus: ' || rec.sal * 0.2);
    END LOOP;
    COMMIT;
END;
/

/*
Inserted Bonus -> ALICE, Bonus: 2800
Inserted Bonus -> DAVID, Bonus: 2600
Inserted Bonus -> GEORGE, Bonus: 2400
*/

-- Insert two employees with lowest salaries
INSERT INTO emp VALUES (108, 'HELEN', 'CLERK', NULL, SYSDATE, 8000, NULL, 40, 2);
INSERT INTO emp VALUES (109, 'IAN', 'CLERK', NULL, SYSDATE, 7500, NULL, 40, 5);

COMMIT;
-----------------------------------------------------------------------------------------

ALTER TABLE emp ADD (last_sal_update DATE);


BEGIN
    FOR rec IN (SELECT empno, sal, grade FROM emp)
    LOOP
        DECLARE
            v_new_sal NUMBER;
        BEGIN
            CASE rec.grade
                WHEN 1 THEN v_new_sal := rec.sal * 1.15;
                WHEN 2 THEN v_new_sal := rec.sal * 1.12;
                WHEN 3 THEN v_new_sal := rec.sal * 1.10;
                WHEN 4 THEN v_new_sal := rec.sal * 1.10;
                WHEN 5 THEN v_new_sal := rec.sal * 1.05;
            END CASE;
            
            -- Update salary and last salary update date
            UPDATE emp
            SET sal = v_new_sal,
                last_sal_update = SYSDATE
            WHERE empno = rec.empno;
            
            -- Insert into salary_history table
            INSERT INTO salary_history (empno, old_salary, new_salary, change_date)
            VALUES (rec.empno, rec.sal, v_new_sal, SYSDATE);

            -- Display output
            DBMS_OUTPUT.PUT_LINE('Updated Employee No: ' || rec.empno ||
                                 ' Old Salary: ' || rec.sal ||
                                 ' New Salary: ' || v_new_sal ||
                                 ' Change Date: ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY'));
        END;
    END LOOP;
    COMMIT;
END;
/

/*
Updated Employee No: 101 Old Salary: 21292.25 New Salary: 24486.0875 Change Date: 28-APR-2025
Updated Employee No: 102 Old Salary: 28098.56 New Salary: 31470.3872 Change Date: 28-APR-2025
Updated Employee No: 103 Old Salary: 11979 New Salary: 13176.9 Change Date: 28-APR-2025
Updated Employee No: 104 Old Salary: 18264.064 New Salary: 20455.75168 Change Date: 28-APR-2025
Updated Employee No: 105 Old Salary: 36501 New Salary: 41976.15 Change Date: 28-APR-2025
Updated Employee No: 106 Old Salary: 9839.8125 New Salary: 10331.803125 Change Date: 28-APR-2025
Updated Employee No: 107 Old Salary: 13891.5 New Salary: 14586.075 Change Date: 28-APR-2025
*/




