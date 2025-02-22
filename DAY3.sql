CREATE TABLE Client_master_SS66(
Client_no VARCHAR2(6) PRIMARY KEY CHECK (Client_no LIKE 'C%'),
Name VARCHAR2(20) NOT NULL,
City VARCHAR2(15),
Pincode NUMBER(8),
State VARCHAR2(15),
Bal_due NUMBER(10,2)
);

CREATE TABLE product_master_SS66(
Product_no VARCHAR2(6) PRIMARY KEY CHECK (Product_no LIKE 'P%'),
Description VARCHAR2(15) NOT NULL,
Profit_percent NUMBER(4,2) NOT NULL,
Unit_measure VARCHAR2(10) NOT NULL,
Qty_on_hand NUMBER(8) NOT NULL,
Reorder_lvl NUMBER(8) NOT NULL,
Sell_price NUMBER(8,2) NOT NULL CHECK (Sell_price <> '0'),
Cost_price NUMBER(8,2) NOT NULL CHECK (Cost_price <> '0')
);


CREATE TABLE salesman_master_SS66(
Salesman_no VARCHAR2(6) PRIMARY KEY CHECK (Salesman_no LIKE 'S%'),
Salesman_name VARCHAR2(20) NOT NULL,
Address1 VARCHAR2(10) NOT NULL,
Address2 VARCHAR2(10),
City VARCHAR2(20),
Pincode NUMBER(7),
State VARCHAR2(20),
Sal_amt NUMBER(8,2) NOT NULL CHECK (Sal_amt <> '0'),
Tgt_to_get NUMBER(6,2) NOT NULL CHECK (Tgt_to_get <> '0'),
Ydt_sales NUMBER(6,2) NOT NULL,
Remarks VARCHAR2(20)
);


CREATE TABLE sales_order_SS66(
Order_no VARCHAR2(6) PRIMARY KEY CHECK (Order_no LIKE 'O%'),
Order_date DATE,
Client_no VARCHAR2(6) REFERENCES client_master_SS66(Client_no),
Dely_address VARCHAR2(25),
Salesman_no VARCHAR2(6) REFERENCES salesman_master_SS66(Salesman_no),
Dely_type CHAR(1) DEFAULT 'F' CHECK (Dely_type IN ('P', 'F')),
Billed_yn CHAR(1),
Dely_date DATE,
Order_status VARCHAR2(10) CHECK (Order_status IN ('in process', 'fulfilled', 'backorder', 'cancelled')),
CONSTRAINT dt CHECK(Dely_date >= Order_date)
);

CREATE TABLE sales_order_details_SS66(
    Order_no VARCHAR2(6),
    Product_no VARCHAR2(6),
    Qty_ordered NUMBER(8),
    Qty_Disp NUMBER(8),
    Product_rate NUMBER(10,2),
    PRIMARY KEY (Order_no, Product_no),
    FOREIGN KEY (Order_no) REFERENCES sales_order_SS66(Order_no),
    FOREIGN KEY (Product_no) REFERENCES product_master_SS66(Product_no)
);

INSERT INTO Client_master_SS66 (Client_no, Name, City, Pincode, State, Bal_due) VALUES
('C00001', 'Ivan Bayross', 'Mumbai', 400054, 'Maharashtra', 15000),
('C00002', 'Mamta Mazumdar', 'Madras', 780001, 'Tamil Nadu', 0),
('C00003', 'Chhaya Bankar', 'Mumbai', 400057, 'Maharashtra', 5000),
('C00004', 'Ashwini Joshi', 'Bangalore', 560001, 'Karnataka', 2000),
('C00005', 'Hansel Colaco', 'Mumbai', 400060, 'Maharashtra', 2000),
('C00006', 'Deepak Sharma', 'Mangalore', 560050, 'Karnataka', 0);

INSERT INTO Product_master_SS66 (Product_no, Description, Profit_percent, Unit_measure, Qty_on_hand, Reorder_lvl, Sell_price, Cost_price) VALUES
('P00001', 'T-Shirts', 5, 'Piece', 200, 50, 350, 250),
('P0345', 'Shirts', 6, 'Piece', 150, 50, 500, 350),
('P06734', 'Cotton Jeans', 5, 'Piece', 100, 20, 600, 450),
('P07865', 'Jeans', 5, 'Piece', 200, 50, 750, 500),
('P07865', 'Trousers', 2, 'Piece', 150, 50, 850, 550),
('P07885', 'PulM-Overs', 2.5, 'Piece', 150, 40, 700, 450),
('P07965', 'Denim Shirts', 4, 'Piece', 120, 40, 350, 250),
('P07975', 'Lyers Tops', 5, 'Piece', 70, 30, 300, 175),
('P08665', 'Skirts', 5, 'Piece', 75, 30, 450, 300);


INSERT INTO Salesman_master_SS66 (Salesman_no, Salesman_name, Address1, Address2, City, Pincode, State, Sal_amt, Tgt_to_get, Ydt_sales, Remarks) VALUES
('S00001', 'Aman', 'A/14', 'Worli', 'Mumbai', 400002, 'Maharashtra', 3000, 100, 50, 'Good'),
('S00002', 'Omkar', '65', 'Nariman', 'Mumbai', 400001, 'Maharashtra', 3000, 200, 100, 'Good'),
('S00003', 'Raj', 'P-7', 'Bandra', 'Mumbai', 400032, 'Maharashtra', 3000, 200, 100, 'Good'),
('S00004', 'Ashish', 'A/5', 'Juhu', 'Mumbai', 400044, 'Maharashtra', 3500, 200, 150, 'Good');

INSERT INTO Sales_order_SS66 (Order_no, Client_no, Dely_date, Salesman_no, Dely_type, Billed_yn, Order_date, Order_status) VALUES
('O19001', 'C00001', TO_DATE('20-July-02', 'DD-MON-YY'), 'S00001', 'F', 'N', TO_DATE('12-June-04', 'DD-MON-YY'), 'In Process'),
('O19002', 'C00002', TO_DATE('27-June-02', 'DD-MON-YY'), 'S00002', 'P', 'N', TO_DATE('25-June-04', 'DD-MON-YY'), 'Cancelled'),
('O46865', 'C00003', TO_DATE('20-Feb-02', 'DD-MON-YY'), 'S00003', 'F', 'Y', TO_DATE('18-Feb-04', 'DD-MON-YY'), 'Fulfilled'),
('O19003', 'C00001', TO_DATE('07-Apr-02', 'DD-MON-YY'), 'S00001', 'F', 'Y', TO_DATE('03-Apr-04', 'DD-MON-YY'), 'Fulfilled'),
('O19006', 'C00002', TO_DATE('22-May-02', 'DD-MON-YY'), 'S00002', 'F', 'N', TO_DATE('20-May-04', 'DD-MON-YY'), 'Cancelled'),
('O19008', 'C00005', TO_DATE('26-July-02', 'DD-MON-YY'), 'S00004', 'F', 'N', TO_DATE('24-May-04', 'DD-MON-YY'), 'In Process');

INSERT INTO Sales_order_details_SS66 (Order_no, Product_no, Qty_ordered, Qty_disp, Product_rate) VALUES
('O19001', 'P00001', 4, 4, 525),
('O19001', 'P07965', 2, 1, 8400),
('O19001', 'P07885', 2, 1, 5250),
('O19001', 'P07885', 10, 3, 525),
('O46865', 'P07868', 3, 3, 3150),
('O46865', 'P07885', 1, 1, 5250),
('O46865', 'P00001', 10, 4, 1050),
('O46865', 'P0345', 4, 4, 12000),
('O19003', 'P06734', 2, 1, 8400),
('O19006', 'P07965', 1, 1, 525),
('O19008', 'P00001', 10, 3, 1050),
('O19008', 'P07975', 5, 3, 1050);









