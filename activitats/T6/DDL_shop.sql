/************************
******* Marc Sans *******
************************/

CREATE DATABASE shop;
USE shop;

CREATE TABLE categories(
    code INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE products(
    code INT PRIMARY KEY,
    name VARCHAR(50),
    description VARCHAR(255),
    pice DECIMAL,
    category VARCHAR(59),

    ADD CONSTRAINT FK_category FOREIGN KEY (code) REFERENCES categories (code)
);

CREATE TABLE clients(
    code INT PRIMARY KEY,
    name VARCHAR(50),
    surnames VARCHAR(50),
    DNI VARCHAR(9),
    phone int,
    mail VARCHAR(50),
    address VARCHAR(50),
    city VARCHAR(50),
    pCode VARCHAR(20),
    country VARCHAR(15)
);

CREATE TABLE sales(
    code INT PRIMARY KEY,
    client VARCHAR(50),
    entry_date date,
    served_date date,
    product VARCHAR(50),
    quatitat INT
)
