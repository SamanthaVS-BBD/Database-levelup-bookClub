SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertBookReview]
    @bookID INT,
    @rating INT,
    @memberID INT,
    @comment text
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @error AS BIT; 
	SET @error='false';

    IF NOT EXISTS (SELECT 1 FROM Books WHERE BookID = @bookID)
    BEGIN
        SET @error='true';
        RAISERROR('This BookID does not exist in the Books table.', 16, 1);

    END
    IF NOT EXISTS (SELECT 1 FROM Members WHERE MemberID = @memberID)
    BEGIN
        SET @error='true';
        RAISERROR('This MemberID does not exist in the Members table', 16, 1);
    END

	IF (@rating NOT BETWEEN 1 AND 5)
	BEGIN
		SET @error='true';
        RAISERROR('The rating should be between 1 and 5', 16, 1);
    END

	IF EXISTS (SELECT 1 FROM BookReviews WHERE MemberID = @memberID AND BookID = @bookID)
    BEGIN
        RAISERROR('This member has already reviewed this book', 16, 1);
		RETURN;
    END
	ELSE IF (@error = 'true')
	BEGIN
		RETURN;
    END
      
    BEGIN
        INSERT INTO BookReviews (BookID,Rating,MemberID,Comment)
        VALUES (@bookID, @rating, @memberID, @comment);
    END
END;