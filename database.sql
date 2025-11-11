-- Create database
CREATE DATABASE IF NOT EXISTS pttk_final;
USE pttk_final;

-- tblMember
CREATE TABLE tblMember (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    dateOfBirth DATE,
    address VARCHAR(255) NOT NULL,
    phoneNumber VARCHAR(255) NOT NULL,
    email VARCHAR(255)
);

-- tblEmployee
CREATE TABLE tblEmployee (
    tblMemberid INT PRIMARY KEY,
    position VARCHAR(255) NOT NULL,
    FOREIGN KEY (tblMemberid) REFERENCES tblMember(id)
);

-- tblCustomer
CREATE TABLE tblCustomer (
    tblMemberid INT PRIMARY KEY,
    customerId INT NOT NULL, -- This seems redundant if tblMemberid is the PK
    FOREIGN KEY (tblMemberid) REFERENCES tblMember(id)
);

-- tblSupplier
CREATE TABLE tblSupplier (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phoneNumber VARCHAR(255) NOT NULL,
    email VARCHAR(255)
);

-- tblProduct
CREATE TABLE tblProduct (
    id INT PRIMARY KEY AUTO_INCREMENT,
    unitPrice FLOAT NOT NULL,
    name VARCHAR(255) NOT NULL,
    brand VARCHAR(255),
    category VARCHAR(255),
    unit VARCHAR(255) NOT NULL
);

-- tblPurchaseInvoice
CREATE TABLE tblPurchaseInvoice (
    id INT PRIMARY KEY AUTO_INCREMENT,
    paymentDate DATE NOT NULL,
    paymentType VARCHAR(255) NOT NULL,
    tblSupplierid INT NOT NULL,
    tblEmployeetblMemberid INT NOT NULL,
    FOREIGN KEY (tblSupplierid) REFERENCES tblSupplier(id),
    FOREIGN KEY (tblEmployeetblMemberid) REFERENCES tblEmployee(tblMemberid)
);

-- tblPurchaseDetail
CREATE TABLE tblPurchaseDetail (
    id INT PRIMARY KEY AUTO_INCREMENT,
    quantity INT NOT NULL,
    unitPrice FLOAT NOT NULL,
    tblPurchaseInvoiceid INT NOT NULL,
    tblProductid INT NOT NULL,
    FOREIGN KEY (tblPurchaseInvoiceid) REFERENCES tblPurchaseInvoice(id),
    FOREIGN KEY (tblProductid) REFERENCES tblProduct(id)
);

-- tblSalesInvoice
CREATE TABLE tblSalesInvoice (
    id INT PRIMARY KEY AUTO_INCREMENT,
    paymentDate DATE NOT NULL,
    paymentType VARCHAR(255) NOT NULL,
    status VARCHAR(255) NOT NULL,
    tblCustomertblMemberid INT NOT NULL,
    tblEmployeetblMemberid INT NOT NULL, -- Assuming a seller is an employee
    -- tblShippertblEmployeetblMemberid INT NOT NULL, -- Assuming a shipper is an employee
    FOREIGN KEY (tblCustomertblMemberid) REFERENCES tblCustomer(tblMemberid),
    FOREIGN KEY (tblEmployeetblMemberid) REFERENCES tblEmployee(tblMemberid)
    -- FOREIGN KEY (tblShippertblEmployeetblMemberid) REFERENCES tblEmployee(tblMemberid)
);

-- tblSalesDetail
CREATE TABLE tblSalesDetail (
    id INT PRIMARY KEY AUTO_INCREMENT,
    quantity INT NOT NULL,
    tblSalesInvoiceid INT NOT NULL,
    tblProductid INT NOT NULL,
    FOREIGN KEY (tblSalesInvoiceid) REFERENCES tblSalesInvoice(id),
    FOREIGN KEY (tblProductid) REFERENCES tblProduct(id)
);
