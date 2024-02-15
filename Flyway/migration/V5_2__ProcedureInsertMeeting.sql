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
        IF NOT EXISTS (SELECT 1 FROM Meetings WHERE BookID = @BookID)
        BEGIN
            IF EXISTS (SELECT 1 FROM Books WHERE BookID = @BookID)
            BEGIN
                INSERT INTO Meetings (MeetingDate, BookID)
                VALUES (@MeetingDate, @BookID);
            END
            ELSE
            BEGIN
                RAISERROR('Book not found in database. Please add the book first.', 16, 1)
            END
        END
        ELSE
        BEGIN
            RAISERROR('Meeting with the same book already exists.', 16, 1)
        END
    END
    ELSE
    BEGIN
        RAISERROR('Meeting with the same date already exists.', 16, 1)
    END
END;
