DECLARE
  v_balance NUMBER := 800;
  v_acc_no  NUMBER := 500;
BEGIN
  IF v_balance < 1000 THEN
    v_balance := v_balance - 100;
    DBMS_OUTPUT.PUT_LINE('Rs.100 deducted. New balance: ' || v_balance);
  ELSE
    DBMS_OUTPUT.PUT_LINE('Sufficient Balance: ' || v_balance);
  END IF;
END;
/


-- Rs.100 deducted. New balance: 700
