-- How to use the CREATE DATABASE statement:

-- Syntax:

CREATE DATABASE [IF NOT EXISTS] db_name

-- Attempt to create a database named AP:

CREATE DATABASE ap

-- Create a database named AP only if it doesn’t exist:

CREATE DATABASE IF NOT EXISTS ap

-- How to use the DROP DATABASE statement
Syntax

DROP DATABASE [IF EXISTS] db_name

-- Attempt to drop a database named AP:

DROP DATABASE ap

-- Drop a database named AP only if it exists:

DROP DATABASE IF EXISTS ap
 
-- How to use the USE statement:

Syntax

USE db_name

-- Select a database named AP:

USE ap
 
-- The syntax of the CREATE TABLE statement:

CREATE TABLE [db_name.]table_name
(
     column_name_1 data_type [column_attributes]
     [, column_name_2 data_type [column_attributes]]...
     [, table_level_constraints]
)

-- Common column attributes:

NOT NULL
UNIQUE
DEFAULT default_value
AUTO_INCREMENT
  
-- A statement that creates a table without column attributes:

CREATE TABLE vendors
   (
     vendor_id     INT,
     vendor_name   VARCHAR(50)
   ) 
   
-- A statement that creates a table with column attributes:

CREATE TABLE vendors
   (
     vendor_id   INT
        NOT NULL UNIQUE AUTO_INCREMENT,
     vendor_name VARCHAR(50)
        NOT NULL    UNIQUE
)

-- Another statement that creates a table with column attributes:

 CREATE TABLE invoices
(
  invoice_id       INT              NOT NULL  UNIQUE,
  vendor_id        INT              NOT NULL,
  invoice_number   VARCHAR(50)      NOT NULL,
  invoice_date     DATE,
  invoice_total    DECIMAL(9,2)     NOT NULL,
  payment_total    DECIMAL(9,2)     DEFAULT 0

