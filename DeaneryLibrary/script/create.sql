--drop database [Deanery]
create database [Deanery]
go
use [Deanery] on (NAME = Deanery_db, SIZE = 10MB,
    MAXSIZE = 1024MB, DEFAULT_FULLTEXT_LANGUAGE = 'Russian')
go


create table [Speciality](
	[SpecialityId] int not null identity(1,1) primary key,
	[SpecialityName] varchar(50) not null
);

create table [Chair](
	[ChairId] int not null identity(1,1) primary key,
	[ChairName] varchar(50) not null
);
--тип оценки в ведомости
create table [TypeOfGrade](
	[TypeOfGradeId] int not null identity(1,1) primary key,
	[TypeOfGradeName] varchar(50) not null
);

create table [FormOfControl](
	[FormOfControlId] int not null identity(1,1) primary key,
	[FormOfControlName] varchar(50) not null
);

create table [TypeOfMove] (
	[TypeOfMoveId] int not null identity(1,1) primary key,
	[TypeOfMoveName] varchar(50) not null
);

create table [Teacher](
	[TeacherId] int not null identity(1,1) primary key,
	[TeacherFirstName] varchar(50) not null,
	[TeacherMiddleName] varchar(50) not null,
	[TeacherLastName] varchar(50) not null,
	[FK_TeacherChair] int not null foreign key references [Chair]
);

create table [Curriculum](
	[CurriculumId] int not null identity(1, 1) primary key, 
	[CurriculumYearIn] date not null,
	[CurriculumYearOut] date not null,
	[FK_CurriculumSpeciality] int not null foreign key references [Speciality]
);

create table [Group]( 
	[GroupId] int not null identity(1,1) primary key,
	[GroupName] varchar(50) not null,
	[GroupIn]  date not null,
	[GroupOut] date not null,
	[FK_GroupCurriculum] int not null foreign key references [Curriculum]
	 );
	 
create table [Student](
	[StudentId] int not null identity(1,1) primary key,
	[StudentFirstName] varchar(50) not null,
	[StudentMiddleName] varchar(50) not null,
	[StudentLastName] varchar(50) not null,
	[FK_StudentGroup] int not null foreign key references [Group]
);

create table [Subject](
	[SubjectId] int not null identity(1, 1) primary key,
	[SubjectName] varchar(50) not null,
	[FK_SubjectChair] int not null foreign key references [Chair]
);

create table [SubjectInCurriculum] (
	[SubjectInCurriculumId] int not null identity(1, 1) primary key,
	[SubjectInCurriculumSemester] int not null,
	[SubjectInCurriculumCourse] int not null,
	[SubjectInCurriculumCountOfHours] int not null,
	[FK_SubjectInCurriculumSubject] int not null foreign key references [Subject],
	[FK_SubjectInCurriculumCurriculum] int not null foreign key references [Curriculum],
	[FK_SubjectInCurriculumFormOfControl] int not null foreign key references [FormOfControl]
);
--ведомость
create table [Sheet](
	[SheetId]  int not null identity(1, 1) primary key,
	[FK_SheetGroup] int not null foreign key references [Group],
	[FK_SheetTeacher] int not null foreign key references [FormOfControl],
	[FK_SheetSubject] int not null foreign key references [SubjectInCurriculum],
	[FK_SheetFormOfControl] int not null foreign key references [FormOfControl],
	[SheetDateGet] date not null, --дата выдачи
	[SheetDateSet] date not null -- дата возврата
);

create table [Grade] (
	[GradeId]   int not null identity(1, 1) primary key,
	[FK_GradeStudent] int not null foreign key references [Student],
	[FK_GradeType] int not null foreign key references [TypeOfGrade],
	[FK_GradeSheet] int not null foreign key references [Sheet],
	[GradeValue] int not null
);

--alter table [Grade] alter column [GradeType] int not null foreign key() references [FormOfControl]

create table [ControlWeek](
	[ControlWeekId]  int not null identity(1, 1) primary key,
	[ControlWeekBegin] date not null,
	[ControlWeekEnd] date not null,
	[ControlWeekNumber] int not null, 
	[FK_ControlWeekGroup] int not null foreign key references [Group],
	[FK_ControlWeekTeacher] int not null foreign key references [Teacher],
	[FK_ControlWeekSubject] int not null foreign key references [SubjectInCurriculum]
);

create table [Skip] (
	[SkipId]   int not null identity(1, 1) primary key,
	[SkipNumberOfHour] int not null, 
	[FK_SkipControlWeek] int not null foreign key references [ControlWeek],
	[FK_SkipStudent] int not null foreign key references [Student]
);

create table [GradeForWeek](
	[GradeForWeekId] int not null identity(1, 1) primary key,
	[GradeForWeekValue] int not null,
	[FK_GradeForWeekControlWeek] int not null foreign key references [ControlWeek],
	[FK_GradeForWeekStudent] int not null foreign key references [Student],
);

create table [Move] (
	[MoveId] int not null identity(1, 1) primary key,
	[FK_MoveType] int not null foreign key references [TypeOfMove],
	[MoveDate] date not null,
	[MoveTo]   int,
	[MoveFrom] int,
	[FK_MoveStudent] int not null foreign key references [Student],
	[FK_MoveGroup]	int not null foreign key references [Group]
);
