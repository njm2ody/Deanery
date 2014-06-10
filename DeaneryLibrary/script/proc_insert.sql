
---	INSERT ---

use Deanery
go
create proc insert_speciality @name varchar(50) as
insert into Speciality (SpecialityName) values(@name)
go

use Deanery 
go
create proc insert_chair @name varchar(50) as
insert into Chair (ChairName) values (@name)
go

use Deanery 
go
create proc insert_type_of_grade @name varchar(50) as 
insert into TypeOfGrade(TypeOfGradeName) values (@name)
go

use Deanery 
go
create proc insert_form_of_control @name varchar(50) as 
insert into FormOfControl(FormOfControlName) values (@name)
go

use Deanery
go
create proc insert_type_of_move @name varchar(50) as 
insert into TypeOfMove (TypeOfMoveName) values (@name)
go


use Deanery
go
create proc insert_student
	@first_name     varchar(50),
	@middle_name    varchar(50),
	@last_name		varchar(50),
	@group_id		int
as 
	insert into Student(StudentFirstName, StudentMiddleName, StudentLastName, FK_StudentGroup) 
	values( @first_name, @middle_name, @last_name, @group_id )
go	


use Deanery
go
create proc insert_teacher   
	@first_name     varchar(50),
	@middle_name    varchar(50),
	@last_name		varchar(50),
	@chair_id		int
as
	insert into Teacher(TeacherFirstName, TeacherMiddleName, TeacherLastName, FK_TeacherChair) 
	values( @first_name, @middle_name, @last_name, @chair_id )
go	


use Deanery
go
create proc insert_curriculum 
@speciality_id		int,
@year_in			date,
@year_out			date

as	
	insert into Curriculum(FK_CurriculumSpeciality, CurriculumYearIn, CurriculumYearOut) 
			values(@speciality_id, @year_in, @year_out)
go


use Deanery
go
create proc insert_subject_in_cur
	@subject_id				int,
	@curiculum_id			int,
	@form_of_control_id		int,
	@count_of_hours			int,
	@course					int,
	@semester				int
as 

	insert into SubjectInCurriculum(FK_SubjectInCurriculumSubject, 
									FK_SubjectInCurriculumCurriculum,
									FK_SubjectInCurriculumFormOfControl,
									SubjectInCurriculumCourse, 
									SubjectInCurriculumSemester, 
									SubjectInCurriculumCountOfHours)
		values (
			@subject_id,
			@curiculum_id,
			@form_of_control_id,
			@course,
			@semester,
			@count_of_hours
		)
go


use Deanery
go
create proc insert_grade
	@student_id				int,
	@sheet_id				int,
	@type_of_grade_id		int,
	@value					int
as 	
	insert into Grade (FK_GradeStudent, FK_GradeSheet, FK_GradeType, GradeValue)
	values (@student_id, @sheet_id, @type_of_grade_id, @value)
go


use Deanery
go
create proc insert_control_week
	@begin			date,
	@end			date,
	@number			int,
	@group_id		int,
	@subject_id		int,
	@teacher_id		int
as
	insert into ControlWeek(ControlWeekBegin, ControlWeekEnd, ControlWeekNumber, FK_ControlWeekGroup, FK_ControlWeekSubject, FK_ControlWeekTeacher)
	values (@begin, @end, @number, @group_id, @subject_id, @teacher_id)
go

use Deanery 
go
create proc insert_move
	@student_id		int,
	@group_id		int,
	@move_type_id	int,
	@date			date,
	@from			int,
	@to				int
as 
	insert into [Move](FK_MoveStudent, FK_MoveGroup, FK_MoveType, MoveDate, MoveFrom, MoveTo)
	values(@student_id, @group_id, @move_type_id, @date, @from, @to)
go


use Deanery
go
create proc insert_sheet
	@group_id				int,
	@teacher_id				int,
	@subject_in_cur_id		int,
	@date_set				date,
	@date_get				date
as
	insert into [Sheet](FK_SheetGroup , FK_SheetTeacher, FK_SheetSubject,   FK_SheetFormOfControl, SheetDateGet, SheetDateSet)
			values(@group_id,			@teacher_id, @subject_in_cur_id, 
			(select top 1 sc.FK_SubjectInCurriculumFormOfControl
			 from SubjectInCurriculum as sc  where sc.SubjectInCurriculumId = @subject_in_cur_id 
			 ),
			@date_get,
			@date_set
			)
go

use Deanery
go
create proc insert_subject
	@name			varchar(50),
	@chair_id		int
as	
	insert into [Subject](SubjectName, FK_SubjectChair)
	values (@name, (select c.ChairId
					from Chair as c 
					where c.ChairId = @chair_id) )
go

--use Deanery
--go
--create proc insert_link_group_cur
--	@group_name		varchar(50),
--	@s_name			varchar(50),
--	@cur_in			date,
--	@cur_out		date
--as 
--	insert into link_group_curriculum(FK_link_group_curriculumGroup, FK_link_group_curriculumCurriculum)
--	values (
--				(select g.GroupId from [Group] as g where g.GroupName like @group_name),
--				(select cur.CurriculumId 
--				 from Curriculum as cur
--				 join Speciality as s on s.SpecialityId = cur.FK_CurriculumSpeciality
--				 where s.SpecialityName like @s_name and cur.CurriculumYearIn = @cur_in 
--													 and cur.CurriculumYearOut = @cur_out
--				 )
--	)
--go

use Deanery 
go
create proc insert_group
	@name			varchar(50),
	@speciality_id		int,
	@year_in		date,
	@year_out		date
as
	insert into [Group](GroupName, FK_GroupCurriculum, GroupIn, GroupOut)
	values(@name,
		(   select top 1 cur.CurriculumId 
			from Curriculum as cur 
			join  Speciality as s on s.SpecialityId = cur.FK_CurriculumSpeciality
			where s.SpecialityId = @speciality_id 
				and	cur.CurriculumYearIn <= @year_in and cur.CurriculumYearOut >= @year_out
		 ),
		  @year_in, @year_out
		)
go

use Deanery 
go
create proc insert_skip (@week_id int, @student_id int, @count int)
as begin
	insert into Skip(FK_SkipControlWeek, FK_SkipStudent, SkipNumberOfHour)
	values (@week_id, @student_id, @count)
end
go

use Deanery
go
create proc insert_grade_for_control_week(@student_id int, @week_id int, @value int)
as begin 
	insert into GradeForWeek(FK_GradeForWeekStudent , FK_GradeForWeekControlWeek, GradeForWeekValue)
	values (@student_id, @week_id, @value)
end
go


-- UPDATE --

use Deanery
go
create proc update_chair (@id int, @name varchar(50)) as begin
update Chair set ChairName = @name where ChairId = @id
end
go

use Deanery
go
create proc update_subject (@id int, @name varchar(50), @chair_id int) as begin 
update [Subject] set SubjectName = @name where SubjectId = @id
update [Subject] set FK_SubjectChair = @chair_id where SubjectId = @id
end
go

use Deanery
go
create proc update_speciality (@id int, @name varchar(50)) as begin
update Speciality set SpecialityName = @name where SpecialityId = @id
end
go

use Deanery
go
create proc update_group (@id int, @name varchar(50),@year_in date,  @year_out date, @speciality_id  int) as begin
update [Group] set GroupName  = @name, GroupIn = @year_in, GroupOut = @year_out, 
  FK_GroupCurriculum = (		select cur.CurriculumId 
			from Curriculum as cur 
			join  Speciality as s on s.SpecialityId = cur.FK_CurriculumSpeciality
			where s.SpecialityId = @speciality_id 
				and	cur.CurriculumYearIn = @year_in
  )
where GroupId = @id
end
go

use Deanery
go
create proc update_student(@id int, @first_name varchar(50), @middle_name varchar(50), @last_name varchar(50), @group_id int) as begin 
update Student set StudentFirstName = @first_name, StudentMiddleName = @middle_name, StudentLastName = @last_name, FK_StudentGroup = @group_id
where StudentId = @id 
end
go


---	DELETE ---

use Deanery
go
create proc delete_chair (@id int) as begin 
	delete from Chair where ChairId = @id
end
go

use Deanery
go
create proc delete_control_week (@id int)
as begin 
	delete from ControlWeek where ControlWeekId = @id
end
go

--use Deanery
--go
--create proc delete_curriculum (@id int)
--as begin 
--	delete 
--	from (dbo.Curriculum as cur)

	

use Deanery
go
create proc delete_form_of_control (@id int)
as begin 
	delete from FormOfControl where FormOfControlId = @id
end
go

use Deanery
go
create proc delete_grade (@id int)
as begin 
	delete from Grade where GradeId = @id
end
go

use Deanery
go
create proc delete_grade_for_control_week (@id int)
as begin 
	delete from GradeForWeek where GradeForWeekId = @id
end
go

use Deanery
go
create proc delete_group (@id int)
as begin 
	delete from [Student]  where FK_StudentGroup = @id
	delete from [Grade] where FK_GradeSheet in (select s.SheetId from Sheet as s where s.FK_SheetGroup = @id)
	delete from Sheet where FK_SheetGroup = @id
	delete from GradeForWeek where FK_GradeForWeekControlWeek in (select c.ControlWeekId from ControlWeek as c where c.FK_ControlWeekGroup = @id)
	delete from [Skip] where FK_SkipControlWeek in (select c.ControlWeekId from ControlWeek as c where c.FK_ControlWeekGroup = @id)
	delete from ControlWeek where FK_ControlWeekGroup = @id
	delete from [Group] where GroupId  = @id
	
end
go

use Deanery
go
create proc delete_move (@id int)
as begin 
	delete from [Move] where MoveId  = @id
end
go

use Deanery
go
create proc delete_student(@id int) as begin
delete from [Grade] where FK_GradeStudent = @id
delete from [GradeForWeek] where FK_GradeForWeekStudent = @id
delete  from [Student] where StudentId = @id
end
go 

--use Deanery
--go
--create proc delete_speciality(@id int) as begin
--select * from [Group] as g join Curriculum as cur on cur.CurriculumId = g.FK_GroupCurriculum
--delete from Speciality where SpecialityId = @id
--end