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

select room from class left join enrolled on class.cname=enrolled.cname group by room having count(enrolled.cname)>=5 or room='R128'

--Part 4
select enrolled.cname,class.meets_at
from enrolled join class on enrolled.cname=class.cname group by enrolled.cname,class.meets_at order by class.meets_at DESC;

—Part 5
select * from faculty,(select * from (select fid,count(room) from class group by fid) as t1 where t1.count=(select count(*) from (select room from class group by room) as t1)) as t2 where faculty.fid=t2.fid;

—Part 6
select fname,count(fname) from (select fname,faculty.fid,class.cname from faculty join class on faculty.fid=class.fid) as t1 join enrolled on t1.cname=enrolled.cname group by fname having count(fname)<5;

—Part 7
select standing,avg(age) from student group by standing;

—Part 8
select standing,avg(age) from student where standing!='JR' group by standing;

—Part 9


—Part 10
select sname from student,(select snum,count(snum) from enrolled group by snum having count(snum)=3) as t1 where student.snum=t1.snum;

—Part 11
select sname from student where snum not in (select snum from enrolled);

—Part 12
select age,standing,count(standing) from student group by age,standing;

