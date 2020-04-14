# Q1: Find all student names and numbers for students who do not take CS112.

select sno, sname
from student 
where sno NOT IN (
	select sno
	from take
	where cno = 'CS112'
	)

# Q2: Find all student numbers for students who take a course other than CS112.
