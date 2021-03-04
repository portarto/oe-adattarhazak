-- az adatbázis elkészítése
CREATE DATABASE [MergedDB] COLLATE SQL_Latin1_General_CP1_CI_AS; 
GO

USE [MergedDB]
GO

-- készít egy Products táblát, ami a forráshoz hasonló típusokat használ
CREATE TABLE [dbo].[Products](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Color] [nvarchar](20) NULL,
	[Cost] [money] NOT NULL,
	[RetailPrice] [money] NOT NULL,
	[Size] [nvarchar](20) NULL
)
GO

-- készít egy Clothes táblát, ami azonos a Products táblával, de csak ruhák kerülnek bele
CREATE TABLE [dbo].[Clothes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Color] [nvarchar](20) NULL,
	[Cost] [money] NOT NULL,
	[RetailPrice] [money] NOT NULL,
	[Size] [nvarchar](20) NULL
)
GO