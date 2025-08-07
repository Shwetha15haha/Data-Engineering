/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
This script creates a new database named 'Datawarehouse' after checking if it already exists. 
Create schema for each type of data: Bronze,Silver,Gold in above database 
 */
USE master;

CREATE DATABASE Datawarehouse;

USE Datawarehouse;

GO CREATE SCHEMA bronze;

GO CREATE SCHEMA silver;

GO CREATE SCHEMA gold;

GO