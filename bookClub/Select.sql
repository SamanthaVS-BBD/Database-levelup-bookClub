USE BookClub;

GO

SELECT * FROM dbo.Members;

SELECT * FROM dbo.Genres;

SELECT * FROM dbo.Authors;

SELECT * FROM dbo.Books;

SELECT * FROM dbo.BookReviews;

SELECT * FROM dbo.Meetings;

SELECT * FROM dbo.Attendance;

SELECT dbo.CalculateAverageRating(1) AS AverageRatingForBook1;

SELECT * FROM MonthlySummary;

SELECT * FROM dbo.GetMemberAttendanceRanking(2023);
