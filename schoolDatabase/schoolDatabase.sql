CREATE TABLE classroom(
building VARCHAR(15),
room_number VARCHAR(7),
capacity NUMERIC(4,0),
CONSTRAINT pk_classroom PRIMARY KEY(building, room_number)
);
Create table department(
dept_name varchar(20),
bulding varchar(15),
budget numeric(12,2) check(budget>0),
constraint pk_department PRIMARY KEY(dept_name)
);
create table course(
course_id varchar(8),
title varchar(50),
dept_name varchar(20),
credits numeric(2,0) check(credits>0),
constraint pk_course PRIMARY KEY(course_id),
constraint fk_course foreign key(dept_name) references department(dept_name)
on delete set null
);
create table instructor(
instructor_id varchar(8),
instructor_name varchar(30) not null,
dept_name varchar(30),
salary numeric(8,2) check (salary >10000),
constraint pk_instructor primary key(instructor_id),
constraint fk_instructor_department foreign key(dept_name)
references department(dept_name)
on delete set null
);
create table section(
course_id varchar(8),
sec_id varchar(8),
semester varchar(8),
year numeric(4,0),
building varchar(15),
room_number varchar(8),
time_slot_id varchar(4),
constraint pk_section PRIMARY KEY(course_id, sec_id, semester, year),
constraint fk_section_course FOREIGN KEY(course_id) references course(course_id) ON DELETE CASCADE,
constraint fk_secion_classroom FOREIGN KEY(building, room_number) references classroom(building,room_number) on delete set null,
check (year>1701 and year<2100),
check (semester in ('FALL', 'WINTER', 'SPRING', 'SUMMER'))
);
create table teaches(
id varchar(5),
course_id varchar(8),
sec_id varchar(8),
semester varchar(6),
year numeric(4,0),
constraint pk_teaches primary key(id, course_id, sec_id, semester, year),
constraint fk_teaches_instructor foreign key(id) references instructor(instructor_id) 
on delete cascade
);
create table student(
id varchar(5),
student_name varchar(20) not null,
dept_name varchar(20),
tot_cred numeric(3,0) check (tot_cred>=0),
constraint pk_student primary key(id),
constraint fk_student foreign key(dept_name) references department(dept_name) 
on delete cascade
);
create table takes(
id varchar(5),
course_id varchar(8),
sec_id varchar(8),
semester varchar(6),
year numeric(4,0),
grade varchar(2),
constraint pk_takes primary key (id, course_id, sec_id, semester, year),
constraint fk_takes_section foreign key(course_id, sec_id, semester, year) 
references section(course_id, sec_id, semester, year)
on delete cascade,
constraint fk_takes_student foreign key(id) references student(id) on delete cascade,
check (grade in('A','B','C','D','F'))
);
CREATE TABLE advisor(
s_id varchar(8),
i_id varchar(8),
constraint pk_advisor primary key(s_id),
constraint fk_advisor_instructor foreign key(i_id) references instructor(instructor_id) on delete set null,
constraint fk_advisor_student foreign key(s_id) references student(id) on delete cascade
);
create table time_slot(
time_slot_id varchar(8),
day varchar(1),
start_hr numeric(2) check (start_hr>=0 and start_hr<24),
start_min numeric(2) check(start_min>=0 and start_min<60),
end_hr numeric(2) check(end_hr>=0 and end_hr<24),
end_min numeric(2) check(end_min>=0 and end_min<60)
);
create table prereq(
course_id varchar(5),
prereq_id varchar(5),
constraint pk_prereq primary key(course_id,prereq_id),
constraint fk_prereq_courses foreign key (course_id) references course(course_id) on delete cascade,
constraint fk_prereq_prereq_id foreign key(prereq_id) references course(course_id)
);