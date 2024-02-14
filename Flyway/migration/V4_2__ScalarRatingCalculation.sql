CREATE FUNCTION dbo.CalculateAverageRating (@BookID INT)
RETURNS DECIMAL(3,2)
AS
BEGIN
    DECLARE @AverageRating DECIMAL(3,2);

    SELECT @AverageRating = AVG(CAST(Rating AS DECIMAL(3,2)))
    FROM BookReviews
    WHERE BookID = @BookID;

    RETURN ISNULL(@AverageRating, 0);
END;
