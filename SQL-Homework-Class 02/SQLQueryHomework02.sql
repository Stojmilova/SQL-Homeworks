USE SEDCHome
GO

--1.Find all Students with FirstName = Antonio
SELECT *
FROM [Student]
WHERE FirstName ='Antonio'

--2.Find all Students with DateOfBirth greater than ‘01.01.1999’
SELECT *
FROM [Student]
WHERE DateOfBirth > '1999.01.01'

--3.Find all Male students
SELECT *
FROM [Student]
WHERE Gender ='M'
GO

--4.Find all Students with LastName starting With ‘T’
SELECT *
FROM [Student]
WHERE LastName like 'T%'
GO

--5.Find all Students Enrolled in January/1998
SELECT *
FROM [Student]
WHERE EnrolledDate >= '1998.01.01' and EnrolledDate < '1998.02.01'
GO

--6.Find all Students with LastName starting With ‘J’ enrolled in January/1998
SELECT *
FROM [Student]
WHERE EnrolledDate >= '1998.01.01' and EnrolledDate < '1998.02.01'
and LastName like 'J%'
GO

--7.Find all Students with FirstName = Antonio ordered by Last Name
SELECT *
FROM[Student]
WHERE FirstName = 'Antonio'
ORDER BY LastName
GO

--8.List all Students ordered by FirstName
SELECT *
FROM[Student]
ORDER BY FirstName
GO

--9.Find all Male students ordered by EnrolledDate, starting from the last enrolled
SELECT *
FROM[Student]
WHERE Gender='M'
ORDER BY EnrolledDate desc
GO

--10.List all Teacher First Names and Student First Names in single result set with duplicates
SELECT FirstName
FROM [Teacher]
UNION ALL
SELECT FirstName
FROM[Student]

--11.List all Teacher Last Names and Student Last Names in single result set. Remove duplicates
SELECT LastName
FROM [Teacher]
UNION
SELECT LastName
FROM [Student]

--12.List all common First Names for Teachers and Students
SELECT FirstName
FROM [Teacher]
INTERSECT
SELECT FirstName
FROM [Student]

--13.Change GradeDetails table always to insert value 100 in AchievementMaxPoints column if no value is provided on insert;
ALTER TABLE [GradeDetails]
ADD CONSTRAINT DF_GradeDetails_AchievementMaxPoints 
default 100 for [AchievementMaxPoints]
GO

SELECT * FROM GradeDetails
GO

INSERT INTO GradeDetails (gradeid,achievementtypeid,achievementpoints, achievementdate)
VALUES (1,5,80,'1988.01.01')
GO


--14.Change GradeDetails table to prevent inserting AchievementPoints that will more than AchievementMaxPoints;
SELECT * FROM AchievementType
GO

ALTER TABLE [GradeDetails] WITH CHECK
ADD CONSTRAINT CHK_AchievementPoints
CHECK (AchievementPoints <= AchievementMaxPoints );
GO

--15.Change AchievementType table to guarantee unique names across the Achievement types;
ALTER TABLE [AchievementType] WITH CHECK
ADD CONSTRAINT UC_AchievementType_Name 
UNIQUE (Name)
GO

--16.Create Foreign key constraints from diagram or with script;

ALTER TABLE [dbo].[Grade]  WITH CHECK 
ADD CONSTRAINT [FK_Grade_Student]
FOREIGN KEY([StudentId])
REFERENCES [dbo].[Student] ([Id])
GO



--17.List all possible combinations of Courses names and AchievementType names that can be passed by student;
SELECT c.Name AS CourseName, t.Name AS AchievementTypeName
FROM Course c
CROSS JOIN AchievementType t
GO

--18.List all Teachers that has any exam Grade;
SELECT DISTINCT t.FirstName
FROM [Grade] g
inner join dbo.Teacher t on t.Id = g.TeacherId
GO


--19.List all Teachers without exam Grade;
SELECT DISTINCT t.FirstName
FROM [Teacher] t
left join [Grade] g on t.Id = g.TeacherId
WHERE g.TeacherId is null
GO


--20.List all Students without exam Grade (using Right Join);
SELECT s.*
FROM [Grade] g
RIGHT JOIN [Student]s on g.StudentId = s.Id
WHERE g.StudentId is null















