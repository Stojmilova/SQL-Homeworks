USE SEDCHome
GO

--1.Calculate the count of all grades in the system
SELECT COUNT(*) as TotalGrades
FROM dbo.Grade
GO

--2.Calculate the count of all grades per Teacher in the system
SELECT t.FirstName, t.LastName, COUNT (*) as TotalGrades
FROM dbo.[Grade]g
INNER JOIN dbo.[Teacher] t on t.ID = g.TeacherID
GROUP BY t.FirstName, t.LastName
GO


--3.Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100)
SELECT t.FirstName,t.LastName, COUNT (*) as TotalGrades
FROM dbo.[Grade] g
INNER JOIN dbo.[Teacher] t on t.ID = g.TeacherId 
WHERE g.StudentID < 100
GROUP BY t.FirstName,t.LastName
GO


--4.Find the Maximal Grade, and the Average Grade per Student on all grades in the system
SELECT s.FirstName ,s.LastName, MAX(g.Grade) as Total, AVG(g.Grade) as Average
FROM dbo.[Grade] g
INNER JOIN dbo.[Student]s on g.StudentID = s.ID
GROUP BY  s.FirstName, s.LastName
GO

--5.Calculate the count of all grades per Teacher in the system and filter only grade count greater then 200
SELECT t.FirstName, t.LastName, COUNT(*) as TotalGrades
FROM dbo.Grade g
INNER JOIN dbo.Teacher t on t.ID = g.TeacherID
GROUP BY t.FirstName, t.LastName
HAVING COUNT (g.Grade) > 200

--6.Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100) 
--and filter teachers with more than 50 Grade count;
SELECT t.FirstName, t.LastName, COUNT(*) as TotalGrades
FROM dbo.[Grade]g
INNER JOIN dbo.[Teacher] t on t.ID = g.TeacherID
WHERE g.StudentID <100
GROUP BY t.FirstName, t.LastName
HAVING COUNT(g.Grade) > 50
GO

--7.Find the Grade Count, Maximal Grade, and the Average Grade per Student on all grades in the system.
--Filter only records where Maximal Grade is equal to Average Grade;
SELECT s.ID, COUNT(g.Grade) as NumberOfGrades, MAX(g.Grade) as MaxGrade, AVG(g.Grade) as AvgGrade
FROM dbo.[Grade]g
INNER JOIN dbo.[Student]s on s.ID = g.StudentID
GROUP BY s.ID
HAVING MAX(g.Grade) = AVG(g.Grade)
GO

--8.List Student First Name and Last Name next to the other details from previous query

SELECT s.FirstName, s.LastName, COUNT(g.Grade) as NumberOfGrades, MAX(g.Grade) as MaxGrade, AVG(g.Grade) as AvgGrade
FROM dbo.[Grade]g
INNER JOIN dbo.[Student]s on s.ID = g.StudentID
GROUP BY s.FirstName, s.LastName
HAVING MAX(g.Grade) = AVG(g.Grade)
GO

--9.Create new view (vv_StudentGrades) that will List all StudentIds and count of Grades per student

DROP VIEW IF EXISTS vv_StudentGrades;
GO

CREATE VIEW vv_StudentGrades
AS
SELECT StudentID, COUNT(Grade) as NumberOfGrades
FROM dbo.[Grade]
GROUP BY StudentID
GO

SELECT * FROM vv_StudentGrades
GO

--10.Change the view to show Student First and Last Names instead of StudentID

ALTER VIEW vv_StudentGrades
AS
SELECT s.FirstName, s.LastName, COUNT(g.Grade)as NumberOfGrades
FROM dbo.[Grade]g
INNER JOIN dbo.[Student] s on s.ID= g.StudentID
GROUP BY s.FirstName, s.LastName
GO

SELECT * FROM vv_StudentGrades
GO

--11.List all rows from view ordered by biggest Grade Count;

SELECT * FROM vv_StudentGrades
ORDER BY NumberOfGrades DESC

--12.Create new view (vv_StudentGradeDetails) that will List all Students (FirstName and LastName) 
--and Count the courses he passed through the exam(Ispit);

DROP VIEW IF EXISTS vv_StudentGradeDetails ;
GO

CREATE VIEW vv_StudentGradeDetails 
AS
SELECT s.FirstName,s.LastName, ach.Name asAchivementType, COUNT(*) as Exam
FROM dbo.[Grade]g
INNER JOIN dbo.[Student] s on s.ID = g.StudentID
INNER JOIN dbo.[GradeDetails]gd on gd.GradeID = g.ID
INNER JOIN dbo.[AchievementType] ach on  gd.AchievementTypeID = ach.ID
WHERE ach.Name = 'Ispit'
GROUP BY s.FirstName,s.LastName, ach.Name
GO

SELECT * FROM vv_StudentGradeDetails 
GO

