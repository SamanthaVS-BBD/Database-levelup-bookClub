SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CreateMeeting]
    @MeetingDate DATE,
    @BookID INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Meetings WHERE MeetingDate = @MeetingDate)
    BEGIN
        INSERT INTO Meetings (MeetingDate, BookID)
        VALUES (@MeetingDate, @BookID);
    END
    ELSE
    BEGIN
        RAISERROR('Meeting with the same date already exists.', 16, 1)
    END
END;
