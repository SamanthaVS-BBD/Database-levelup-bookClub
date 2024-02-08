USE [BookClub];
GO

-- Foreign Keys

ALTER TABLE [dbo].[Meetings]
	DROP CONSTRAINT [FK_Meetings_book]
GO

ALTER TABLE [dbo].[Books]
	DROP CONSTRAINT [FK_Books_Genre]
GO

ALTER TABLE [dbo].[Books]
	DROP CONSTRAINT [FK_Books_Author]
GO

ALTER TABLE [dbo].[BookReviews]
	DROP CONSTRAINT [FK_BookReviews_Book]
GO

ALTER TABLE [dbo].[BookReviews]
	DROP CONSTRAINT [FK_BookReviews_Member]
GO

ALTER TABLE [dbo].[Attendance]
	DROP CONSTRAINT [FK_Attendance_Meeting]
GO

ALTER TABLE [dbo].[Attendance]
	DROP CONSTRAINT [FK_Attendance_Member]
GO