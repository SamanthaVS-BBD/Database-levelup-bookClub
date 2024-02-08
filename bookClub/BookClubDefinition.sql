USE master;
IF EXISTS(select * from sys.databases where name='BookClub')
DROP DATABASE BookClub
GO

CREATE DATABASE BookClub

GO

USE BookClub;

GO

CREATE TABLE Members (
	MemberID [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	FirstName [varchar] (25) NOT NULL,
	LastName [varchar] (25) NOT NULL,
	Email [varchar](100) UNIQUE,
	PhoneNumber [varchar](15) UNIQUE,
	
);

GO

CREATE TABLE Meetings(
	MeetingID [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	MeetingDate [date] NOT NULL,
	BookID [int] NOT NULL,

);

GO

CREATE TABLE Attendance (
	AttendanceID [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	MeetingID [int] NOT NULL,
	MemberID [int] NOT NULL
);

GO 

CREATE TABLE Books(
	BookID [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Title [varchar](50) NOT NULL,
	AuthorID [int] NOT NULL,
	BookGenreID [int] NOT NULL,
	BookDescription [varchar](500) NOT NULL
);

GO

CREATE TABLE GENRES(
	GenreID [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Genre [varchar](25) NOT NULL 
);

GO

CREATE TABLE Authors(
	AuthorID [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	FirstName [varchar](50) NOT NULL,
	LastName [varchar](50) NOT NULL
);

GO

CREATE TABLE BookReviews(
	BookReviewID [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	BookID [int] NOT NULL,
	Rating [int] CHECK (Rating >= 1 AND Rating <= 5), 
	MemberID [int] NOT NULL,
	Comment [text] NOT NULL
);

GO