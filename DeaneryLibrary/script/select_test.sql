--получение сданных ведомостей по id группы
exec get_sheet_by_group_id 1
exec get_sheet_by_group_id 2
exec dbo.get_sheet_by_group_and_subject_id 1, 1
----получение среднего значения оценки по группе
exec get_avg_grade_by_group_id 1
exec get_avg_grade_by_group_id 2
exec get_avg_grade_by_subject_id 1

exec get_grade_by_sheet_id 1 
exec get_grade_by_sheet_id 2 

exec get_cur_by_speciality_id 1 

exec dbo.search_teacher 'Виктор', '%','%', '%' 

exec dbo.get_all_group  
exec get_student_by_group_id 1 
exec get_grade_for_week_by_week_id 1 
exec get_control_week_by_id 1 


exec get_students_where_skip_over 50, 1, 1 

exec get_list_poor_students_by_group_id 1, 3

exec get_students_where_skip_over @val = 60, @course = 1, @semester = 1