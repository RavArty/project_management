--DROP DATABASE IF EXISTS ProjectManagement;

IF NOT EXISTS
(
SELECT name FROM master.dbo.sysdatabases
WHERE name = 'ProjectManagement'
)
CREATE DATABASE ProjectManagement;
--GO
USE ProjectManagement

-----------------------------------------
--Drop all foreign keys if exists
-----------------------------------------
IF EXISTS (SELECT name FROM sys.tables
WHERE name = 'next_release')
	ALTER TABLE next_release DROP CONSTRAINT IF EXISTS fk_nr_project_id;

IF EXISTS (SELECT name FROM sys.tables
WHERE name = 'ticket')
BEGIN
	ALTER TABLE ticket DROP CONSTRAINT IF EXISTS fk_tickets_type_id;
	ALTER TABLE ticket DROP CONSTRAINT IF EXISTS fk_tickets_release_id;
END

IF EXISTS (SELECT name FROM sys.tables
WHERE name = 'assigned')
BEGIN
	ALTER TABLE assigned DROP CONSTRAINT IF EXISTS fk_assign_user_id;
	ALTER TABLE assigned DROP CONSTRAINT IF EXISTS fk_assign_ticket_id;
END

IF EXISTS (SELECT name FROM sys.tables
WHERE name = 'team')
	ALTER TABLE team DROP CONSTRAINT IF EXISTS fk_team_user_id;

IF EXISTS (SELECT name FROM sys.tables
WHERE name = 'project_manager')
BEGIN
	ALTER TABLE project_manager DROP CONSTRAINT IF EXISTS fk_pm_user_id;
	ALTER TABLE project_manager DROP CONSTRAINT IF EXISTS fk_pm_project_id;
END

IF EXISTS (SELECT name FROM sys.tables
WHERE name = 'client_project')
BEGIN
	ALTER TABLE client_project DROP CONSTRAINT IF EXISTS fk_cp_client_id;
	ALTER TABLE client_project DROP CONSTRAINT IF EXISTS fk_cp_project_id
END
-----------------------------------------
--Table to keep all users
-----------------------------------------
DROP TABLE IF EXISTS users;

/*IF NOT EXISTS (
SELECT name FROM sys.tables
WHERE name = 'users' )*/

CREATE TABLE users(
	id INT IDENTITY(1,1) NOT NULL,
	first_name VARCHAR(64) NOT NULL,
	last_name VARCHAR(64) NOT NULL,
	username VARCHAR(64) NOT NULL,
	password VARCHAR(64) NOT NULL,
	project_manager BIT NULL DEFAULT 0,
);

-----------------------------------------
--In case the whole team will be assigned for certain ticket
-----------------------------------------
DROP TABLE IF EXISTS team;

/*IF NOT EXISTS (
SELECT name FROM sys.tables
WHERE name = 'team' )*/

CREATE TABLE team(
	id INT IDENTITY(1,1) NOT NULL,
	user_id int,
	role VARCHAR(128)
);
-----------------------------------------
--Users who can assigned to projects
-----------------------------------------
DROP TABLE IF EXISTS project_manager;

/*IF NOT EXISTS (
SELECT name FROM sys.tables
WHERE name = 'project_manager' )*/

CREATE TABLE project_manager(
	id INT IDENTITY(1,1) NOT NULL,
	project_id INT,
	user_id INT
);
-----------------------------------------
--Users who can assigned to projects
-----------------------------------------
DROP TABLE IF EXISTS projects;

/*IF NOT EXISTS (
SELECT name FROM sys.tables
WHERE name = 'projects' )*/

CREATE TABLE projects(
	id INT IDENTITY(1,1) NOT NULL,
	project_name VARCHAR(128),
	start_date DATE,
	end_date DATE,
	descr VARCHAR(1000)
);
-----------------------------------------
--Relates clients with projects
-----------------------------------------
DROP TABLE IF EXISTS client_project;

/*IF NOT EXISTS (
SELECT name FROM sys.tables
WHERE name = 'client_project' )*/

CREATE TABLE client_project(
	id INT IDENTITY(1,1) NOT NULL,
	project_id INT,
	client_id INT,
	descr VARCHAR(1000)
);
-----------------------------------------
--Clients/Partners
-----------------------------------------
DROP TABLE IF EXISTS client;

/*IF NOT EXISTS (
SELECT name FROM sys.tables
WHERE name = 'client' )*/

CREATE TABLE client(
	id INT IDENTITY(1,1) NOT NULL,
	client_name VARCHAR(256),
	descr VARCHAR(1000)
);
-----------------------------------------
--Next Release
-----------------------------------------
DROP TABLE IF EXISTS next_release;

/*IF NOT EXISTS (
SELECT name FROM sys.tables
WHERE name = 'next_release' )*/

CREATE TABLE next_release(
	id INT IDENTITY(1,1) NOT NULL,
	release_name VARCHAR(256),
	project_id INT,
	start_date DATE,
	end_date DATE,
	descr VARCHAR(1000)
);
-----------------------------------------
--Ticket
-----------------------------------------
DROP TABLE IF EXISTS ticket;

/*IF NOT EXISTS (
SELECT name FROM sys.tables
WHERE name = 'ticket' )*/

CREATE TABLE ticket(
	id INT IDENTITY(1,1) NOT NULL,
	ticket_name VARCHAR(256),
	release_id INT,
	ticket_type INT,
	start_date DATE,
	end_date DATE,
	descr VARCHAR(1000)
);
-----------------------------------------
--Ticket Type
-----------------------------------------
DROP TABLE IF EXISTS ticket_type;

/*IF NOT EXISTS (
SELECT name FROM sys.tables
WHERE name = 'ticket_type' )*/

CREATE TABLE ticket_type(
	id INT IDENTITY(1,1) NOT NULL,
	type VARCHAR(64),
);
-----------------------------------------
--Assigned tickets. Relates users with tickets
-----------------------------------------
DROP TABLE IF EXISTS assigned;

/*IF NOT EXISTS (
SELECT name FROM sys.tables
WHERE name = 'assigned' )*/

CREATE TABLE assigned(
	id INT IDENTITY(1,1) NOT NULL,
	ticket_id INT,
	user_id INT
);
-----------------------------------------
--Assigne primary keys
-----------------------------------------
ALTER TABLE projects
ADD CONSTRAINT pk_project_id PRIMARY KEY (id);

ALTER TABLE client_project
ADD CONSTRAINT pk_client_project_id PRIMARY KEY (id);

ALTER TABLE client
ADD CONSTRAINT pk_client_id PRIMARY KEY (id);

ALTER TABLE project_manager
ADD CONSTRAINT pk_projectmanagerid PRIMARY KEY (id);

ALTER TABLE users
ADD CONSTRAINT pk_users_id PRIMARY KEY (id);

ALTER TABLE team
ADD CONSTRAINT pk_team_id PRIMARY KEY (id);

ALTER TABLE assigned
ADD CONSTRAINT pk_assign_id PRIMARY KEY (id);

ALTER TABLE ticket
ADD CONSTRAINT pk_tickets_id PRIMARY KEY (id);

ALTER TABLE next_release
ADD CONSTRAINT pk_nextrelease_id PRIMARY KEY (id);

ALTER TABLE ticket_type
ADD CONSTRAINT pk_ticket_type_id PRIMARY KEY (id);

-----------------------------------------
--Assigne foreign keys
-----------------------------------------
ALTER TABLE client_project
ADD CONSTRAINT fk_cp_project_id FOREIGN KEY (project_id) REFERENCES projects (id);

ALTER TABLE client_project
ADD CONSTRAINT fk_cp_client_id FOREIGN KEY (client_id) REFERENCES client (id);

ALTER TABLE project_manager
ADD CONSTRAINT fk_pm_project_id FOREIGN KEY (project_id) REFERENCES projects (id);

ALTER TABLE project_manager
ADD CONSTRAINT fk_pm_user_id FOREIGN KEY (user_id) REFERENCES users (id);

ALTER TABLE team
ADD CONSTRAINT fk_team_user_id FOREIGN KEY (user_id) REFERENCES users (id);

ALTER TABLE assigned
ADD CONSTRAINT fk_assign_ticket_id FOREIGN KEY (ticket_id) REFERENCES ticket (id);

ALTER TABLE assigned
ADD CONSTRAINT fk_assign_user_id FOREIGN KEY (user_id) REFERENCES users (id);

ALTER TABLE ticket
ADD CONSTRAINT fk_tickets_release_id FOREIGN KEY (release_id) REFERENCES next_release (id);

ALTER TABLE ticket
ADD CONSTRAINT fk_tickets_type_id FOREIGN KEY (ticket_type) REFERENCES ticket_type (id);

ALTER TABLE next_release
ADD CONSTRAINT fk_nr_project_id FOREIGN KEY (project_id) REFERENCES projects (id);


-----------------------------------------
--Stored procedure. New Project
-----------------------------------------
DROP PROCEDURE IF EXISTS new_project
GO
CREATE PROCEDURE new_project
@project_name VARCHAR(128),
@start_date DATE,
@end_date DATE,
@descr VARCHAR(1000)
AS
BEGIN
	INSERT INTO projects (project_name, start_date, end_date, descr)
	VALUES (@project_name, @start_date, @end_date, @descr);
END