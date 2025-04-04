CREATE DATABASE eCommerce
use eCommerce

CREATE TABLE Customer(
CustomerID CHAR(5) NOT NULL PRIMARY KEY, 
CONSTRAINT cekCustomerID CHECK(CustomerID LIKE 'CU[0-9][0-9][0-9]'),

CustomerName VARCHAR(50) NOT NULL,

CustomerGender VARCHAR(10),
CONSTRAINT cekCustomerGender 
CHECK(CustomerGender = 'Male' or CustomerGender = 'Female'),

CustomerPhone VARCHAR(13),
CustomerAddress VARCHAR(100)
);

-- query utk buat tabel Staff
CREATE TABLE Staff(
StaffID CHAR(5) NOT NULL PRIMARY KEY,
CONSTRAINT cekStaffID CHECK(StaffID LIKE 'SF[0-9][0-9][0-9]'),

StaffName VARCHAR(50) NOT NULL,

StaffGender VARCHAR(10),
CONSTRAINT cekStaffGender 
CHECK(StaffGender = 'Male' or StaffGender = 'Female'),

StaffPhone VARCHAR(13),
StaffAddress VARCHAR(100),
StaffSalary NUMERIC(11,2),

StaffPosition VARCHAR(20)
);

CREATE TABLE ItemType (
  ItemTypeID CHAR(5) NOT NULL PRIMARY KEY,
  ItemTypeName VARCHAR(50) NOT NULL,

  -- CONSTRAINT ItemTypeID LIKE 'IT[0-9][0-9][0-9]'
  CONSTRAINT cekIDItemType CHECK(ItemTypeID LIKE 'IT[0-9][0-9][0-9]')
);

CREATE TABLE Item (
  ItemID CHAR(5) NOT NULL PRIMARY KEY,
  --foreign key dari ItemType
  ItemTypeID CHAR(5) NOT NULL REFERENCES ItemType ON UPDATE CASCADE ON DELETE CASCADE,
  ItemName VARCHAR(15) NOT NULL,
  Price NUMERIC(11,2),
  Quantity INTEGER,

  -- CONSTRAINT ItemID LIKE 'IM[0-9][0-9][0-9]'
  CONSTRAINT cekIDItem CHECK(ItemID LIKE 'IM[0-9][0-9][0-9]')
);

CREATE TABLE HeaderSellTransaction (
  TransactionID CHAR(5) NOT NULL PRIMARY KEY,
  --foreign key dari Customer
  CustomerID CHAR(50) NOT NULL,
  --foreign key dari Staff
  StaffID CHAR(10) NOT NULL,
  TransactionDate DATE,
  PaymentType VARCHAR(20),

  -- CONSTRAINT TransactionID LIKE 'TR[0-9][0-9][0-9]',
  CONSTRAINT CekIDTrans CHECK(TransactionID LIKE 'TR[0-9][0-9][0-9]'),
  CONSTRAINT FK_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) 
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT FK_Staff FOREIGN KEY (StaffID) REFERENCES Staff(StaffID) 
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE DetailSellTransaction (
  -- TransactionID CHAR(5) NOT NULL PRIMARY KEY,
  -- ItemID CHAR(5) NOT NULL PRIMARY KEY,
  TransactionID CHAR(5) REFERENCES HeaderSellTransaction ON UPDATE CASCADE ON DELETE CASCADE,
  ItemID CHAR(5) REFERENCES Item ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY(TransactionID, ItemID),
  SellQuantity INTEGER
);
