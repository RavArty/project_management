IF NOT EXISTS
(
SELECT name FROM master.dbo.sysdatabases
WHERE name = 'ProjectManagement'
)
CREATE DATABASE ProjectManagement

USE ProjectManagement

-----------------------------------------
IF NOT EXISTS (
SELECT name FROM sys.tables
WHERE name = 'users' )
CREATE TABLE users(
	id INT IDENTITY(1,1) PRIMARY KEY,
	first_name VARCHAR(64) NOT NULL,
	last_name VARCHAR(64) NOT NULL,
	username VARCHAR(64) NOT NULL,
	password VARCHAR(64) NOT NULL,
	project_manager BIT NULL DEFAULT 0,
);

-----------------------------------------
CREATE TABLE project_manager(
	id INT IDENTITY(1,1) PRIMARY KEY,
	project_id INT,
	user_id INT
);