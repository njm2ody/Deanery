-- fill database
use Deanery
go

exec insert_speciality 'Инноватика'
exec insert_speciality 'Прикладная информатика'
go

--chairs
exec insert_chair 'Высшей математики' 
exec insert_chair 'Иностранных языков'
exec insert_chair 'Прикладной информатики'
go

exec insert_type_of_grade	'Зачет'
exec insert_type_of_grade	'Экзамен'
exec insert_type_of_grade	'Диф. Зачет'
exec insert_type_of_grade	'Курсовая'
exec insert_type_of_grade	'Неявка'
exec insert_type_of_grade	'Гос. Аттестация'
go

exec insert_form_of_control	'Зачет'
exec insert_form_of_control	'Экзамен'
exec insert_form_of_control	'Диф. Зачет'
exec insert_form_of_control	'Курсовая'
exec insert_form_of_control	'Гос. Аттестация'
go

exec insert_type_of_move  'Перевод на следующий курс'
exec insert_type_of_move  'Перевод на следующий семестр'
exec insert_type_of_move  'Зачисление'
exec insert_type_of_move  'Отчисление'
exec insert_type_of_move  'Выпуск'
go

exec insert_teacher 'Денис', 'Георгиевич', 'Сидоров',	 1 
exec insert_teacher 'Илья', 'Валерьевич', 'Кормильцев',	 2 
exec insert_teacher 'Василий', 'Олегович', 'Пупкин',	 1  
exec insert_teacher 'Арагорн', 'сын', 'Арахорна',		 1 
go

exec insert_curriculum		1, '2011', '2023'
exec insert_curriculum		2, '2008', '2019'
go

exec insert_group '1234', 1, '1.09.2014', '1.07.2018'
exec insert_group '4567', 2, '1.09.2014', '1.07.2018'
go

exec insert_student 'Иван', 'Евгеньевич', 'Ерохин',			 1
exec insert_student 'Иван', 'Иванович', 'Иванов',			 1
exec insert_student 'Акакий', 'Акакиевич', 'Башмаков',		 1
exec insert_student 'Василий', 'Петрович', 'Пупкин',		 1
exec insert_student 'Алексей', 'Владимирович', 'Дмитриев',   1

exec insert_student 'Евгений', 'Евгеньевич', 'Овсянкин',     2
exec insert_student 'Степан', 'Владимирович', 'Никитин',     2
exec insert_student 'Олег', 'Олегович', 'Иванов',			 2
exec insert_student 'Вячеслав', 'Иванович', 'Петров-Водкин', 2
exec insert_student 'Евгений', 'Евгеньевич', 'Денисов',		 2
go


exec insert_subject 'Мат. Анализ', 1
exec insert_subject 'Теория вероятности', 1
exec insert_subject 'Английский язык', 2
exec insert_subject 'Технологии баз данных', 3
exec insert_subject 'Языки программирования', 3
go

exec insert_subject_in_cur 1, 1, 2, 49, 1, 1 
exec insert_subject_in_cur 2, 1, 2, 51, 1, 1
exec insert_subject_in_cur 3, 1, 1, 38, 1, 1
exec insert_subject_in_cur 4, 1, 1, 18, 1, 2
exec insert_subject_in_cur 5, 1, 1, 23, 1, 2
exec insert_subject_in_cur 1, 1, 2, 49, 1, 2
exec insert_subject_in_cur 2, 1, 2, 55, 1, 2
exec insert_subject_in_cur 3, 1, 1, 64, 1, 2

exec insert_subject_in_cur 1, 2, 2, 68, 1, 1
exec insert_subject_in_cur 2, 2, 2, 78, 1, 1
exec insert_subject_in_cur 3, 2, 1, 24, 1, 1
exec insert_subject_in_cur 1, 2, 2, 68, 1, 2
exec insert_subject_in_cur 2, 2, 2, 78, 1, 2
exec insert_subject_in_cur 3, 2, 1, 24, 1, 2
go

exec insert_sheet 1, 3, 1, '02.12.2015', '02.14.2015'
exec insert_sheet 1, 3, 3, '02.12.2015', '02.14.2015'

exec insert_sheet 2, 4, 9, '02.12.2015', '02.14.2015'
exec insert_sheet 2, 4, 10, '02.12.2015', '02.14.2015'
go

exec insert_grade 1,  1, 2,  5
exec insert_grade 2,  1, 2,  4
exec insert_grade 3,  1, 2,  3
exec insert_grade 4,  1, 2,  1
exec insert_grade 5,  1, 2,  5
exec insert_grade 1,  2, 1,  5
exec insert_grade 2,  2, 1,  0
exec insert_grade 3,  2, 1,  1
exec insert_grade 4,  2, 1,  5
exec insert_grade 5,  2, 1,  4

exec insert_grade 6,  3, 2,  5
exec insert_grade 7,  3, 2,  5
exec insert_grade 8,  3, 2,  5
exec insert_grade 9,  3, 2,  5
exec insert_grade 10, 3, 2,  3
exec insert_grade 6,  4, 1,  5
exec insert_grade 7,  4, 1,  5
exec insert_grade 8,  4, 1,  5
exec insert_grade 9,  4, 1,  5
exec insert_grade 10, 4, 1,  3
go


exec insert_control_week '10.2.2014', '10.6.2014', 7, 1, 1, 3 
exec insert_control_week '10.2.2014', '10.6.2014', 7, 2, 10, 4

exec insert_control_week '02.10.2014', '08.6.2014', 14, 1, 1, 3 
exec insert_control_week '02.10.2014', '08.6.2014', 14, 2, 10, 4

go

exec insert_skip  1, 1, 23
exec insert_skip  1, 2, 65
exec insert_skip  1, 3, 89
exec insert_skip  1, 4, 12
exec insert_skip  1, 5, 0

exec insert_skip  2, 6, 32
exec insert_skip  2, 7, 24
exec insert_skip  2, 8, 89
exec insert_skip  2, 9, 54
exec insert_skip  2, 10, 12

exec insert_skip  3, 1, 17
exec insert_skip  3, 2, 10
exec insert_skip  3, 3, 8
exec insert_skip  3, 4, 10
exec insert_skip  3, 5, 0

exec insert_skip  4, 6, 32
exec insert_skip  4, 7, 22
exec insert_skip  4, 8, 20
exec insert_skip  4, 9, 53
exec insert_skip  4, 10, 13

go

exec insert_grade_for_control_week  1, 1,  2
exec insert_grade_for_control_week  2, 1,  2
exec insert_grade_for_control_week  3, 1,  1
exec insert_grade_for_control_week  4, 1,  0
exec insert_grade_for_control_week  5, 1,  2

exec insert_grade_for_control_week  6,  2,  0
exec insert_grade_for_control_week  7,  2,  1
exec insert_grade_for_control_week  8,  2,  2
exec insert_grade_for_control_week  9,	2,  2
exec insert_grade_for_control_week  10, 2,  2

exec insert_grade_for_control_week  1, 3,  0
exec insert_grade_for_control_week  2, 3,  1
exec insert_grade_for_control_week  3, 3,  2
exec insert_grade_for_control_week  4, 3,  1
exec insert_grade_for_control_week  5, 3,  2

exec insert_grade_for_control_week  6,  4,  2
exec insert_grade_for_control_week  7,  4,  0
exec insert_grade_for_control_week  8,  4,  1
exec insert_grade_for_control_week  9,	4,  1
exec insert_grade_for_control_week  10, 4,  2

go

exec insert_move 1, 2, 2, '02.12.2015', 1, 2
exec insert_move 2, 2, 2, '02.12.2015', 1, 2
exec insert_move 3, 2, 2, '02.12.2015', 1, 2
exec insert_move 4, 2, 2, '02.12.2015', 1, 2
exec insert_move 5, 2, 2, '02.12.2015', 1, 2

exec insert_move 6, 1, 2, '02.12.2015', 1, 2
exec insert_move 7, 1, 2, '02.12.2015', 1, 2
exec insert_move 8, 1, 2, '02.12.2015', 1, 2
exec insert_move 9, 1, 2, '02.12.2015', 1, 2
exec insert_move 10, 1, 2, '02.12.2015', 1, 2
go

