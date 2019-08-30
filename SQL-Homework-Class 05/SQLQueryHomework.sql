USE SEDCHome
GO

/* 1.Create new procedure called CreateGrade:

-Procedure should create only Grade header info (not Grade Details);

-Procedure should return the total number of grades in the system for
 the Student on input (from the CreateGrade);

-Procedure should return second resultset with the MAX Grade of all grades
for the Student and Teacher on input (regardless the Course); */

CREATE PROCEDURE dbo.CreateGrade(@StudentId int, @CourseID smallint, @TeacherID smallint, @Grade tinyint, @Comment nvarchar(100), @CreatedDate date)
AS
BEGIN

	INSERT INTO dbo.Grade ([StudentId], [CourseId], [TeacherId], [Grade], [Comment], [CreatedDate])
	VALUES(@StudentID, @CourseID, @TeacherID, @Grade, @Comment, @CreatedDate)

	SELECT COUNT (*) AS TotalNumberOfGrades
	FROM dbo.[Grade]
	WHERE StudentID = @StudentID

	SELECT MAX(Grade) AS MaxGrade
	FROM dbo.[Grade]
	WHERE StudentID = @StudentID and TeacherID = @TeacherID

END
GO

EXEC dbo.CreateGrade
 @StudentId = 256, 
 @CourseId = 8, 
 @TeacherId = 18, 
 @Grade = 8, 
 @Comment='Vreden', 
 @CreatedDate ='2018-08-01' 

EXEC dbo.CreateGrade 
@StudentId = 110, 
@CourseId = 5, 
@TeacherId = 25, 
@Grade = 9, 
@Comment='Dobar', 
@CreatedDate ='2019-04-11' 

GO

/* 2.Create new procedure called CreateGradeDetail;

-Procedure should add details for specific Grade 
(new record for new AchievementTypeID, Points, MaxPoints, Date for specific Grade);

-Output from this procedure should be resultset with SUM of GradePoints calculated 
with formula AchievementPoints/AchievementMaxPoints*ParticipationRate for specific Grade; */

CREATE PROCEDURE dbo.CreateGradeDetail(@GradeId int, @AchievementTypeId tinyint, @AchievementPoints tinyint, 
@AchievementMaxPoints tinyint, @AchievementDate datetime)
AS
BEGIN
	
	IF @AchievementDate IS NULL
	BEGIN
		SET @AchievementDate = GETDATE()
	END

BEGIN TRY

	INSERT INTO dbo.GradeDetails ([GradeId],[AchievementTypeId],[AchievementPoints],[AchievementMaxPoints],[AchievementDate])
	VALUES (@GradeId, @AchievementTypeId, @AchievementPoints, @AchievementMaxPoints, @AchievementDate)

	SELECT SUM (gd.AchievementPoints / gd.AchievementMaxPoints * at.ParticipationRate) AS SumOfGradePoints
	FROM dbo.GradeDetails gd
	INNER JOIN dbo.AchievementType at on gd.AchievementTypeID = at.ID
	WHERE gd.GradeID = @GradeId

END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS ErrorNumber	  
	SELECT ERROR_LINE() AS ErrorLine  
	SELECT ERROR_MESSAGE() AS ErrorMessage; 
END CATCH

END
GO

EXEC dbo.CreateGradeDetail
@GradeId=10, 
@AchievementTypeId=1, 
@AchievementPoints=89, 
@AchievementMaxPoints=100,
@AchievementDate=null

GO

/* 3.Add error handling on CreateGradeDetail procedure

-Test the error handling by inserting not-existing values for AchievementTypeID */

EXEC CreateGradeDetail 
@GradeId = 10, 
@AchievementTypeId=100, 
@AchievementPoints=89, 
@AchievementMaxPoints=100, 
@AchievementDate=null
GO













