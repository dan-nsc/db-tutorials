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
select distinct class.cname from class 
join enrolled on class.cname=enrolled.cname 
where class.room='R128' or class.cname 
in (select enrolled.cname from enrolled group by enrolled.cname having count(enrolled.cname)>=5);

--Part 4
select * from (select enrolled.cname,class.meets_at
from enrolled join class on enrolled.cname=class.cname 
group by enrolled.cname,class.meets_at)t1,(select enrolled.cname,class.meets_at
from enrolled join class on enrolled.cname=class.cname 
group by enrolled.cname,class.meets_at)t2 where t1.cname!=t2.cname;

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

Ex 5.2:
--Part 1
select pname from catalog join parts on catalog.pid=parts.pid group by pname;

--Part 4
select pname,color from suppliers,catalog,parts,(select * from suppliers,catalog where suppliers.sid=catalog.sid and suppliers.sname!='Acme Widget Suppliers') as t1 where suppliers.sname='Acme Widget Suppliers' and suppliers.sid=catalog.sid and catalog.pid=parts.pid and catalog.pid!=t1.pid group by pname,color;

--Part 5
select suppliers.sid from suppliers,catalog, (select pname,parts.pid,avg(cost),color from suppliers,catalog,parts where suppliers.sid=catalog.sid and catalog.pid=parts.pid group by parts.pid,pname,color) as t1 where t1.pid=catalog.pid and catalog.cost>t1.avg and suppliers.sid=catalog.sid;

--Part 6
select suppliers.sname,pname,t1.color from suppliers,catalog, (select pname,parts.pid,max(cost),color from suppliers,catalog,parts where suppliers.sid=catalog.sid and catalog.pid=parts.pid group by parts.pid,pname,color) as t1 where t1.pid=catalog.pid and catalog.cost=t1.max and suppliers.sid=catalog.sid order by pname;

--Part 7
select sname,pname from suppliers,catalog,parts where suppliers.sid=catalog.sid and catalog.pid=parts.pid and parts.color='Red' and suppliers.sid not in (select suppliers.sid from suppliers,catalog,parts where suppliers.sid=catalog.sid and catalog.pid=parts.pid and parts.color!='Red');

--Part 8
select t1.sid from (select * from catalog join parts on catalog.pid=parts.pid where color='Red') t1,(select * from catalog join parts on catalog.pid=parts.pid where color='Green')t2 where t1.sid=t2.sid;

--Part 9
select sid from catalog join parts on catalog.pid=parts.pid where color='Red' or color='Green' group by sid;

--Part 10
select suppliers.sname,count(pname) from suppliers,catalog,parts where suppliers.sid=catalog.sid and catalog.pid=parts.pid and suppliers.sid in (select suppliers.sid from suppliers,catalog,parts where color='Green' and suppliers.sid=catalog.sid and catalog.pid=parts.pid) group by sname;

--Part 11
