USE master;
IF EXISTS(select * from sys.databases where name='BookClub')
DROP DATABASE BookClub
GO

CREATE DATABASE BookClub

GO