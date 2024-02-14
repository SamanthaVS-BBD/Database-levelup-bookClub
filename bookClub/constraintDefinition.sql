USE BookClub
GO

-- Foreign Keys

ALTER TABLE [dbo].[Meetings]
    ADD CONSTRAINT [FK_Meetings_Book] FOREIGN KEY ([BookID]) REFERENCES [dbo].[Books] ([BookID]);
GO

ALTER TABLE [dbo].[Books]
    ADD CONSTRAINT [FK_Books_Genre] FOREIGN KEY ([BookGenreID]) REFERENCES [dbo].[Genres] ([GenreID]);
GO

ALTER TABLE [dbo].[Books]
    ADD CONSTRAINT [FK_Books_Author] FOREIGN KEY ([AuthorID]) REFERENCES [dbo].[Authors] ([AuthorID]);
GO

ALTER TABLE [dbo].[BookReviews]
    ADD CONSTRAINT [FK_BookReviews_Book] FOREIGN KEY ([BookID]) REFERENCES [dbo].[Books] ([BookID]);
GO

ALTER TABLE [dbo].[BookReviews]
    ADD CONSTRAINT [FK_BookReviews_Member] FOREIGN KEY ([MemberID]) REFERENCES [dbo].[Members] ([MemberID]);
GO

ALTER TABLE [dbo].[Attendance]
    ADD CONSTRAINT [FK_Attendance_Meeting] FOREIGN KEY ([MeetingID]) REFERENCES [dbo].[Meetings] ([MeetingID]);
GO

ALTER TABLE [dbo].[Attendance]
    ADD CONSTRAINT [FK_Attendance_Member] FOREIGN KEY ([MemberID]) REFERENCES [dbo].[Members] ([MemberID]);
GO

--Date constraint 
ALTER TABLE [dbo].[Meetings] WITH NOCHECK ADD CONSTRAINT date_check CHECK ([MeetingDate] >= CAST(GETDATE() AS DATE));
GO

