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
('C00004', 'Ashwini Joshi', 'Bangalore', 560001, 'Karnataka', 0),
('C00005', 'Hansel Colaco', 'Mumbai', 400060, 'Maharashtra', 2000),
('C00006', 'Deepak Sharma', 'Mangalore', 560050, 'Karnataka', 0);

INSERT INTO Product_master_SS66 (Product_no, Description, Profit_percent, Unit_measure, Qty_on_hand, Reorder_lvl, Sell_price, Cost_price) VALUES
('P00001', 'T-Shirts', 5, 'Piece', 200, 50, 350, 250),
('P0345', 'Shirts', 6, 'Piece', 150, 50, 500, 350),
('P06734', 'Cotton Jeans', 5, 'Piece', 100, 20, 600, 450),
('P07865', 'Jeans', 5, 'Piece', 100, 20, 750, 500),
('P07868', 'Trousers', 2, 'Piece', 150, 50, 850, 550),
('P07885', 'PuM-Overs', 2.5, 'Piece', 80, 30, 700, 450),
('P07965', 'Denim Shirts', 4, 'Piece', 100, 40, 350, 250),
('P07975', 'Lyers Tops', 5, 'Piece', 70, 30, 300, 175),
('P08865', 'Skirts', 5, 'Piece', 75, 30, 450, 300);



INSERT INTO Salesman_master_SS66 (Salesman_no, Salesman_name, Address1, Address2, City, Pincode, State, Sal_amt, Tgt_to_get, Ydt_sales, Remarks) VALUES
('S00001', 'Aman', 'A/14', 'Worli', 'Mumbai', 400002, 'Maharashtra', 3000, 100, 50, 'Good'),
('S00002', 'Omkar', '65', 'Nariman', 'Mumbai', 400001, 'Maharashtra', 3000, 200, 100, 'Good'),
('S00003', 'Raj', 'P-7', 'Bandra', 'Mumbai', 400032, 'Maharashtra', 3000, 200, 100, 'Good'),
('S00004', 'Ashish', 'A/5', 'Juhu', 'Mumbai', 400044, 'Maharashtra', 3500, 200, 150, 'Good');

INSERT INTO Sales_order_SS66 (Order_no, Client_no, Dely_date, Salesman_no, Dely_type, Billed_yn, Order_date, Order_status) VALUES
('O19001', 'C00001', '20-Jul-02', 'S00001', 'F', 'N', '12-Jun-04', 'in process'),
('O19002', 'C00002', '27-Jun-02', 'S00002', 'P', 'N', '25-Jun-04', 'cancelled'),
('O46865', 'C00003', '20-Feb-02', 'S00003', 'F', 'Y', '18-Feb-04', 'fulfilled'),
('O19003', 'C00001', '07-Apr-02', 'S00001', 'F', 'Y', '03-Apr-04', 'fulfilled'),
('O46866', 'C00004', '22-May-02', 'S00002', 'P', 'N', '20-May-04', 'cancelled'),
('O19008', 'C00005', '26-Jul-02', 'S00004', 'F', 'N', '24-May-04', 'in process');

INSERT INTO Sales_Order_Details (OrderNo, ProductNo, QtyOrdered, QtyDisp, ProductRate) 
VALUES 
  ('O19001', 'P00001', 4, 4, 525),
  ('O19001', 'P07965', 2, 1, 8400),
  ('O19001', 'P07885', 2, 1, 5250),
  ('O19002', 'P00001', 10, 0, 525),
  ('O46865', 'P07868', 3, 3, 3150),
  ('O46865', 'P07885', 3, 1, 5250),
  ('O46865', 'P00001', 10, 10, 525),
  ('O46865', 'P0345', 4, 4, 1050),
  ('O19003', 'P03453', 2, 2, 1050),
  ('O19003', 'P06734', 1, 1, 12000),
  ('O46866', 'P07965', 1, 0, 8400),
  ('O46866', 'P07975', 1, 0, 1050),
  ('O19008', 'P00001', 10, 5, 525),
  ('O19008', 'P07975', 5, 3, 1050);










