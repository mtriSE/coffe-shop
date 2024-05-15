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
  CCCD_date DATE,
  Fname VARCHAR(100),
  Lname VARCHAR(100),
  DOB DATE,
  Sex CHAR CHECK (Sex = 'M' OR Sex = 'F'),
  Email VARCHAR(100),
  Phone VARCHAR(10),
  Avatar VARCHAR(100),
  Address VARCHAR(100),
  Mgr_start_date DATE,
  PRIMARY KEY (Mgr_CCCD)
);


--
-- Table structure for table STAFF
--

CREATE TABLE STAFF (
  Staff_CCCD VARCHAR(12),
  CCCD_date DATE,
  Fname VARCHAR(100),
  Lname VARCHAR(100),
  DOB DATE,
  Sex CHAR CHECK (Sex = 'M' OR Sex = 'F'),
  Email VARCHAR(100),
  Phone VARCHAR(10),
  Avatar VARCHAR(100),
  Address VARCHAR(100),
  Br_name VARCHAR(100),
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
  Shift_start_time TIME,
  Shift_end_time TIME,
  PRIMARY KEY (Shift_name)
);

--
-- Table structure for table CUSTOMER
--

CREATE TABLE CUSTOMER (
  Customer_CCCD VARCHAR(12),
  CCCD_date DATE,
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
  Last_time_paid DATE,
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
  PRIMARY KEY (Bill_ID)
);

--
-- Table structure for table DETAIL
--

CREATE TABLE DETAIL (
  -- Bill_ID INT(10) NOT NULL AUTO_INCREMENT,
  Bill_ID INT(10),
  Amount INT,
  Item_ID VARCHAR(3), 
  PRIMARY KEY (Bill_ID, Item_ID)
);

--
-- Table structure for table MENU
--

CREATE TABLE MENU (
  Bmgr_CCCD VARCHAR(12),
  Item VARCHAR(100), -- bao gồm bảng, TV (cost = 0)
  Item_ID VARCHAR(3),
  Cost INT,
  Item_photo VARCHAR(100), 
  PRIMARY KEY (Bmgr_CCCD, Item_ID)
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

-- ALTER TABLE DETAIL 
--   AUTO_INCREMENT = 1;

ALTER TABLE DETAIL 
  ADD CONSTRAINT fk_detail_bill FOREIGN KEY (Bill_ID) REFERENCES BILL(Bill_ID)
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
  ADD CONSTRAINT fk_staff_acc FOREIGN KEY (Staff_CCCD) REFERENCES ACCOUNT(User_ID)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

-- --------------------------------------------------------
-- INSERT DATA

--
-- INSERT ACCOUNT
--

-- SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO ACCOUNT(User_ID, Password, Username, Role, Avatar)
VALUES
('083203001513', '12345678', 'elHalcon', 'Customer', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/656451.jpg'),
('083203001514', '12345678', 'Titan', 'Customer', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/658020.jpg'),
('095201002925', '12345678', 'Linh Ka', 'Customer', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/170835.jpg'),
('052201010829', '12345678', 'Hùng Phan', 'Customer', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/660616.jpg'),
('083201008742', '12345678', 'Phú Thảo', 'Customer', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/034205011193.jpg'),
('025303001517', '12345678', 'Anh Lợn', 'Customer', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/54203002733.jpg'),
('095201002519', '12345678', 'Đức Bo', 'Customer', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/064205000507.jpg'),
('025303001622', '12345678', 'Nam Nori', 'Customer', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/077204003301.jpg'),
('025303001515', '12345678', 'Yến Xôi', 'Customer', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/644700.jpg'),
('025303001516', '12345678', 'Myle', 'Customer', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/659113.jpg'),

('083203001517', '12345678', 'Hương Lê', 'Customer', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/038305025344.jpg'),
('052201010618', '12345678', 'Thảo Mai', 'Customer', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/630069.jpg'),
('083201008719', '12345678', 'Điệp Điệp', 'Customer', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/074305001855.jpg'),
('083203001720', '12345678', 'Lona', 'Customer', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/53.jpg'),
('052201010921', '12345678', 'Kim Ngân', 'Customer', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/038302016745.jpg'),
('052201010922', '12345678', 'Nga Hoàng', 'Customer', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/340.jpg'),
('052201010923', '12345678', 'Ngọc Trần', 'Customer', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/092305006578.jpg'),
('052201010925', '12345678', 'Phụng Võ', 'Customer', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/633043.jpg'),
('025303001526', '12345678', 'Trúc Lê', 'Customer', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/632923.jpg'),
('025303001527', '12345678', 'Thanh Lê', 'Customer', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/051305009904.jpg'),

('080087001513', '12345678', 'TST', 'Manager', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/200065.jpg'),

('095201002828', '12345678', 'Ngọc Nguyễn', 'Branch Manager', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/648637.jpg'),
('083201008829', '12345678', 'Tùng Nguyễn', 'Barista', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/086205004782.jpg'),
('083203001530', '12345678', 'Hiểu Trần', 'Barista', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/628913.jpg'),
('083203001531', '12345678', 'Thời Nguyễn', 'Barista', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/629058.jpg'),
('095201002932', '12345678', 'Tân Phạm', 'Barista', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/663312.jpg'),

('052201010833', '12345678', 'Vũ Phan', 'Branch Manager', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/654931.jpg'),
('083201008734', '12345678', 'Liêm Nguyễn', 'Barista', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/056205000367.jpg'),
('025303001535', '12345678', 'Tài Võ', 'Barista', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/630148.jpg'),
('083201008836', '12345678', 'Mẫn Nguyễn', 'Barista', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/630544.jpg'),
('095201002537', '12345678', 'Tài Nguyễn', 'Barista', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/657512.jpg'),

('025303001538', '12345678', 'Ngọc Ngà', 'Branch Manager', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/631882.jpg'),
('025303001539', '12345678', 'Lê Na', 'Barista', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/631796.jpg'),
('083203001518', '12345678', 'Thanh Hương', 'Barista', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/631846.jpg'),
('052201010620', '12345678', 'Thanh Thảo', 'Barista', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/631613.jpg'),
('083201008721', '12345678', 'Phương Khánh', 'Barista', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/644391.jpg'),

('025303001640', '12345678', 'Thanh Nhàn', 'Branch Manager', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/070305005516.jpg'),
('083203001723', '12345678', 'Linh Phạm', 'Barista', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/200066.jpg'),
('083203001724', '12345678', 'Thiên Hoa', 'Barista', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/068305003270.jpg'),
('083203001725', '12345678', 'Ngọc Ánh', 'Barista', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/079305021038.jpg'),
('095201002824', '12345678', 'Kiều Anh', 'Barista', 'http://ql.ktxhcm.edu.vn/Data/HinhSV/200356.jpg');

INSERT INTO VIP(VIP_name, Discount, Min_point, Duration)
VALUES
('VIP1', 5000, 20, 60),
('VIP2', 10000, 50, 30),
('SVIP', 25000, 100, 15);

INSERT INTO SHIFT(Shift_ID, Shift_name, Shift_start_time, Shift_end_time)
VALUES
('M', 'Sáng', '07:00:00', '12:00:00'),
('E', 'Chiều', '07:00:00', '18:00:00'),
('F', 'Cả ngày', '08:00:00', '17:00:00');

INSERT INTO STAFF(Staff_CCCD, CCCD_date, Fname, Lname, DOB, Sex, Phone, Email, Avatar, Address, Br_name, Br_ID)
VALUES
('095201002828', '2021-08-22', 'Ngọc', 'Nguyễn Thế', '2001-10-09', 'M','0912997628', 'MinhNT@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/648637.jpg', 'Bến Tre', 'Làng Đại Học', '1'),
('083201008829', '2021-07-07', 'Tùng', 'Nguyễn Minh', '2002-08-27', 'M','0868777629', 'TungNM@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/086205004782.jpg', 'Hà Nội', 'Làng Đại Học', '1'),
('083203001530', '2021-07-03', 'Hiểu', 'Trần Thế', '2003-10-30', 'M','0120031032', 'HieuBK@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/628913.jpg', 'Tiền Giang', 'Làng Đại Học', '1'),
('083203001531', '2021-04-01', 'Thời', 'Nguyễn Thái', '2003-11-07', 'M','0120031102', 'Thoi@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/629058.jpg', 'Tiền Giang', 'Làng Đại Học', '1'),
('095201002932', '2021-08-14', 'Tân', 'Phạm Nhật', '2001-02-04', 'M','0911997513', 'Phamnhattan0911997515@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/663312.jpg', 'Tiền Giang', 'Làng Đại Học', '1'),

('052201010833', '2022-09-22', 'Vũ', 'Phan Văn', '2001-01-03', 'M','0911997515', 'vu.phanpvh0301@hcmut.edu.vn', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/654931.jpg', 'TP. Hồ Chí Minh', 'Bình Thạnh', '2'),
('083201008734', '2021-05-04', 'Liêm', 'Nguyễn Thanh', '2002-02-02', 'M','0868854632', 'liem.nguyen02022001@hcmut.edu.vn', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/056205000367.jpg', 'TP. Hồ Chí Minh', 'Bình Thạnh', '2'),
('025303001535', '2021-04-30', 'Tài', 'Võ Hữu', '2003-05-20', 'M','0120030520', 'TaiVH@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/630148.jpg', 'TP. Hồ Chí Minh', 'Bình Thạnh', '2'),
('083201008836', '2021-05-04', 'Mẫn', 'Nguyễn Minh', '2002-08-27', 'M','0868777666', 'ManNM@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/630544.jpg', 'Đồng Nai', 'Bình Thạnh', '2'),
('095201002537', '2021-08-17', 'Tài', 'Nguyễn Thành', '2001-07-12', 'M','0912998822', 'TaiNguyen@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/657512.jpg', 'Đồng Nai', 'Bình Thạnh', '2'),

('025303001538', '2021-04-16', 'Ngà', 'Lã Ngọc', '2003-01-01', 'F','0120030101', 'NgaBK@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/631882.jpg', 'TP. Hồ Chí Minh', 'Quận 10', '3'),
('025303001539', '2021-07-12', 'Na', 'Lê', '2003-12-14', 'F','0120031214', 'NaNV@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/631796.jpg', 'Lâm Đồng', 'Quận 10', '3'),
('083203001518', '2021-06-10', 'Hương', 'Lê Thanh', '2003-09-15', 'F','0120030915', 'HuongNV@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/631846.jpg', 'Long An', 'Quận 10', '3'),
('052201010620', '2022-09-22', 'Thảo', 'Trần Thanh', '2002-04-08', 'F','0912003040', 'ThaoNV@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/631613.jpg', 'Long An', 'Quận 10', '3'),
('083201008721', '2021-05-04', 'Khánh', 'Nguyễn Phương', '2002-11-18', 'F','0868888888', 'KhanhNP@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/644391.jpg', 'TP. Hồ Chí Minh', 'Quận 10', '3'),

('025303001640', '2021-06-06', 'Nhàn', 'Lê Thanh', '2003-06-25', 'F','0120030625', 'NhanLV@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/070305005516.jpg', 'TP. Hồ Chí Minh', 'Bến Xe Miền Tây', '4'),
('083203001723', '2021-04-11', 'Linh', 'Phạm Thị', '2003-03-14', 'F','0120030314', 'LinhPT@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/200066.jpg', 'Nghệ An', 'Bến Xe Miền Tây', '4'),
('083203001724', '2021-05-10', 'Hoa', 'Trương Thiên', '2003-03-14', 'F','0120030314', 'HoaTT@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/068305003270.jpg', 'Nghệ An', 'Bến Xe Miền Tây', '4'),
('083203001725', '2021-04-10', 'Ánh', 'Trịnh Ngọc', '2003-03-14', 'F','0120030314', 'AnhTN@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/079305021038.jpg', 'TP. Hồ Chí Minh', 'Bến Xe Miền Tây', '4'),
('095201002824', '2021-08-14', 'Anh', 'Nguyễn Kiều', '2001-10-09', 'F','0912997654', 'AnhNK@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/200356.jpg', 'Tiền Giang', 'Bến Xe Miền Tây', '4');

--
-- INSERT CUSTOMER
--

-- SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO CUSTOMER(Customer_CCCD, CCCD_date, Fname, Lname, DOB, Sex, Phone, Email, Avatar, Bank_name, Bank_number, VIP_name, VIP_start_date, Point, Last_time_paid)
VALUES
('083203001513', '2021-04-10', 'Nhân', 'Trần Thiện', '2003-10-30', 'M','0120031030', 'NhanBK@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/656451.jpg', 'OCB', '8020031030', 'VIP1', '2024-04-24', 20, '2024-04-24'),
('083203001514', '2021-04-10', 'Tân', 'Nguyễn Thái', '2003-11-07', 'M','0120031107', 'TanBK@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/658020.jpg', 'OCB', '8020031107', 'VIP1', '2024-04-24', 20, '2024-04-24'),
('095201002925', '2021-08-14', 'Linh', 'Phạm Nhật', '2001-02-04', 'M','0911997511', 'Phamnhatlinh0911997515@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/170835.jpg', 'OCB', '8000731001', 'VIP1', '2024-04-24', 20, '2024-04-24'),
('052201010829', '2022-09-22', 'Hùng', 'Phan Văn', '2001-01-03', 'M','0911997512', 'hung.phanpvh0301@hcmut.edu.vn', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/660616.jpg', 'Agribank', '8061002052', 'VIP2', '2024-04-24', 50, '2024-04-24'),
('083201008742', '2021-05-04', 'Phú', 'Nguyễn Thanh', '2002-02-02', 'M','0868854613', 'phu.nguyen02022001@hcmut.edu.vn', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/034205011193.jpg', 'MB', '8012225663', 'VIP1', '2024-04-24', 20, '2024-04-24'),
('025303001517', '2021-04-10', 'Anh', 'Võ Hữu', '2003-05-20', 'M','0120030514', 'AnhVH@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/54203002733.jpg', 'ACB', '8020030524', 'VIP1', '2024-04-24', 20, '2024-04-24'),
('095201002519', '2021-08-14', 'Đức', 'Nguyễn Thành', '2001-07-12', 'M','0912998815', 'DucNguyen@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/064205000507.jpg', 'Techcombank', '8001234565', 'VIP2', '2024-04-24', 50, '2024-04-24'),
('025303001622', '2021-04-10', 'Nam', 'Lê Văn', '2003-06-25', 'M','0120030616', 'NamLV@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/077204003301.jpg', 'Vietinbank', '8020030626', 'VIP2', '2024-04-24', 50, '2024-04-24'),
('025303001515', '2021-04-10', 'Yến', 'Lìu Ngọc', '2003-01-01', 'F','0120030117', 'YenBK@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/644700.jpg', 'OCB', '8020030102', 'SVIP', '2024-04-24', 100, '2024-04-24'),
('025303001516', '2021-04-10', 'My', 'Lê Phạm Hoàng', '2003-12-14', 'F','0120031218', 'MyNV@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/659113.jpg', 'OCB', '8020031213', 'SVIP', '2024-04-24', 100, '2024-04-24'),

('083203001517', '2021-04-10', 'Hương', 'Lê Thị', '2003-09-15', 'F','0120030919', 'HuongLe@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/038305025344.jpg', 'Vietcombank', '8020030913', 'SVIP', '2024-04-24', 100, '2024-04-24'),
('052201010618', '2022-09-22', 'Thảo', 'Trần Thị', '2002-04-08', 'F','0912003020', 'ThaoTran@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/630069.jpg', 'BIDV', '8062003041', 'VIP1', '2024-04-24', 20, '2024-04-24'),
('083201008719', '2021-05-04', 'Điệp', 'Nguyễn Phương', '2002-11-18', 'F','0868888821', 'DiepNP@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/074305001855.jpg', 'Sacombank', '8029999999', 'SVIP', '2024-04-24', 100, '2024-04-24'),
('083203001720', '2021-06-01', 'Loan', 'Phạm Thị', '2003-03-14', 'F','0120030322', 'LoanPT@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/53.jpg', 'HSBC', '8020030315', 'VIP2', '2024-04-24', 50, '2024-04-24'),
('052201010921', '2022-10-22', 'Ngân', 'Lê Kim', '2001-09-01', 'F','0912001123', 'NganLe@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/038302016745.jpg', 'ANZ', '8062001120', 'VIP2', '2024-04-24', 50, '2024-04-24'),
('052201010922', '2022-09-22', 'Nga', 'Hoàng Thuý', '2001-09-01', 'F','0912001124', 'Nga@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/340.jpg', 'ANZ', '8062001121', 'SVIP', '2024-04-24', 100, '2024-04-24'),
('052201010923', '2022-12-22', 'Ngọc', 'Trần Lê Kim', '2001-09-01', 'F','0912001125', 'Ngoc@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/092305006578.jpg', 'ANZ', '8062001122', 'VIP2', '2024-04-24', 50, '2024-04-24'),
('052201010925', '2022-11-23', 'Phụng', 'Võ Thị', '2001-09-01', 'F','0912001122', 'Phung@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/633043.jpg', 'ANZ', '8062001123', 'VIP2', '2024-04-24', 50, '2024-04-24'),
('025303001526', '2021-04-18', 'Trúc', 'Lê Thanh', '2003-01-01', 'F','0120001026', 'TrucBK@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/632923.jpg', 'OCB', '8020030100', 'SVIP', '2024-04-24', 100, '2024-04-24'),
('025303001527', '2021-01-03', 'Thanh', 'Lê Trúc', '2003-12-14', 'F','0120031227', 'ThanhNV@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/051305009904.jpg', 'OCB', '8020031212', 'SVIP', '2024-04-24', 100, '2024-04-24');

INSERT INTO MANAGER(Mgr_CCCD, CCCD_date, Fname, Lname, DOB, Sex, Phone, Email, Avatar, Address, Mgr_start_date)
VALUES
('080087001513', '2021-04-10', 'Trọng', 'Trang Sĩ', '1987-10-27', 'M', '0319871027', 'TrongAH1@gmail.com', 'https://ql.ktxhcm.edu.vn/Data/HinhSV/200065.jpg', 'Long An', '2022-01-01');

INSERT INTO BR_MANAGER(Bmgr_CCCD, Bmgr_start_date)
VALUES
('095201002828', '2022-01-01'),
('052201010833', '2022-01-01'),
('025303001538', '2022-01-01'),
('025303001640', '2022-01-01');

INSERT INTO BARISTA(Bar_CCCD, Bmgr_CCCD, Shift_name)
VALUES
('083201008829', '095201002828', 'Sáng'),
('083203001530', '095201002828', 'Chiều'),
('083203001531', '095201002828', 'Chiều'),
('095201002932', '095201002828', 'Cả ngày'),

('083201008734', '052201010833', 'Cả ngày'),
('025303001535', '052201010833', 'Cả ngày'),
('083201008836', '052201010833', 'Sáng'),
('095201002537', '052201010833', 'Sáng'),

('025303001539', '025303001538', 'Chiều'),
('083203001518', '025303001538', 'Chiều'),
('052201010620', '025303001538', 'Cả ngày'),
('083201008721', '025303001538', 'Sáng'),

('083203001723', '025303001640', 'Chiều'),
('083203001724', '025303001640', 'Cả ngày'),
('083203001725', '025303001640', 'Sáng'),
('095201002824', '025303001640', 'Sáng');

INSERT INTO BRANCH(Br_ID, Br_name, Bmgr_CCCD, Br_email, Br_phone, Status)
VALUES
('1', 'Làng Đại Học', '095201002828', 'cs1@coffee.com', '0812997628', 'A'),
('2', 'Bình Thạnh', '052201010833', 'cs2@coffee.com', '0811997515', 'A'),
('3', 'Quận 10', '025303001538', 'cs3@coffee.com', '0820030101', 'A'),
('4', 'Bến Xe Miền Tây', '025303001640', 'cs4@coffee.com', '0820030625', 'A');


INSERT INTO BR_ADDRESS(Br_ID, Br_address, Br_photo)
VALUES
('1', '21, Đông Hoà, Dĩ An, Bình Dương', ''),
('2', '31 Ung Văn Khiêm, Phường 25, Quận Bình Thạnh, TP. Hồ Chí Minh', ''),
('3', '268 Lý Thường Kiệt, Phường 14, Quận 10, TP. Hồ Chí Minh', ''),
('4', '395 Kinh Dương Vương, Phường An Lạc, Quận Bình Tân, TP. Hồ Chí Minh', '');

INSERT INTO ROOM_TYPE(Room_type_ID, Room_type_name, Max_customer, Cost, Board, TV, Room_photo)
VALUES
('0', 'Không', 0, 0, 0, 0, ''),
('1', 'Đơn', 1, 15000, 0, 0, ''),
('2', 'Nhỏ', 6, 60000, 1, 0, ''),
('3', 'Lớn', 15, 120000, 1, 1, '');

INSERT INTO ROOM(Room_ID, Status, Br_ID, Room_type_ID)
VALUES
('1100', 'A', '1', '0'),
('1101', 'A', '1', '1'),
('1102', 'A', '1', '1'),
('1103', 'A', '1', '1'),
('1104', 'A', '1', '1'),
('1105', 'A', '1', '2'),
('1106', 'A', '1', '2'),
('1201', 'A', '1', '3'),
('1202', 'A', '1', '3'),

('2100', 'A', '3', '0'),
('2101', 'A', '3', '1'),
('2102', 'A', '3', '1'),
('2103', 'A', '3', '1'),
('2104', 'A', '3', '1'),
('2105', 'A', '3', '2'),
('2106', 'A', '3', '2'),
('2201', 'A', '3', '3'),
('2202', 'A', '3', '3'),

('3100', 'A', '3', '0'),
('3101', 'A', '3', '1'),
('3102', 'A', '3', '1'),
('3103', 'A', '3', '1'),
('3104', 'A', '3', '1'),
('3105', 'A', '3', '2'),
('3106', 'A', '3', '2'),
('3201', 'A', '3', '3'),
('3202', 'A', '3', '3'),

('4100', 'A', '4', '0'),
('4101', 'A', '4', '1'),
('4102', 'A', '4', '1'),
('4103', 'A', '4', '1'),
('4104', 'A', '4', '1'),
('4105', 'A', '4', '2'),
('4106', 'A', '4', '2'),
('4201', 'A', '4', '3'),
('4202', 'A', '4', '3');

INSERT INTO MENU(Bmgr_CCCD, Item, Item_ID, Cost, Item_photo)
VALUES
('095201002828', 'cơm', '101', 20000, ''),
('095201002828', 'mì', '102', 15000, ''),
('095201002828', 'chip', '103', 10000, ''),
('095201002828', 'fishball', '104', 10000, ''),
('095201002828', 'cafe', '105', 10000, ''),
('095201002828', 'milktea', '106', 15000, ''),
('095201002828', 'water', '107', 5000, ''),
('095201002828', 'sting', '108', 10000, ''),

('052201010833', 'cơm', '201', 20000, ''),
('052201010833', 'mì', '202', 15000, ''),
('052201010833', 'chip', '203', 10000, ''),
('052201010833', 'cafe', '204', 10000, ''),
('052201010833', 'milktea', '205', 15000, ''),
('052201010833', 'water', '206', 5000, ''),

('025303001538', 'cơm', '301', 20000, ''),
('025303001538', 'mì', '302', 15000, ''),
('025303001538', 'chip', '303', 10000, ''),
('025303001538', 'cafe', '304', 10000, ''),
('025303001538', 'milktea', '305', 15000, ''),
('025303001538', 'water', '306', 5000, ''),

('025303001640', 'cơm', '401', 20000, ''),
('025303001640', 'mì', '402', 15000, ''),
('025303001640', 'chip', '403', 10000, ''),
('025303001640', 'cafe', '404', 10000, ''),
('025303001640', 'milktea', '405', 15000, ''),
('025303001640', 'water', '406', 5000, '');

INSERT INTO WORK_IN(Staff_CCCD, Date_in, Date_out, Br_ID)
VALUES
('095201002828', '2022-01-01', '2025-01-01', '1'),
('083201008829', '2022-01-01', '2025-01-01', '1'),
('083203001530', '2022-01-01', '2025-01-01', '1'),
('083203001531', '2022-01-01', '2025-01-01', '1'),
('095201002932', '2022-01-01', '2025-01-01', '1'),

('052201010833', '2022-01-01', '2025-01-01', '2'),
('083201008734', '2022-01-01', '2025-01-01', '2'),
('025303001535', '2022-01-01', '2025-01-01', '2'),
('083201008836', '2022-01-01', '2025-01-01', '2'),
('095201002537', '2022-01-01', '2025-01-01', '2'),

('025303001538', '2022-01-01', '2025-01-01', '3'),
('025303001539', '2022-01-01', '2025-01-01', '3'),
('083203001518', '2022-01-01', '2025-01-01', '3'),
('052201010620', '2022-01-01', '2025-01-01', '3'),
('083201008721', '2022-01-01', '2025-01-01', '3'),

('025303001640', '2022-01-01', '2025-01-01', '4'),
('083203001723', '2022-01-01', '2025-01-01', '4'),
('083203001724', '2022-01-01', '2025-01-01', '4'),
('083203001725', '2022-01-01', '2025-01-01', '4'),
('095201002824', '2022-01-01', '2025-01-01', '4');

INSERT INTO BILL(Total, Time_paid, Time_expire, Bmgr_CCCD, Customer_CCCD, Room_ID, VIP_name)
VALUES
(45000,'2024-05-15 08:03:22', '2024-05-15 08:10:00', '095201002828', '083203001513', '1101', 'VIP1'),

(190000,'2024-05-15 13:57:48', '2024-05-15 14:00:15', '025303001538', '025303001526', '3105', 'SVIP');

INSERT INTO DETAIL(Bill_ID, Amount, Item_ID)
VALUES
(1, 1, '101'),
(1, 1, '106'),

(2, 3, '301'),
(2, 3, '302'),
(2, 4, '306'),
(2, 2, '305');
