USE BookClub;
GO

-- Check if MonthlySummary view exists
IF OBJECT_ID('MonthlySummary', 'V') IS NOT NULL
BEGIN
    -- Rename the existing MonthlySummary view to a temporary name
    EXEC sp_rename 'MonthlySummary', 'MonthlySummary_temp';
END
GO

-- Recreate the MonthlySummary view with the corrected logic
CREATE VIEW MonthlySummary AS
SELECT 
    YEAR(MeetingDate) AS Year,
    DATENAME(MONTH, MeetingDate) AS MonthName,
    COUNT(DISTINCT Meetings.MeetingID) AS TotalMeetings,
    COUNT(Attendance.MemberID) AS TotalAttendees
FROM 
    Meetings
LEFT JOIN 
    Attendance ON Meetings.MeetingID = Attendance.MeetingID
GROUP BY 
    YEAR(MeetingDate), MONTH(MeetingDate), DATENAME(MONTH, MeetingDate);
GO

-- Optionally, drop the temporary view if it was renamed
IF OBJECT_ID('MonthlySummary_temp', 'V') IS NOT NULL
BEGIN
    DROP VIEW MonthlySummary_temp;
END
GO
