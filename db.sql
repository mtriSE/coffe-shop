DROP DATABASE IF EXISTS COFFEE_SHOP;

CREATE DATABASE IF NOT EXISTS COFFEE_SHOP;
USE COFFEE_SHOP;

-- --------------------------------------------------------

--
-- Table structure for table ACCOUNT
--

CREATE TABLE ACCOUNT (
  User_ID VARCHAR(12),
  Password VARCHAR(100),
  Username VARCHAR(100),
  Role VARCHAR(100),
  Avatar VARCHAR(100),
  PRIMARY KEY (User_ID)
);

--
-- Table structure for table MANAGER
--

CREATE TABLE MANAGER (
  Mgr_CCCD VARCHAR(12),
  Fname VARCHAR(100),
  Lname VARCHAR(100),
  DOB DATE,
  Sex CHAR CHECK (Sex = 'M' OR Sex = 'F'),
  Email VARCHAR(100),
  Phone VARCHAR(10),
  Address VARCHAR(100),
  Mgr_start_date DATE,
  PRIMARY KEY (Mgr_CCCD)
);


--
-- Table structure for table STAFF
--

CREATE TABLE STAFF (
  Staff_CCCD VARCHAR(12),
  Fname VARCHAR(100),
  Lname VARCHAR(100),
  DOB DATE,
  Sex CHAR CHECK (Sex = 'M' OR Sex = 'F'),
  Email VARCHAR(100),
  Phone VARCHAR(10),
  Avatar VARCHAR(100),
  Address VARCHAR(100),
  Br_name VARCHAR(10),
  Br_ID VARCHAR(1),
  PRIMARY KEY (Staff_CCCD)
);

--
-- Table structure for table BR_MANAGER
--

CREATE TABLE BR_MANAGER (
  Bmgr_CCCD VARCHAR(12),
  Bmgr_start_date DATE,
  PRIMARY KEY (Bmgr_CCCD)
);

--
-- Table structure for table BARISTA
--

CREATE TABLE BARISTA (
  Bar_CCCD VARCHAR(12),
  Bmgr_CCCD VARCHAR(12),
  Shift_name VARCHAR(100),
  PRIMARY KEY (Bar_CCCD)
);

--
-- Table structure for table SHIFT
--

CREATE TABLE SHIFT (
  Shift_ID CHAR CHECK (Shift_ID = 'M' OR Shift_ID = 'E' OR Shift_ID = 'F'),
  Shift_name VARCHAR(100),
  Shift_start_time DATETIME,
  Shift_end_time DATETIME,
  PRIMARY KEY (Shift_name)
);

--
-- Table structure for table CUSTOMER
--

CREATE TABLE CUSTOMER (
  Customer_CCCD VARCHAR(12),
  Fname VARCHAR(100),
  Lname VARCHAR(100),
  DOB DATE,
  Sex CHAR CHECK (Sex = 'M' OR Sex = 'F'),
  Phone VARCHAR(10),
  Email VARCHAR(100),
  Bank_name VARCHAR(100),
  Bank_number VARCHAR(10),
  Avatar VARCHAR(100),
  VIP_name VARCHAR(4),
  VIP_start_date DATE,
  Point INT,
  Last_time_paid DATETIME,
  PRIMARY KEY (Customer_CCCD)
);

--
-- Table structure for table VIP
--

CREATE TABLE VIP (
  VIP_name VARCHAR(4) ,
  Discount INT,
  Min_point INT,
  Duration INT,
  PRIMARY KEY (VIP_name)
);

--
-- Table structure for table WORK_IN
--

CREATE TABLE WORK_IN (
  Staff_CCCD VARCHAR(12),
  Date_in DATE,
  Date_out DATE,
  Br_ID VARCHAR(1),
  PRIMARY KEY (Staff_CCCD, Date_in),
  CHECK (Date_in < Date_out)
);

--
-- Table structure for table BRANCH
--

CREATE TABLE BRANCH (
  Br_ID VARCHAR(1),
  Br_name VARCHAR(100),
  Bmgr_CCCD VARCHAR(12),
  Br_email VARCHAR(100),
  Br_phone VARCHAR(10),
  Status CHAR CHECK (Status = 'A' OR Status = 'U' OR Status = 'R'), -- Available, Unavailable, Repair
  PRIMARY KEY (Br_ID)
);

--
-- Table structure for table BR_ADDRESS
--

CREATE TABLE BR_ADDRESS (
  Br_ID VARCHAR(1),
  Br_address VARCHAR(100),
  Br_photo VARCHAR(100),
  PRIMARY KEY (Br_ID)
);

--
-- Table structure for table ROOM
--

CREATE TABLE ROOM (
  Room_ID VARCHAR(4)  ,
  Status CHAR CHECK (Status = 'A' OR Status = 'U' OR Status = 'R'), 
  Br_ID VARCHAR(1),
  Room_type_ID VARCHAR(1),
  PRIMARY KEY (Room_ID)
);

--
-- Table structure for table ROOM_TYPE
--

CREATE TABLE ROOM_TYPE (
  Room_type_ID VARCHAR(1),
  Room_type_name VARCHAR(100),
  Max_customer INT,
  Cost INT,
  Board INT, -- số lượng bảng
  TV INT, -- số lượng TV
  Room_photo VARCHAR(100),
  PRIMARY KEY (Room_type_ID)
);

--
-- Table structure for table BILL
--

CREATE TABLE BILL (
  Bill_ID INT(10) NOT NULL AUTO_INCREMENT,
  Total INT,
  Time_paid DATETIME,
  Time_expire DATETIME,
  Bmgr_CCCD VARCHAR(12),
  Customer_CCCD VARCHAR(12),
  Room_ID VARCHAR(4),
  VIP_name VARCHAR(4),
  PRIMARY KEY (Bill_ID, Bmgr_CCCD)
);

--
-- Table structure for table DETAIL
--

CREATE TABLE DETAIL (
  Bill_ID INT(10) NOT NULL AUTO_INCREMENT,
  Amount INT,
  Item_ID VARCHAR(4), 
  PRIMARY KEY (Bill_ID, Item_ID)
);

--
-- Table structure for table MENU
--

CREATE TABLE MENU (
  Bmgr_CCCD VARCHAR(12),
  Item VARCHAR(100), -- bao gồm bảng, TV (cost = 0)
  Item_ID VARCHAR(4),
  Cost INT,
  Item_photo VARCHAR(100), 
  PRIMARY KEY (Item_ID, Bmgr_CCCD)
);

-- --------------------------------------------------------

-- ALTER TABLE --
-- ADD CONSTRAINT--

--
-- Alter table BILL
--

ALTER TABLE BILL 
  AUTO_INCREMENT = 1;

ALTER TABLE BILL 
  ADD CONSTRAINT fk_bill_customer FOREIGN KEY (Customer_CCCD) REFERENCES CUSTOMER(Customer_CCCD)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE BILL 
  ADD CONSTRAINT fk_bill_Bmgr FOREIGN KEY (Bmgr_CCCD) REFERENCES BR_MANAGER(Bmgr_CCCD)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE BILL 
  ADD CONSTRAINT fk_bill_room FOREIGN KEY (Room_ID) REFERENCES ROOM(Room_ID)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE BILL 
  ADD CONSTRAINT fk_bill_vip FOREIGN KEY (VIP_name) REFERENCES VIP(VIP_name)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

--
-- Alter table MENU
--

ALTER TABLE MENU 
  ADD CONSTRAINT fk_menu_Bmgr FOREIGN KEY (Bmgr_CCCD) REFERENCES BR_MANAGER(Bmgr_CCCD)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

--
-- Alter table DETAIL
--

ALTER TABLE DETAIL 
  AUTO_INCREMENT = 1;

ALTER TABLE DETAIL 
  ADD CONSTRAINT fk_detail_bill FOREIGN KEY (Bill_ID) REFERENCES BILL(Bill_ID)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE DETAIL 
  ADD CONSTRAINT fk_detail_item FOREIGN KEY (Item_ID) REFERENCES MENU(Item_ID)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

--
-- Alter table ROOM
--

ALTER TABLE ROOM 
  ADD CONSTRAINT fk_room_branch FOREIGN KEY (Br_ID) REFERENCES BRANCH(Br_ID)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE ROOM 
  ADD CONSTRAINT fk_room_type FOREIGN KEY (Room_type_ID) REFERENCES ROOM_TYPE(Room_type_ID)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

--
-- Alter table BR_ADDRESS
--

ALTER TABLE BR_ADDRESS 
  ADD CONSTRAINT fk_branch_address FOREIGN KEY (Br_ID) REFERENCES BRANCH(Br_ID)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

--
-- Alter table BRANCH
--

ALTER TABLE BRANCH 
  ADD CONSTRAINT fk_branch_Bmgr FOREIGN KEY (Bmgr_CCCD) REFERENCES BR_MANAGER(Bmgr_CCCD)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

--
-- Alter table WORK_IN
--

ALTER TABLE WORK_IN 
  ADD CONSTRAINT fk_work_staff FOREIGN KEY (Staff_CCCD) REFERENCES STAFF(Staff_CCCD)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE WORK_IN 
  ADD CONSTRAINT fk_work_branch FOREIGN KEY (Br_ID) REFERENCES BRANCH(Br_ID)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

--
-- Alter table CUSTOMER
--

ALTER TABLE CUSTOMER 
  ADD CONSTRAINT fk_customer_vip FOREIGN KEY (VIP_name) REFERENCES VIP(VIP_name)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE CUSTOMER 
  ADD CONSTRAINT fk_customer_acc FOREIGN KEY (Customer_CCCD) REFERENCES ACCOUNT(User_ID)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

--
-- Alter table BARISTA
--
ALTER TABLE BARISTA 
  ADD CONSTRAINT fk_barista_CCCD FOREIGN KEY (Bar_CCCD) REFERENCES STAFF(Staff_CCCD)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE BARISTA
  ADD CONSTRAINT fk_barista_Bmgr FOREIGN KEY (Bmgr_CCCD) REFERENCES BR_MANAGER(Bmgr_CCCD)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE BARISTA 
  ADD CONSTRAINT fk_barista_shift FOREIGN KEY (Shift_name) REFERENCES SHIFT(Shift_name)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

--
-- Alter table BR_MANAGER
--

ALTER TABLE BR_MANAGER 
  ADD CONSTRAINT fk_Bmgr_CCCD FOREIGN KEY (Bmgr_CCCD) REFERENCES STAFF(Staff_CCCD)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

--
-- Alter table STAFF
--

ALTER TABLE STAFF 
  ADD CONSTRAINT fk_staff_branch FOREIGN KEY (Br_ID) REFERENCES BRANCH(Br_ID)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE STAFF 
  ADD CONSTRAINT fk_staff_acc FOREIGN KEY (Staff_CCCD) REFERENCES ACCOUNT(User_ID)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

-- -- --------------------------------------------------------
-- -- INSERT DATA

-- --
-- -- INSERT ACCOUNT
-- --

-- -- SET FOREIGN_KEY_CHECKS = 0;
-- INSERT INTO ACCOUNT(User_ID, Password, Username, Role)
-- VALUES
-- ('083203001513', '12345678', 'elHalcon', 'Customer'),
-- ('083203001514', '12345678', 'Titan', 'Customer'),
-- ('095201002925', '12345678', 'Linh Ka', 'Customer'),
-- ('052201010829', '12345678', 'Hùng Phan', 'Customer'),
-- ('083201008742', '12345678', 'Phú Thảo', 'Customer'),
-- ('025303001517', '12345678', 'Anh Lợn', 'Customer'),
-- ('095201002519', '12345678', 'Đức Bo', 'Customer'),
-- ('025303001622', '12345678', 'Nam Nori', 'Customer'),
-- ('025303001515', '12345678', 'Yến Xôi', 'Customer'),
-- ('025303001516', '12345678', 'Myle', 'Customer'),

-- ('083203001517', '12345678', 'Hương Lê', 'Customer'),
-- ('052201010618', '12345678', 'Thảo Mai', 'Customer'),
-- ('083201008719', '12345678', 'Điệp Điệp', 'Customer'),
-- ('083203001720', '12345678', 'Lona', 'Customer'),
-- ('052201010921', '12345678', 'Kim Ngân', 'Customer'),
-- ('052201010922', '12345678', 'Nga Hoàng', 'Customer'),
-- ('052201010923', '12345678', 'Ngọc Trần', 'Customer'),
-- ('052201010925', '12345678', 'Phụng Võ', 'Customer'),
-- ('025303001526', '12345678', 'Trúc Lê', 'Customer'),
-- ('025303001527', '12345678', 'Thanh Lê', 'Customer'),

-- ('095201002828', '12345678', 'Ngọc Nguyễn', 'Branch Manager'),
-- ('083201008829', '12345678', 'Tùng Nguyễn', 'Barista'),
-- ('083203001530', '12345678', 'Hiểu Trần', 'Barista'),
-- ('083203001531', '12345678', 'Thời Nguyễn', 'Barista'),
-- ('095201002932', '12345678', 'Tân Phạm', 'Barista'),

-- ('052201010833', '12345678', 'Vũ Phan', 'Branch Manager'),
-- ('083201008734', '12345678', 'Liêm Nguyễn', 'Barista'),
-- ('025303001535', '12345678', 'Tài Võ', 'Barista'),
-- ('083201008836', '12345678', 'Mẫn Nguyễn', 'Barista'),
-- ('095201002537', '12345678', 'Tài Nguyễn', 'Barista'),

-- ('025303001538', '12345678', 'Ngọc Ngà', 'Branch Manager'),
-- ('025303001539', '12345678', 'Lê Na', 'Barista'),
-- ('083203001518', '12345678', 'Thanh Hương', 'Barista'),
-- ('052201010620', '12345678', 'Thanh Thảo', 'Barista'),
-- ('083201008721', '12345678', 'Phương Khánh', 'Barista'),

-- ('025303001640', '12345678', 'Thanh Nhàn', 'Branch Manager'),
-- ('083203001723', '12345678', 'Linh Phạm', 'Barista'),
-- ('083203001724', '12345678', 'Thiên Hoa', 'Barista'),
-- ('083203001725', '12345678', 'Ngọc Ánh', 'Barista'),
-- ('095201002824', '12345678', 'Kiều Anh', 'Barista'),
-- -- SET FOREIGN_KEY_CHECKS = 1;

-- --
-- -- INSERT CUSTOMER
-- --

-- -- SET FOREIGN_KEY_CHECKS = 0;
-- INSERT INTO CUSTOMER(CCCD_number, Fname, Lname, DOB, Sex, Phone, Email, Avatar, Bank_name, Bank_number, VIP_name, VIP_start_date, Point, Last_time_paid)
-- VALUES
-- ('083203001513', '2021-04-10', 'Nhân', 'Trần Thiện', '2003-10-30', 'M', 'Không', 'Kinh', '0120031030', 'NhanBK@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/656451.jpg', 'OCB', '8020031030', 'Bến Tre', 'Đang ở'),
-- ('083203001514', '2021-04-10', 'Tân', 'Nguyễn Thái', '2003-11-07', 'M', 'Không', 'Kinh', '0120031107', 'TanBK@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/658020.jpg', 'OCB', '8020031107', 'Bến Tre', 'Đang ở'),
-- ('095201002925', '2021-08-14', 'Linh', 'Phạm Nhật', '2001-02-04', 'M', 'Không', 'Kinh', '0911997511', 'Phamnhatlinh0911997515@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/170835.jpg', 'OCB', '8000731001', 'Bạc Liêu', 'Đang ở'),
-- ('052201010829', '2022-09-22', 'Hùng', 'Phan Văn', '2001-01-03', 'M', 'Không', 'Kinh', '0911997512', 'hung.phanpvh0301@hcmut.edu.vn', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/660616.jpg', 'Agribank', '8061002052', 'Khánh Hòa', 'Đang ở'),
-- ('083201008742', '2021-05-04', 'Phú', 'Nguyễn Thanh', '2002-02-02', 'M', 'Không', 'Kinh', '0868854613', 'phu.nguyen02022001@hcmut.edu.vn', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/034205011193.jpg', 'MB', '8012225663', 'Bến Tre', 'Đang ở'),
-- ('025303001517', '2021-04-10', 'Anh', 'Võ Hữu', '2003-05-20', 'M', 'Không', 'Kinh', '0120030514', 'AnhVH@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/54203002733.jpg', 'ACB', '8020030524', 'Vĩnh Long', 'Đang ở'),
-- ('095201002519', '2021-08-14', 'Đức', 'Nguyễn Thành', '2001-07-12', 'M', 'Không', 'Kinh', '0912998815', 'DucNguyen@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/064205000507.jpg', 'Techcombank', '8001234565', 'Quảng Nam', 'Đang ở'),
-- ('025303001622', '2021-04-10', 'Nam', 'Lê Văn', '2003-06-25', 'M', 'Không', 'Kinh', '0120030616', 'NamLV@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/077204003301.jpg', 'Vietinbank', '8020030626', 'Tiền Giang', 'Đang ở'),
-- ('025303001515', '2021-04-10', 'Yến', 'Lìu Ngọc', '2003-01-01', 'F', 'Không', 'Hoa', '0120030117', 'YenBK@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/644700.jpg', 'OCB', '8020030102', 'Đồng Nai', 'Đang ở'),
-- ('025303001516', '2021-04-10', 'My', 'Lê Phạm Hoàng', '2003-12-14', 'F', 'Không', 'Kinh', '0120031218', 'MyNV@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/659113.jpg', 'OCB', '8020031213', 'Đồng Nai', 'Đang ở'),

-- ('083203001517', '2021-04-10', 'Hương', 'Lê Thị', '2003-09-15', 'F', 'Không', 'Kinh', '0120030919', 'HuongLe@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/038305025344.jpg', 'Vietcombank', '8020030913', 'TP. Hồ Chí Minh', 'Đang ở'),
-- ('052201010618', '2022-09-22', 'Thảo', 'Trần Thị', '2002-04-08', 'F', 'Không', 'Kinh', '0912003020', 'ThaoTran@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/630069.jpg', 'BIDV', '8062003041', 'Hải Phòng', 'Đang ở'),
-- ('083201008719', '2021-05-04', 'Điệp', 'Nguyễn Phương', '2002-11-18', 'F', 'Không', 'Kinh', '0868888821', 'DiepNP@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/074305001855.jpg', 'Sacombank', '8029999999', 'Hà Nội', 'Đang ở'),
-- ('083203001720', '2021-06-01', 'Loan', 'Phạm Thị', '2003-03-14', 'F', 'Không', 'Kinh', '0120030322', 'LoanPT@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/53.jpg', 'HSBC', '8020030315', 'Cần Thơ', 'Đang ở'),
-- ('052201010921', '2022-10-22', 'Ngân', 'Lê Kim', '2001-09-01', 'F', 'Không', 'Kinh', '0912001123', 'NganLe@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/038302016745.jpg', 'ANZ', '8062001120', 'Cần Thơ', 'Đang ở'),
-- ('052201010922', '2022-09-22', 'Nga', 'Hoàng Thuý', '2001-09-01', 'F', 'Không', 'Kinh', '0912001124', 'Nga@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/340.jpg', 'ANZ', '8062001121', 'TP. Hồ Chí Minh', 'Đang ở'),
-- ('052201010923', '2022-12-22', 'Ngọc', 'Trần Lê Kim', '2001-09-01', 'F', 'Không', 'Kinh', '0912001125', 'Ngoc@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/092305006578.jpg', 'ANZ', '8062001122', 'Lâm Đồng', 'Đang ở'),
-- ('052201010925', '2022-11-23', 'Phụng', 'Võ Thị', '2001-09-01', 'F', 'Không', 'Kinh', '0912001122', 'Phung@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/633043.jpg', 'ANZ', '8062001123', 'Lâm Đồng', 'Đang ở'),
-- ('025303001526', '2021-04-18', 'Trúc', 'Lê Thanh', '2003-01-01', 'F', 'Không', 'Hoa', '0120001026', 'TrucBK@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/632923.jpg', 'OCB', '8020030100', 'Đồng Nai', 'Đang ở'),
-- ('025303001527', '2021-01-03', 'Thanh', 'Lê Trúc', '2003-12-14', 'F', 'Không', 'Kinh', '0120031227', 'ThanhNV@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/051305009904.jpg', 'OCB', '8020031212', 'Đồng Nai', 'Đang ở'),

-- ('095201002828', '2021-08-22', 'Ngọc', 'Nguyễn Thế', '2001-10-09', 'M', 'Không', 'Kinh', '0912997628', 'MinhNT@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/648637.jpg', 'Standard Chartered', '8009876543', 'Long An', 'Đang ở'),
-- ('083201008829', '2021-07-07', 'Tùng', 'Nguyễn Minh', '2002-08-27', 'M', 'Không', 'Kinh', '0868777629', 'TungNM@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/086205004782.jpg', 'Shinhan Bank', '8112333444', 'Bà Rịa - Vũng Tàu', 'Đang ở'),
-- ('083203001530', '2021-07-03', 'Hiểu', 'Trần Thế', '2003-10-30', 'M', 'Không', 'Kinh', '0120031032', 'HieuBK@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/628913.jpg', 'OCB', '8020031031', 'Bến Tre', 'Đang ở'),
-- ('083203001531', '2021-04-01', 'Thời', 'Nguyễn Thái', '2003-11-07', 'M', 'Không', 'Kinh', '0120031102', 'Thoi@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/629058.jpg', 'OCB', '8020031109', 'Bến Tre', 'Đang ở'),
-- ('095201002932', '2021-08-14', 'Tân', 'Phạm Nhật', '2001-02-04', 'M', 'Không', 'Kinh', '0911997513', 'Phamnhattan0911997515@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/663312.jpg', 'OCB', '8000731000', 'Bạc Liêu', 'Đang ở'),

-- ('052201010833', '2022-09-22', 'Vũ', 'Phan Văn', '2001-01-03', 'M', 'Không', 'Kinh', '0911997515', 'vu.phanpvh0301@hcmut.edu.vn', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/654931.jpg', 'Agribank', '8061002055', 'Khánh Hòa', 'Đang ở'),
-- ('083201008734', '2021-05-04', 'Liêm', 'Nguyễn Thanh', '2002-02-02', 'M', 'Không', 'Kinh', '0868854632', 'liem.nguyen02022001@hcmut.edu.vn', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/056205000367.jpg', 'MB', '8012225667', 'Bến Tre', 'Đang ở'),
-- ('025303001535', '2021-04-30', 'Tài', 'Võ Hữu', '2003-05-20', 'M', 'Không', 'Kinh', '0120030520', 'TaiVH@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/630148.jpg', 'ACB', '8020030520', 'Nghệ An', 'Đang ở'),
-- ('083201008836', '2021-05-04', 'Mẫn', 'Nguyễn Minh', '2002-08-27', 'M', 'Không', 'Kinh', '0868777666', 'ManNM@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/630544.jpg', 'Shinhan Bank', '8012333444', 'Bà Rịa - Vũng Tàu', 'Đang ở'),
-- ('095201002537', '2021-08-17', 'Tài', 'Nguyễn Thành', '2001-07-12', 'M', 'Không', 'Kinh', '0912998822', 'TaiNguyen@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/657512.jpg', 'Techcombank', '8001234567', 'Quảng Nam', 'Đang ở'),

-- ('025303001538', '2021-04-16', 'Ngà', 'Lã Ngọc', '2003-01-01', 'F', 'Không', 'Hoa', '0120030101', 'NgaBK@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/631882.jpg', 'OCB', '8020030101', 'Đồng Nai', 'Đang ở'),
-- ('025303001539', '2021-07-12', 'Na', 'Lê', '2003-12-14', 'F', 'Không', 'Kinh', '0120031214', 'NaNV@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/631796.jpg', 'OCB', '8020031214', 'Đồng Nai', 'Đang ở'),
-- ('083203001518', '2021-06-10', 'Hương', 'Lê Thanh', '2003-09-15', 'F', 'Không', 'Kinh', '0120030915', 'HuongNV@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/631846.jpg', 'Vietcombank', '8020030915', 'Hồ Chí Minh', 'Đang ở'),
-- ('052201010620', '2022-09-22', 'Thảo', 'Trần Thanh', '2002-04-08', 'F', 'Không', 'Kinh', '0912003040', 'ThaoNV@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/631613.jpg', 'BIDV', '8062003040', 'Hải Phòng', 'Đang ở'),
-- ('083201008721', '2021-05-04', 'Khánh', 'Nguyễn Phương', '2002-11-18', 'F', 'Không', 'Kinh', '0868888888', 'KhanhNP@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/644391.jpg', 'Sacombank', '8019999999', 'Hà Nội', 'Đang ở'),

-- ('025303001640', '2021-06-06', 'Nhàn', 'Lê Thanh', '2003-06-25', 'F', 'Không', 'Kinh', '0120030625', 'NhanLV@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/070305005516.jpg', 'Vietinbank', '8020030625', 'Tiền Giang', 'Đang ở'),
-- ('083203001723', '2021-04-11', 'Linh', 'Phạm Thị', '2003-03-14', 'F', 'Không', 'Kinh', '0120030314', 'LinhPT@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/200066.jpg', 'HSBC', '8020030314', 'Cần Thơ', 'Đang ở'),
-- ('083203001724', '2021-05-10', 'Hoa', 'Trương Thiên', '2003-03-14', 'F', 'Không', 'Kinh', '0120030314', 'HoaTT@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/068305003270.jpg', 'HSBC', '8020030315', 'Cần Thơ', 'Đang ở'),
-- ('083203001725', '2021-04-10', 'Ánh', 'Trịnh Ngọc', '2003-03-14', 'F', 'Không', 'Kinh', '0120030314', 'AnhTN@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/079305021038.jpg', 'HSBC', '8020030316', 'Cần Thơ', 'Đang ở'),
-- ('095201002824', '2021-08-14', 'Anh', 'Nguyễn Kiều', '2001-10-09', 'F', 'Không', 'Kinh', '0912997654', 'AnhNK@gmail.com', 'http://svktx.vnuhcm.edu.vn:8010/Data/HinhSV/200356.jpg', 'Standard Chartered', '8009876545', 'Long An', 'Đang ở');
-- -- SET FOREIGN_KEY_CHECKS = 1;

-- Branch: ID - name - address
--         1 - Làng Đại Học - '21, Đông Hoà, Dĩ An, Bình Dương'
--         2 - Bình Thạnh - '31 Ung Văn Khiêm, Phường 25, Bình Thạnh, Thành phố Hồ Chí Minh'
--         3 - Quận 10 - '268 Lý Thường Kiệt, Phường 14, Quận 10, Thành phố Hồ Chí Minh'
--         4 - Bến Xe Miền Tây - '395 Kinh Dương Vương, P. An Lạc, Q. Bình Tân, TP. HCM'

-- Room_type: ID - Name - max - cost - board - TV
--               0 - không - 0 - 0 - 0 - 0
--               1 - sleepbox - 1 - 15000 - 0 - 0
--               2 - nhỏ - 6 - 60000 - 1 - 0
--               3 - lớn - 15 - 120000 - 1 - 1
-- Menu: - cơm(20000), mì(15000), chip(10000), fishball(10000)
--       - cafe(10000), milktea(150000), water(5000), sting(10000)

-- Vip:  name - discount - min_point - duration
--       vip1 - 5000 - 20 - 60
--       vip2 - 10000 - 50 - 30
--       svip - 25000 - 100 - 7

-- Shift:  M - sáng - 7 - 12
--         E - chiều - 13 - 18
--         F - cả ngày - 8 - 17

