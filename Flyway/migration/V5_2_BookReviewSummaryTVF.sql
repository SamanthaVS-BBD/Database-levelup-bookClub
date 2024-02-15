CREATE FUNCTION dbo.GetBookReviews(@BookID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
		BookReviews.MemberID,
        BookReviews.Rating,
        BookReviews.Comment
    FROM 
        BookReviews
    WHERE 
        BookReviews.BookID = @BookID
);
