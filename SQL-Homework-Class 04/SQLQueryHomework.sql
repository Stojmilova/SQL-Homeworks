USE SEDCHOME
GO

--Declare scalar variable for storing FirstName values
--Assign value ‘Antonio’ to the FirstName variable
--Find all Students having FirstName same as the variable

DECLARE @FirstName NVARCHAR(100)
SET @FirstName = 'Antonio'

SELECT * FROM Student
WHERE FirstName = @FirstName
GO

--Declare table variable that will contain StudentId, StudentName and DateOfBirth
--Fill the table variable with all Female students

DECLARE @StudentList TABLE
(StudentId INT, StudentName NVARCHAR(100), DateOfBirth Date)

INSERT INTO @StudentList 
SELECT ID, FirstName, DateOfBirth  FROM dbo.[Student]
WHERE Gender ='F'

SELECT * FROM @StudentList
GO

--Declare temp table that will contain LastName and EnrolledDate columns
--Fill the temp table with all Male students having First Name starting with ‘A’
--Retrieve the students from the table which last name is with 7 characters

CREATE TABLE #StudentDetails
(LastName NVARCHAR (100), EnrolledDate Date)

INSERT INTO #StudentDetails
SELECT LastName, EnrolledDate FROM dbo.[Student]
WHERE GENDER = 'M' and FirstName like 'A%'    

SELECT * FROM #StudentDetails
WHERE LEN(LastName) = 7

--Find all teachers whose FirstName length is less than 5 and
--the first 3 characters of their FirstName and LastName are the same

SELECT FirstName, LastName  FROM dbo.[Teacher]
WHERE LEN (FirstName) < 5 and LEFT(FirstName, 3) = LEFT(LastName, 3)


--Declare scalar function (fn_FormatStudentName) for retrieving the Student description
 --for specific StudentId in the following format:
--StudentCardNumber without “sc-”
--“ – “
--First character of student FirstName
--“.”
--Student LastName

--CREATE SCALAR FUNCTION

CREATE FUNCTION fn_FormatStudentName(@StudentId INT)
RETURNS NVARCHAR (100)
AS

BEGIN
	DECLARE @RESULT NVARCHAR (100)

	SELECT @RESULT= RIGHT(StudentCardNumber,4,10) +  N'-' + RIGHT(FirstName,1) + '.' + LastName
	FROM dbo.Student 
	WHERE Id = @StudentId

	RETURN @RESULT 
END

--CALL FUNCTION
SELECT * ,dbo.fn_FormatStudentName(Id) AS FunctionOutput
FROM dbo.[Student]

--Create multi-statement table value function that for specific Teacher and Course will return list of students 
--(FirstName, LastName) who passed the exam, together with Grade and CreatedDate


--CREATE MULTI-STATEMENT FUNCTION

CREATE FUNCTION dbo.fn_StudentInfo_MultiStatement(@TeacherId int, @CourseId int)
RETURNS @Output TABLE (FirstName NVARCHAR(100), LastName NVARCHAR(100), Grade INT, CreatedDate date)
AS 
BEGIN

	INSERT INTO @Output
	SELECT s.FirstName, s.LastName, g.Grade, g.CreatedDate
	FROM dbo.Grade g
	INNER JOIN dbo.Student s on s.ID = g.StudentID
	WHERE @TeacherId = g.TeacherID AND @CourseId = g.CourseID 

	RETURN 	
END
GO

--CALL FUNCTION
SELECT * FROM dbo.fn_StudentInfo_MultiStatement(7,8)


