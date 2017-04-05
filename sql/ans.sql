--Part 1
--Get where one lecturer
select cname 
from class left join faculty on class.fid=faculty.fid 
group by cname 
having count(class.fid)<=1;

--find snum enrolled in class
select snum 
from enrolled 
join
(select cname 
from class left join faculty on class.fid=faculty.fid 
group by cname 
having count(class.fid)<=1) as t1 on t1.cname=enrolled.cname;

--get student name
select sname
from student
join
(select snum 
from enrolled 
join
(select cname 
from class left join faculty on class.fid=faculty.fid 
group by cname 
having count(class.fid)<=1) as t1 on t1.cname=enrolled.cname) as t2 on t2.snum=student.snum 
where standing='JR'
group by sname;

--Part 2
select student.*
from student
left join
(select snum 
from enrolled 
join
(select cname 
from class join faculty on class.fid=faculty.fid 
group by cname 
having count(class.fid)<=1) as t1 on t1.cname=enrolled.cname) as t2 on t2.snum=student.snum
where t2.snum is not null or major='History'
group by student.snum
ORDER BY age DESC LIMIT 1;

--Part 3
select *
from class
left join enrolled on class.cname=enrolled.cname
ORDER BY class.cname DESC;

/* old version
select class.* from class,(select class.cname,room
from class
left join enrolled on class.cname=enrolled.cname
group by class.cname,room
having count(class.cname)>=5) as t1
where t1.cname=class.cname or class.room='R128'
group by class.cname;
*/
select class.*,t1.num from class
join (select class.cname,count(snum) as num
from class
left join enrolled on class.cname=enrolled.cname
group by class.cname) as t1
on t1.cname=class.cname
where class.room='R128' or t1.num>=5;

--Part 4
select enrolled.cname,class.meets_at
from enrolled join class on enrolled.cname=class.cname group by enrolled.cname,class.meets_at order by class.meets_at DESC;


