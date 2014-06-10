
--- GET ---

use Deanery
go
create proc [get_group_by_speciality_id] (@id int)
as (
		select g.GroupId,g.GroupName, cur.CurriculumId, cur.CurriculumYearIn, cur.CurriculumYearOut
		from [Group] as g
		join [Curriculum] as cur on cur.CurriculumId = g.FK_GroupCurriculum		
	)
go

use Deanery
go 
create proc [get_group_by_id] (@id int)
as (
		select g.GroupName, g.GroupIn, g.GroupOut, s.SpecialityId, s.SpecialityName
		from [Group] as g
		join Curriculum as cur on cur.CurriculumId = g.FK_GroupCurriculum
		join Speciality as s on s.SpecialityId = cur.FK_CurriculumSpeciality
		where g.GroupId = @id )
go

use Deanery
go
create proc  [get_student_by_group_id] (@group_id int)
as ( 
		select s.StudentId, s.StudentFirstName, s.StudentMiddleName, s.StudentLastName, g.GroupName
		from Student as s
		join [Group] as g on g.GroupId = s.FK_StudentGroup
		where s.FK_StudentGroup = @group_id
	)
go

use Deanery
go
create proc [get_all_student_with_group_name]
as ( 
		select s.StudentId, s.StudentFirstName, s.StudentMiddleName, s.StudentLastName, g.GroupId, g.GroupName
		from Student as s
		join [Group] as g on g.GroupId = s.FK_StudentGroup
	)
go


use Deanery
go
create proc [get_subject_by_chair_id] (@chair_id int)
as 
(	select s.SubjectId, s.SubjectName
    from [Subject] as s
    join  Chair as c on c.ChairId = s.FK_SubjectChair
    where c.ChairId = @chair_id
)
 go
 
 use Deanery
 go
create proc [get_subject_by_group_id] (@group_id int)
as
	(
		select 
			  s.SubjectId, s.SubjectName, 
			  sc.SubjectInCurriculumId,
			  sc.SubjectInCurriculumCourse as Course,
			  sc.SubjectInCurriculumSemester as Semester, 
			  sc.SubjectInCurriculumCountOfHours as CountOfHours, 
			  f.FormOfControlId, f.FormOfControlName
		from
			   [Group] as g
			   join Curriculum as cur on cur.CurriculumId = g.FK_GroupCurriculum
			   join SubjectInCurriculum as sc on sc.FK_SubjectInCurriculumCurriculum = cur.CurriculumId
			   join [Subject] as s on s.SubjectId = sc.FK_SubjectInCurriculumSubject
			   join FormOfControl as f on f.FormOfControlId = sc.FK_SubjectInCurriculumFormOfControl 
		
		where g.GroupId = @group_id	   
	)
go

use Deanery
go
create proc [get_teacher_by_chair_id] (@chair_id int)
as (
		select t.TeacherId, t.TeacherFirstName, t.TeacherMiddleName, t.TeacherLastName
		from Deanery.dbo.Teacher as t
		join Deanery.dbo.Chair as c on c.ChairId = t.FK_TeacherChair
		where c.ChairId =  @chair_id
    )
go

use Deanery
go
create proc [get_cur_by_speciality_id] (@s_id int)
as    (
		select cur.CurriculumId, cur.CurriculumYearIn, cur.CurriculumYearOut 
		from Curriculum as cur 
		join Speciality as s on s.SpecialityId = cur.FK_CurriculumSpeciality
		where s.SpecialityId = @s_id
		)
go

--список предметов в учебном плане с указанием кол-ва часов, курса и семестра
--учебный план характеризуетс€ специальность, и временем действи€
use Deanery
go
create proc  [get_subject_in_cur_by_id] (@cur_id int)
as (
		select 
			s.SubjectId, s.SubjectName, 
			sc.SubjectInCurriculumId,
			sc.SubjectInCurriculumCourse as Course,
			sc.SubjectInCurriculumSemester as Semester, 
			sc.SubjectInCurriculumCountOfHours as CountOfHours, 
			f.FormOfControlId, f.FormOfControlName
		 from 
			Curriculum as cur 
			join SubjectInCurriculum as sc on sc.FK_SubjectInCurriculumCurriculum = cur.CurriculumId
			join [Subject] as s on s.SubjectId = sc.FK_SubjectInCurriculumSubject
			join FormOfControl as f on f.FormOfControlId = sc.FK_SubjectInCurriculumFormOfControl 
		where 	cur.CurriculumId = @cur_id
)
go

--		‘ормирование отчета о сданных ведомост€х по группе
use Deanery
go
create proc [get_sheet_by_group_id] (@group_id int)
as (
	select  
		s.SheetId,
		s.SheetDateSet as DateSet,
		s.SheetDateGet as DateGet, 
		f.FormOfControlId, f.FormOfControlName,
		t.TeacherId, t.TeacherFirstName, t.TeacherMiddleName, t.TeacherLastName, t.FK_TeacherChair, ch.ChairName,
		sc.SubjectInCurriculumId,
		sc.SubjectInCurriculumCourse as Course, 
		sc.SubjectInCurriculumSemester as Semester,
		sc.SubjectInCurriculumCountOfHours as CountOfHours,
		sub.SubjectId, sub.SubjectName

	from 
		Sheet as s 
		join Teacher as t on t.TeacherId = s.FK_SheetTeacher
		join FormOfControl as f on f.FormOfControlId = s.FK_SheetFormOfControl
		join [Group] as g on g.GroupId = s.FK_SheetGroup
		join SubjectInCurriculum as sc on sc.SubjectInCurriculumId = s.FK_SheetSubject
		join [Subject] as sub on sub.SubjectId = sc.FK_SubjectInCurriculumSubject
		join Chair as ch on ch.ChairId = t.FK_TeacherChair
	where g.GroupId = @group_id
	)
go
use Deanery
go
create proc [get_sheet_by_group_and_subject_id] (@group_id int, @subject_in_cur_id int)
 as  (
	select  
		s.SheetId,
		s.SheetDateSet as DateSet,
		s.SheetDateGet as DateGet, 
		f.FormOfControlId, f.FormOfControlName,
		t.TeacherId, t.TeacherFirstName, t.TeacherMiddleName, t.TeacherLastName, ch.ChairId, ch.ChairName,
		sc.SubjectInCurriculumId,
		sc.SubjectInCurriculumCourse as Course, 
		sc.SubjectInCurriculumSemester as Semester,
		sc.SubjectInCurriculumCountOfHours as CountOfHours,
		sub.SubjectId, sub.SubjectName

	from 
		Sheet as s 
		join Teacher as t on t.TeacherId = s.FK_SheetTeacher
		join FormOfControl as f on f.FormOfControlId = s.FK_SheetFormOfControl
		join [Group] as g on g.GroupId = s.FK_SheetGroup
		join SubjectInCurriculum as sc on sc.SubjectInCurriculumId = s.FK_SheetSubject
		join [Subject] as sub on sub.SubjectId = sc.FK_SubjectInCurriculumSubject
		join Chair as ch on ch.ChairId = t.FK_TeacherChair
	where g.GroupId = @group_id and sc.SubjectInCurriculumId = @subject_in_cur_id
	)
go

use Deanery 
go
create proc get_sheet_by_id (@sheet_id int)
as ( 
	select sub.SubjectId, sub.SubjectName, 
		   f.FormOfControlName, f.FormOfControlId, 
		   sc.SubjectInCurriculumId, sc.SubjectInCurriculumCourse, sc.SubjectInCurriculumSemester, sc.SubjectInCurriculumCountOfHours,
		   t.TeacherId, t.TeacherFirstName, t.TeacherMiddleName , t.TeacherLastName,
		   g.GroupId, g.GroupName
	from Sheet as s  
	join [Group] as g on g.GroupId = s.FK_SheetGroup
	join [SubjectInCurriculum] as sc on sc.SubjectInCurriculumId = s.FK_SheetSubject
	join [Subject]  as sub on sub.SubjectId = sc.FK_SubjectInCurriculumSubject 
	join [FormOfControl] as f on f.FormOfControlId = s.FK_SheetFormOfControl
	join [Teacher] as t on t.TeacherId = s.FK_SheetTeacher
	where s.SheetId = @sheet_id
 		)
go

use Deanery
go
create proc get_all_teachers_with_chair_name 
as (select t.TeacherId, t.TeacherFirstName , t.TeacherMiddleName , t.TeacherLastName,
							c.ChairId, c.ChairName 
					from Teacher as t
					join [Chair] as c on c.ChairId = t.FK_TeacherChair
		
			)

go

use Deanery 
go  
create proc get_student_by_id (@id int)
as ( 

					select s.StudentFirstName, s.StudentMiddleName, s.StudentLastName,
							g.GroupId,g.GroupName
					from Student as s
					join [Group] as g on g.GroupId = s.FK_StudentGroup
					where 
					s.StudentId = @id
					
			)
go

use Deanery 
go
create proc get_teacher_by_id (@id int)
as (
					select t.TeacherFirstName , t.TeacherMiddleName , t.TeacherLastName,
							c.ChairId, c.ChairName 
					from Teacher as t
					join [Chair] as c on c.ChairId = t.FK_TeacherChair
					where 
					t.TeacherId = @id
			)
go

use Deanery
go
create proc get_all_group 
as (
		select g.GroupName, g.GroupIn, g.GroupOut, s.SpecialityName, s.SpecialityId
		from [Group] as g
		join Curriculum as cur on cur.CurriculumId = g.FK_GroupCurriculum
		join Speciality as s on s.SpecialityId = cur.FK_CurriculumSpeciality	
)
go

use Deanery
go
create proc [get_grade_by_sheet_id] (@id int)
as (select 
			g.GradeId, t.TypeOfGradeName as [Type],
			g.GradeValue, 
			s.StudentId
			from Grade as g 
			join Student as s on s.StudentId = g.FK_GradeStudent
			join TypeOfGrade as t on t.TypeOfGradeId = g.FK_GradeType
			where g.FK_GradeSheet = @id
			
			)
go

use Deanery
go
create proc get_skip_by_week_id(@week_id int)
as (select s.SkipId, s.FK_SkipStudent, s.SkipNumberOfHour from [Skip] as s 
join Sheet as sheet on  sheet.SheetId = s.FK_SkipControlWeek)
go

use Deanery 
go
create proc get_avg_grade_by_group_id (@id int)
as (
			select  s.SubjectName, avg(gr.GradeValue) as AVGValue
			from Grade as gr 
			join Sheet as sht on sht.SheetId = gr.FK_GradeSheet
			join SubjectInCurriculum as sc on sc.SubjectInCurriculumId = sht.FK_SheetSubject
			join [Subject] as s on s.SubjectId = sc.FK_SubjectInCurriculumSubject
			where sht.FK_SheetGroup = 1
			group by s.SubjectName
	)
go

use Deanery 
go
create proc get_avg_grade_by_subject_id (@id int)
as (
		select s.SubjectName, AVG(gr.GradeValue) as AVGValue
		from Grade as gr 
		join Sheet as sheet on sheet.SheetId = gr.FK_GradeSheet
		join SubjectInCurriculum as sc on sc.SubjectInCurriculumId = sheet.FK_SheetSubject
		join [Subject] as s on s.SubjectId = sc.FK_SubjectInCurriculumSubject	
		where s.SubjectId = @id
		group by s.SubjectName
)
go

use Deanery
go
create proc get_grade_for_week_by_week_id(@id int)
as(
	select 
		gr.GradeForWeekId, gr.FK_GradeForWeekStudent as StudentId ,
		gr.GradeForWeekValue
	from 
		GradeForWeek as gr where gr.FK_GradeForWeekControlWeek = @id
)
go

use Deanery
go
create proc get_control_week_by_id (@id int)
as (
	select
		 s.SubjectName, w.ControlWeekNumber as Number, w.ControlWeekBegin as [Begin],
		 w.ControlWeekEnd as [End], g.GroupId, g.GroupName,
		 t.TeacherId, t.TeacherFirstName, t.TeacherMiddleName, t.TeacherLastName
	from
		 ControlWeek as w
		 join SubjectInCurriculum  as sc on sc.SubjectInCurriculumId = w.FK_ControlWeekSubject
		 join [Subject] as s on s.SubjectId = sc.FK_SubjectInCurriculumSubject
		 join [Group] as g on g.GroupId = w.FK_ControlWeekGroup
		 join Teacher as t on t.TeacherId = w.FK_ControlWeekTeacher
	where w.ControlWeekId = @id
	 ) 
go

use Deanery
go
create proc get_group_with_speciality as begin
select g.GroupId, g.GroupName, g.GroupIn, g.GroupOut, spec.SpecialityId, spec.SpecialityName
from [Group] as g 
join Curriculum as cur on cur.CurriculumId = g.FK_GroupCurriculum
join Speciality as spec on spec.SpecialityId = cur.FK_CurriculumSpeciality
end
go

use Deanery 
go
create function get_count_poor_students_by_group_id(@id int, @course int, @semester int) returns int
as begin 
	declare @res int
    set @res = ( select COUNT(gr.GradeValue)
		  from Grade as gr
		  join Student as s on s.StudentId = gr.FK_GradeStudent
		  join TypeOfGrade as t on t.TypeOfGradeId = gr.FK_GradeType
		  join [Group]  as g on g.GroupId = s.FK_StudentGroup
		  join Sheet as sheet on sheet.SheetId = gr.FK_GradeSheet
		  join SubjectInCurriculum as sc on sc.SubjectInCurriculumId = sheet.FK_SheetSubject
		  join [Subject] as sub on sub.SubjectId = sc.FK_SubjectInCurriculumSubject
	      where 
			gr.GradeValue < 3 and
			g.GroupId = @id   and
			sc.SubjectInCurriculumCourse = @course and
			sc.SubjectInCurriculumSemester = @semester
		   )
    return  @res
end
go

use Deanery 
go
create proc get_list_poor_students_by_group_id(@group_id int, @control_week_id int) 
as (
		select
			st.StudentId, st.StudentFirstName, st.StudentLastName,
		    s.SubjectName
		from Student as st
			join [Group] as g on g.GroupId = st.FK_StudentGroup
			join GradeForWeek as gw on gw.FK_GradeForWeekStudent = st.StudentId
			join ControlWeek as cw on cw.ControlWeekId = gw.FK_GradeForWeekControlWeek
			join SubjectInCurriculum as sc on sc.SubjectInCurriculumId = cw.FK_ControlWeekSubject
			join [Subject] as s on s.SubjectId = sc.FK_SubjectInCurriculumSubject
		where g.GroupId = @group_id and cw.ControlWeekId = @control_week_id 
			  and gw.GradeForWeekValue = 0
		   )
go


use Deanery
go
create proc get_move_by_group_id(@id int) as 
(
	select m.MoveId, t.TypeOfMoveName, m.MoveFrom, g.GroupName, m.MoveTo,
		   s.StudentId, s.StudentFirstName, s.StudentMiddleName, s.StudentLastName,
		   m.MoveDate
		   
	from
		[Move] as m
		join TypeOfMove as t on t.TypeOfMoveId = m.FK_MoveType
		join Student as s on s.StudentId = m.FK_MoveStudent
		join [Group] as g on g.GroupId = m.FK_MoveGroup
	where g.GroupId = @id --order by g.GroupName, s.StudentFirstName, s.StudentMiddleName, s.StudentLastName
)
go


--use Deanery
--go
--create proc get_list_poor_students_by_group_id(@id int, @course int, @semester int) as 
--(
--	select
--)
--go



use Deanery 
go
create proc get_students_where_skip_over(@val int, @course int, @semester int) as 
(
	select
			skp.FK_SkipStudent, s.StudentFirstName, s.StudentLastName,  
			SUM(skp.SkipNumberOfHour) as CountSkip, g.GroupName
	from [Skip] as skp 
		join Student as s on s.StudentId = skp.FK_SkipStudent
		join [Group] as g on g.GroupId = s.FK_StudentGroup
	where 
		skp.FK_SkipControlWeek in (
			select c.ControlWeekId from ControlWeek as c 
			join SubjectInCurriculum as sc on sc.SubjectInCurriculumId = c.FK_ControlWeekSubject 
			where sc.SubjectInCurriculumCourse = @course and sc.SubjectInCurriculumSemester = @semester
		)
	group by skp.FK_SkipStudent, s.StudentFirstName, s.StudentLastName, g.GroupName 
	having SUM(skp.SkipNumberOfHour) >= @val

)
go


use Deanery
go
create proc get_list_sheet_by_teacher (@teacher_id int, @date_start date, @date_end date) as (
	
	select sh.SheetId, s.SubjectName,  g.GroupName, AVG(gr.GradeValue) as AVGValue, sh.SheetDateGet, sh.SheetDateSet
	from Sheet as sh
		join Teacher as t on t.TeacherId = sh.FK_SheetTeacher
		join SubjectInCurriculum as sc on sc.SubjectInCurriculumId = sh.FK_SheetSubject
		join [Subject] as s on s.SubjectId = sc.FK_SubjectInCurriculumSubject 
		join [Group] as g on g.GroupId = sh.FK_SheetGroup 
		join Grade as gr on gr.FK_GradeSheet = sh.SheetId
	where 
		sh.SheetDateSet >= '12.01.2013' and sh.SheetDateGet <= '09.04.2016'
		--sh.SheetDateSet >= @date_start and sh.SheetDateGet <= @date_end
	group by sh.SheetId, s.SubjectName,  g.GroupName, sh.SheetDateGet, sh.SheetDateSet
)
go





----- SEARCH ---

--use Deanery 
--go 
--create proc search_teacher(@first_name varchar(50)='%', @middle_name varchar(50) = '%', @last_name varchar(50)='%', @chair_name varchar(50)='%')
--as (
--	select *
--	from Teacher as t 
--	join Chair as c on t.FK_TeacherChair = c.ChairId
--	where 
--	t.TeacherFirstName like @first_name and t.TeacherLastName like @last_name and t.TeacherMiddleName like @middle_name 
--	and c.ChairName like @chair_name
--)