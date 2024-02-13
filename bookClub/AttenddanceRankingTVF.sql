USE BookClub;
GO

-- Create a table-valued function to rank members by meeting attendance for a given year
CREATE FUNCTION dbo.GetMemberAttendanceRanking (@Year INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        M.MemberID,
        M.FirstName,
        M.LastName,
        COUNT(A.MeetingID) AS MeetingsAttended,
        RANK() OVER (ORDER BY COUNT(A.MeetingID) DESC) AS AttendanceRank
    FROM 
        Members M
    INNER JOIN 
        Attendance A ON M.MemberID = A.MemberID
    INNER JOIN 
        Meetings Mng ON A.MeetingID = Mng.MeetingID
    WHERE 
        YEAR(Mng.MeetingDate) = @Year
    GROUP BY 
        M.MemberID, M.FirstName, M.LastName
);
GO
