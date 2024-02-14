SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertBook] @book_title nvarchar(50), @author_firstname nvarchar(50),  @author_lastname nvarchar(50), @genre nvarchar(25), @book_description nvarchar(500) 
AS
IF NOT EXISTS
    (
    SELECT 1
    FROM [dbo].[Authors] 
    WHERE FirstName = @author_firstname AND LastName = @author_lastname
    )
INSERT INTO [dbo].[Authors]
           ([FirstName]
           ,[LastName])
     VALUES
           (@author_firstname
           ,@author_lastname)
IF NOT EXISTS
    (
    SELECT 1
    FROM [dbo].[Genres]
    WHERE Genre = @genre
    )
INSERT INTO [dbo].[Genres]
           ([Genre])
     VALUES
           (@genre)

DECLARE @variable_genreid AS int
SELECT  @variable_genreid = [GenreID]
FROM [dbo].[Genres]
WHERE Genre = @genre

DECLARE @variable_authorid AS int
SELECT  @variable_authorid = [AuthorID]
FROM [dbo].[Authors]
WHERE FirstName = @author_firstname AND LastName = @author_lastname

INSERT INTO [dbo].[Books]
           ([Title]
           ,[AuthorID]
           ,[BookGenreID]
           ,[BookDescription])
VALUES( @book_title, @variable_authorid, @variable_genreid,@book_description)