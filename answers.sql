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
	select sno, count(cno) as classes
	from take
	group by sno
	)

select s.sno, sname, classes
from student as s
join amount_classes as ac
on s.sno = ac.sno

where classes >= 3

