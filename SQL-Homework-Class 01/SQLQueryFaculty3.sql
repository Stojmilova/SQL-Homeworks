CREATE DATABASE ETF;

GO

USE ETF;

GO

DROP TABLE IF EXISTS[dbo].Faculty;
DROP TABLE IF EXISTS[dbo].Teacher;
DROP TABLE IF EXISTS[dbo].Student;
DROP TABLE IF EXISTS[dbo].Course;
DROP TABLE IF EXISTS[dbo].Grade;
DROP TABLE IF EXISTS[dbo].GradeDetails;
DROP TABLE IF EXISTS[dbo].AchievementType;

CREATE TABLE [dbo].[Faculty](
[Id][smallint]IDENTITY(1,1) NOT NULL,
[TeacherID][smallint] NOT NULL,
[StudentID][int] NOT NULL,
[CourseID][smallint] NOT NULL,
[GradeID][int] NOT NULL,
[Name] [nvarchar](50) NOT NULL,
[FacultyType][nvarchar](100)  NULL,
[FacultyAddress][nvarchar](100) NULL,
CONSTRAINT [PK_Faculty] PRIMARY KEY CLUSTERED 
(
[Id] ASC
))

CREATE TABLE [dbo].[Teacher](
[Id] [smallint] IDENTITY(1,1) NOT NULL,
[FirstName] [nvarchar](50) NOT NULL,
[LastName][nvarchar](50) NOT NULL,
[DateOfBirth][date] NULL,
[AcademicRank][nvarchar](50) NULL,
[HireDate][date]NULL,
CONSTRAINT [PK_Teacher] PRIMARY KEY CLUSTERED 
(
[Id] ASC
))

CREATE TABLE [dbo].[Student](
[Id][int] IDENTITY (1,1) NOT NULL,
[FirstName] [nvarchar](50) NOT NULL,
[LastName][nvarchar](50) NOT NULL,
[DateOfBirth][date] NULL,
[EnrolledDate][date] NULL,
[Gender][nchar](1)NULL,
[NationalIdNumber][nvarchar](20) NULL,
[StudentCardNumber][nvarchar](20) NULL,
CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
[Id] ASC
))

CREATE TABLE [dbo].[Course](
[Id][int] IDENTITY (1,1) NOT NULL,
[Name] [nvarchar](50) NOT NULL,
[Credit] [int] NULL,
[AcademicYear] [date] NOT NULL,
CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
[Id] ASC
))

CREATE TABLE [dbo].[Grade](
[Id][int] IDENTITY (1,1) NOT NULL,
[StudentID][int] NOT NULL,
[CourseID][smallint] NOT NULL,
[TeacherID][smallint] NOT NULL,
[GradeValue][tinyint] NOT NULL,
[Comment][nvarchar](100) NULL,
[CreatedDate][datetime] NOT NULL,
CONSTRAINT [PK_Grade] PRIMARY KEY CLUSTERED 
(
[Id] ASC
))

CREATE TABLE [dbo].[GradeDetails](
[Id][int] IDENTITY (1,1) NOT NULL,
[GradeID][int] NOT NULL,
[AchievementTypeID][int] NOT NULL,
[AchievementPoints][int] NOT NULL,
[AchievementMaxPoints][bigint] NOT NULL,
[AchievementDate][date] NOT NULL,
CONSTRAINT [PK_GradeDetails] PRIMARY KEY CLUSTERED 
(
[Id] ASC
))


CREATE TABLE [dbo].[AchievementType](
[Id][int] IDENTITY (1,1) NOT NULL,
[Name][nvarchar](50) NOT NULL,
[Description][nvarchar](300)NOT NULL,
[ParticipationRate][int] NOT NULL,
CONSTRAINT [PK_AchievementType] PRIMARY KEY CLUSTERED 
(
[Id] ASC
))

--Teacher

INSERT INTO [Teacher]([FirstName],[LastName])
VALUES ( 'Anna', 'Bennton' )

INSERT INTO [Teacher]([FirstName],[LastName],[DateOfBirth], [AcademicRank], [HireDate])
VALUES ( 'Mark', 'Jamison', '2002-02-02', 'Assistant', '2002-03-03')

UPDATE [Teacher]
SET DateOfBirth ='1987-05-11', HireDate='2012-03-26'

DELETE 
FROM [Teacher]
WHERE LastName = 'Jamison'


UPDATE [Teacher]
SET DateOfBirth ='1987-05-11', HireDate='2012-03-26'
WHERE FirstName = 'Mark'


INSERT INTO [Teacher]([FirstName],[LastName],[DateOfBirth], [AcademicRank], [HireDate])
VALUES ( 'Megan', 'Wolton', '1987-11-17', 'Assistant', '2013-04-15')


INSERT INTO [Teacher]([FirstName],[LastName],[DateOfBirth], [AcademicRank], [HireDate])
VALUES ( 'Taylor', 'Travis', '1989-02-15', 'Assistant', '2013-04-15')

--Student

INSERT INTO[Student]([FirstName],[LastName],[DateOfBirth],[EnrolledDate], [Gender],[NationalIdNumber],[StudentCardNumber] )
VALUES('Jennifer', 'Martel', '1988-10-30', '2007-09-15', 'f', '12345678901234567891', '98765432109876543211')

INSERT INTO[Student]([FirstName],[LastName],[DateOfBirth],[EnrolledDate], [Gender],[NationalIdNumber],[StudentCardNumber] )
VALUES('Clark', 'Patterson', '1985-08-25', '2009-11-28', 'm', '1234567891', '98765432191')

INSERT INTO[Student]([FirstName],[LastName],[DateOfBirth],[EnrolledDate], [Gender],[NationalIdNumber],[StudentCardNumber] )
VALUES('Sophie', 'Causer', '1984-03-27', '2011-01-08', 'f', 'A12345', 'M9876541213')

INSERT INTO[Student]([FirstName],[LastName])
VALUES('Amelia', 'Clark')



--Course

INSERT INTO [Course]([Name] ,[Credit], [AcademicYear] )
VALUES('SQLDatabase', 8, '2008-09-15')

INSERT INTO [Course]([Name] ,[Credit], [AcademicYear] )
VALUES('C#', 7, '2008-10-1')

INSERT INTO [Course]([Name] ,[Credit], [AcademicYear] )
VALUES('JavaScript', 6, '2008-11-15')

INSERT INTO [Course]([Name] ,[AcademicYear] )
VALUES('CSS', '2012-09-30')



--Grade

INSERT INTO [Grade]([StudentID] ,[CourseID], [TeacherID], [GradeValue], [Comment], [CreatedDate] )
VALUES(1, 1, 1, 8 , 'WellDone', '2008-07-12')

UPDATE [Grade]
SET StudentID = 7
WHERE GradeValue = 8

INSERT INTO [Grade]([StudentID] ,[CourseID], [TeacherID], [GradeValue], [Comment], [CreatedDate] )
VALUES(8, 2, 4, 9 , 'Good', '2008-06-10')

INSERT INTO [Grade]([StudentID] ,[CourseID], [TeacherID], [GradeValue], [Comment], [CreatedDate] )
VALUES(9, 3, 5, 10 , 'Excellent', '2009-02-16')

--AchievementType

INSERT INTO [AchievementType]([Name],[Description],[ParticipationRate])
VALUES( 'Exam', 'Required', 50)

INSERT INTO [AchievementType]([Name],[Description],[ParticipationRate])
VALUES( 'Homework', 'Additionally',30)

INSERT INTO [AchievementType]([Name],[Description],[ParticipationRate])
VALUES( 'ClassActivity', 'Additionally', 20)


--GradeDetails

INSERT INTO [GradeDetails]([GradeID],[AchievementTypeID],[AchievementPoints],[AchievementMaxPoints],[AchievementDate])
VALUES(1, 1, 78, 100, '2010-05-05')

INSERT INTO [GradeDetails]([GradeID],[AchievementTypeID],[AchievementPoints],[AchievementMaxPoints],[AchievementDate])
VALUES(2, 2, 98, 100, '2009-11-25')

INSERT INTO [GradeDetails]([GradeID],[AchievementTypeID],[AchievementPoints],[AchievementMaxPoints],[AchievementDate])
VALUES(3, 3, 76, 100, '2008-09-10')

--Faculty

INSERT INTO [Faculty]([TeacherID],[StudentID],[CourseID],[GradeID],[Name],[FacultyType],[FacultyAddress])
VALUES(3, 9, 3, 3, 'ETF', 'Faculty of Informatics' , 'Partizanska')

INSERT INTO [Faculty]([TeacherID],[StudentID],[CourseID],[GradeID],[Name])
VALUES(2, 8, 2, 2, 'FINKI')












