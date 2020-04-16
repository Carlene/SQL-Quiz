# Q1: Find all student names and numbers for students who do not take CS112.

select sno, sname
from student 
where sno NOT IN (
	select sno
	from take
	where cno = 'CS112'
	)


# Q2: Find all student numbers for students who take a course other than CS112.

select sno, sname
from (
	select s.sno, sname, cno

	from student as s
	left join take as t
	on s.sno = t.sno
	) as all_classes

where cno != 'CS112'

group by sno, sname

# Q3: Which students take at least three courses?

with amount_classes as (
	select 
	sno, count(cno) as classes
	from take
	group by sno
	)

select s.sno, sname, classes

from student as s
join amount_classes as ac
on s.sno = ac.sno

where classes >= 3

# Q4: Find students who take CS112 or CS114 but not both.
select sno, sname, more_than_one
from (
	select 
	*
	,row_number () over (partition by sno) as more_than_one

	from (
		select s.sno, sname, cno

		from student as s
		join take as t
		on s.sno = t.sno

		where cno = 'CS112'
		OR 
		cno = 'CS114'
		) as both_classes
	) as class_list

where more_than_one = 1

-- Q5: Find the students who take exactly 2 courses.

with amount_classes as (
	select 
	sno, count(cno) as classes
	from take
	group by sno
	)

select s.sno, sname, classes

from student as s
join amount_classes as ac
on s.sno = ac.sno

where classes = 2

-- Q6: Find the students who take at most 2 courses.

with amount_classes as (
	select 
	sno, count(cno) as classes
	from take
	group by sno
	)

select s.sno, sname, classes

from student as s
join amount_classes as ac
on s.sno = ac.sno

where classes <=2

-- Q7: Find the students who take only CS112 and nothing else.

select sno, sname
from student 
where sno IN (
	select sno
	from take
	where cno = 'CS112'
	)

-- Q8: Find the youngest students WITHOUT using MIN() or MAX().
select *
	from (
	select 
	*
	, row_number () over (order by age) as asc_age

	from student
	) as ordered_ages
where asc_age = 1

