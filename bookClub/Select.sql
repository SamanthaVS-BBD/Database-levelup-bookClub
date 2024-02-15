USE BookClub;
GO

SELECT * FROM dbo.Members;

SELECT * FROM dbo.Genres;

SELECT * FROM dbo.Authors;

SELECT * FROM dbo.Books;

SELECT * FROM dbo.BookReviews;

SELECT * FROM dbo.Meetings;

SELECT * FROM dbo.Attendance;



--scalar
SELECT dbo.CalculateAverageRating(1) AS AverageRatingForBook1;

--view
SELECT * FROM MonthlySummary;

--table value
SELECT * FROM dbo.GetMemberAttendanceRanking(2023);


EXECUTE [dbo].[usp_InsertBook] @book_title = 'Twilight', @author_firstname = 'Stephenie',
                               @author_lastname = 'Meyer', @genre = 'Romance',
                               @book_description = 'About three things I was absolutely positive. First, Edward was a vampire. Second, there was a part of him - and I didn''t know how dominant that part might be - that thirsted for my blood.And third, I was unconditionally and irrevocably in love with him.';
GO

EXECUTE [dbo].[usp_CreateMeeting]
    @MeetingDate = '2024-02-25',
    @BookID = 12
GO

EXECUTE [dbo].[usp_InsertBookReview]
    @bookID = 12,
    @rating = 3,
    @memberID = 1,
    @comment = 'Was Okay read better books in my life'
GO


--table value
SELECT * FROM dbo.GetBookReviews(1);



--proc
EXECUTE [dbo].[usp_InsertBook] @book_title = 'Twilight', @author_firstname = 'Stephenie',
                               @author_lastname = 'Meyer', @genre = 'Romance',
                               @book_description = 'About three things I was absolutely positive. First, Edward was a vampire. Second, there was a part of him - and I didn''t know how dominant that part might be - that thirsted for my blood.And third, I was unconditionally and irrevocably in love with him.';
GO

EXECUTE [dbo].[usp_CreateMeeting] @MeetingDate = '2024-03-16', @BookID = 1;
GO

EXECUTE [dbo].[usp_InsertBookReview] @bookID = 3, @rating = 3, @memberID = 1, @comment = "Very much average, was so bored";
GO