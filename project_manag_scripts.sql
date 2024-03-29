USE [master]
GO
/****** Object:  Database [ProjectManagement]    Script Date: 9/3/2019 9:23:19 PM ******/
CREATE DATABASE [ProjectManagement]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ProjectManagement', FILENAME = N'C:\DB\ProjectManagement.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ProjectManagement_log', FILENAME = N'C:\DB\ProjectManagement_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ProjectManagement] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ProjectManagement].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ProjectManagement] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ProjectManagement] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ProjectManagement] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ProjectManagement] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ProjectManagement] SET ARITHABORT OFF 
GO
ALTER DATABASE [ProjectManagement] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ProjectManagement] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ProjectManagement] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ProjectManagement] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ProjectManagement] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ProjectManagement] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ProjectManagement] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ProjectManagement] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ProjectManagement] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ProjectManagement] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ProjectManagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ProjectManagement] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ProjectManagement] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ProjectManagement] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ProjectManagement] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ProjectManagement] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ProjectManagement] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ProjectManagement] SET RECOVERY FULL 
GO
ALTER DATABASE [ProjectManagement] SET  MULTI_USER 
GO
ALTER DATABASE [ProjectManagement] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ProjectManagement] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ProjectManagement] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ProjectManagement] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ProjectManagement] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ProjectManagement', N'ON'
GO
ALTER DATABASE [ProjectManagement] SET QUERY_STORE = OFF
GO
USE [ProjectManagement]
GO
/****** Object:  Table [dbo].[assigned]    Script Date: 9/3/2019 9:23:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[assigned](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ticket_id] [int] NULL,
	[user_id] [int] NULL,
 CONSTRAINT [pk_assign_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[client]    Script Date: 9/3/2019 9:23:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[client](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[client_name] [varchar](256) NULL,
	[descr] [varchar](1000) NULL,
 CONSTRAINT [pk_client_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[client_project]    Script Date: 9/3/2019 9:23:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[client_project](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[project_id] [int] NULL,
	[client_id] [int] NULL,
	[descr] [varchar](1000) NULL,
 CONSTRAINT [pk_client_project_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[next_release]    Script Date: 9/3/2019 9:23:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[next_release](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[release_name] [varchar](256) NULL,
	[project_id] [int] NULL,
	[priority] [int] NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
	[descr] [varchar](1000) NULL,
 CONSTRAINT [pk_nextrelease_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[project_manager]    Script Date: 9/3/2019 9:23:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[project_manager](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[project_id] [int] NULL,
	[user_id] [int] NULL,
 CONSTRAINT [pk_projectmanagerid] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[projects]    Script Date: 9/3/2019 9:23:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[projects](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[project_name] [varchar](128) NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
	[descr] [varchar](1000) NULL,
 CONSTRAINT [pk_project_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[states]    Script Date: 9/3/2019 9:23:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[states](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[type] [varchar](64) NULL,
 CONSTRAINT [pk_states_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[status]    Script Date: 9/3/2019 9:23:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[status](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[type] [varchar](64) NULL,
 CONSTRAINT [pk_status_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[team]    Script Date: 9/3/2019 9:23:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[team](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[role] [varchar](128) NULL,
 CONSTRAINT [pk_team_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ticket]    Script Date: 9/3/2019 9:23:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ticket](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ticket_name] [varchar](256) NULL,
	[release_id] [int] NULL,
	[ticket_type] [int] NULL,
	[status_id] [int] NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
	[descr] [varchar](1000) NULL,
 CONSTRAINT [pk_tickets_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ticket_type]    Script Date: 9/3/2019 9:23:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ticket_type](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[type] [varchar](64) NULL,
 CONSTRAINT [pk_ticket_type_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 9/3/2019 9:23:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [varchar](64) NOT NULL,
	[last_name] [varchar](64) NOT NULL,
	[username] [varchar](64) NOT NULL,
	[password] [varchar](64) NOT NULL,
	[project_manager] [bit] NULL,
 CONSTRAINT [pk_users_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((0)) FOR [project_manager]
GO
ALTER TABLE [dbo].[assigned]  WITH CHECK ADD  CONSTRAINT [fk_assign_ticket_id] FOREIGN KEY([ticket_id])
REFERENCES [dbo].[ticket] ([id])
GO
ALTER TABLE [dbo].[assigned] CHECK CONSTRAINT [fk_assign_ticket_id]
GO
ALTER TABLE [dbo].[assigned]  WITH CHECK ADD  CONSTRAINT [fk_assign_user_id] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[assigned] CHECK CONSTRAINT [fk_assign_user_id]
GO
ALTER TABLE [dbo].[client_project]  WITH CHECK ADD  CONSTRAINT [fk_cp_client_id] FOREIGN KEY([client_id])
REFERENCES [dbo].[client] ([id])
GO
ALTER TABLE [dbo].[client_project] CHECK CONSTRAINT [fk_cp_client_id]
GO
ALTER TABLE [dbo].[client_project]  WITH CHECK ADD  CONSTRAINT [fk_cp_project_id] FOREIGN KEY([project_id])
REFERENCES [dbo].[projects] ([id])
GO
ALTER TABLE [dbo].[client_project] CHECK CONSTRAINT [fk_cp_project_id]
GO
ALTER TABLE [dbo].[next_release]  WITH CHECK ADD  CONSTRAINT [fk_nr_project_id] FOREIGN KEY([project_id])
REFERENCES [dbo].[projects] ([id])
GO
ALTER TABLE [dbo].[next_release] CHECK CONSTRAINT [fk_nr_project_id]
GO
ALTER TABLE [dbo].[project_manager]  WITH CHECK ADD  CONSTRAINT [fk_pm_project_id] FOREIGN KEY([project_id])
REFERENCES [dbo].[projects] ([id])
GO
ALTER TABLE [dbo].[project_manager] CHECK CONSTRAINT [fk_pm_project_id]
GO
ALTER TABLE [dbo].[project_manager]  WITH CHECK ADD  CONSTRAINT [fk_pm_user_id] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[project_manager] CHECK CONSTRAINT [fk_pm_user_id]
GO
ALTER TABLE [dbo].[team]  WITH CHECK ADD  CONSTRAINT [fk_team_user_id] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[team] CHECK CONSTRAINT [fk_team_user_id]
GO
ALTER TABLE [dbo].[ticket]  WITH CHECK ADD  CONSTRAINT [fk_tickets_release_id] FOREIGN KEY([release_id])
REFERENCES [dbo].[next_release] ([id])
GO
ALTER TABLE [dbo].[ticket] CHECK CONSTRAINT [fk_tickets_release_id]
GO
ALTER TABLE [dbo].[ticket]  WITH CHECK ADD  CONSTRAINT [fk_tickets_status_id] FOREIGN KEY([ticket_type])
REFERENCES [dbo].[status] ([id])
GO
ALTER TABLE [dbo].[ticket] CHECK CONSTRAINT [fk_tickets_status_id]
GO
ALTER TABLE [dbo].[ticket]  WITH CHECK ADD  CONSTRAINT [fk_tickets_type_id] FOREIGN KEY([ticket_type])
REFERENCES [dbo].[ticket_type] ([id])
GO
ALTER TABLE [dbo].[ticket] CHECK CONSTRAINT [fk_tickets_type_id]
GO
/****** Object:  StoredProcedure [dbo].[new_project]    Script Date: 9/3/2019 9:23:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[new_project]
@project_name VARCHAR(128),
@start_date VARCHAR,
@end_date VARCHAR,
@descr VARCHAR(1000)
AS
BEGIN
	INSERT INTO projects (project_name, start_date, end_date, descr)
	VALUES (@project_name, @start_date, @end_date, @descr);
END
-----------------------------------------
--Insert values
-----------------------------------------
--EXEC new_project 'project1', '2019-07-19', '2019-19-20', 'new super project';
--EXEC new_project 'project2', '2019-08-29', '2019-11-29', 'project two';
--EXEC new_project 'project3', '2019-09-01', '2020-11-29', 'project three';
INSERT INTO projects (project_name, start_date, end_date, descr)
VALUES ('project1', '2019-07-19', '2019-07-20', 'description for project1')

GO
USE [master]
GO
ALTER DATABASE [ProjectManagement] SET  READ_WRITE 
GO
