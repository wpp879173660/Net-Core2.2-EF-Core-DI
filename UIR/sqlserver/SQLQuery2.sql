
USE [master]
GO
IF EXISTS(SELECT count(*) FROM sysdatabases WHERE NAME='HkTemp')
BEGIN
DROP DATABASE HkTemp --如果数据库存在先删掉数据库
END
GO
CREATE DATABASE HkTemp
ON
PRIMARY --创建主数据库文件
(
NAME='HkTemp',
FILENAME='E:\HkTemp.dbf',
SIZE=5MB,
MaxSize=20MB,
FileGrowth=1MB  
)
LOG ON --创建日志文件
(
NAME='HkTempLog',
FileName='E:\HkTemp.ldf',
Size=2MB,
MaxSize=20MB,
FileGrowth=1MB
)
GO

use HkTemp
go

create table AA
(
	id int identity(1,1) primary key,
	name varchar(20) not null,
	age int not null,
	sex char(2) not null,
	address varchar(50) not null
)

insert into AA(name,sex,age,address) values('颤三','男',20,'湖南省长沙市岳麓区')
insert into AA(name,sex,age,address) values('孝感','女',22,'湖南省长沙市岳麓区')
insert into AA(name,sex,age,address) values('李存','男',23,'湖南省长沙市岳麓区')
insert into AA(name,sex,age,address) values('王晓梅','女',24,'湖南省长沙市岳麓区')
insert into AA(name,sex,age,address) values('马冬梅','女',19,'湖南省长沙市岳麓区')

--学生表
create table Student(
	Sno varchar(20) not null,
	Sname varchar(20) not null,
	Ssex char(2) not null,
	Sbirthday datetime,
	Class varchar(20)
)
--教师表
create table Teacher(
	Tno varchar(20) not null,
	Tname varchar(20) not null,
	Tsex char(2) not null,
	Tbrithday datetime,
	Prof varchar(20),
	Depart varchar(20) not null
)

--课程表
create table Course(
	Cno varchar(20) not null,
	Cname varchar(20) not null,
	Tno varchar(20) not null
)
--成绩表
create table Score(
	Sno varchar(20) not null,
	Cno varchar(20) not null,
	--成绩
	Degree Decimal
)

--学生表约束
alter table Student
add constraint CK_Sno check(Sno is not null),	--为列Sno添加非空约束
	constraint PK_Sno primary key(Sno),			--为列Sno添加主键约束
	constraint CK_Ssex check(Ssex='男' or Ssex='女')	--为列Ssex添加检查约束,令列Ssex列只能输入男或女

alter table Course
add constraint CK_Cno check(Cno is not null),
	constraint PK_Cno primary key(Cno),		--为列Cno添加主键约束
	constraint UQ_Cname unique(Cname)		--为列Cname添加唯一约束

alter table Teacher
add constraint CK_Tno check(Tno is not null),
	constraint PK_Tno primary key(Tno),				 --为列Tno添加主键约束
	constraint CK_Tsex check(Tsex='男' or Tsex='女')	--为列Tsex添加检查约

	go
	--添加数据
-- 添加学生信息
insert into student values('108','曾华','男','1977-09-01','95033');
insert into student values('105','匡明','男','1975-10-02','95031');
insert into student values('107','王丽','女','1976-01-23','95033');
insert into student values('101','李军','男','1976-02-20','95033');
insert into student values('109','王芳','女','1975-02-10','95031');
insert into student values('103','陆君','男','1974-06-03','95031');

-- 添加教师信息
insert into Teacher values('804','李诚','男','1958-12-02','副教授','计算机系');
insert into Teacher values('856','张旭','男','1969-03-12','讲师','电子工程系');
insert into Teacher values('825','王萍','女','1972-05-05','助教','计算机系');
insert into Teacher values('831','刘冰','女','1977-08-14','助教','电子工程系');
insert into Teacher values('834','刘冰s','女','1977-08-14','助教','电子工程系');
insert into Teacher values('837','刘冰s','女','1977-08-14','助教','AA');
-- 添加课程信息
insert into course values('3-105','计算机导论','825');
insert into course values('3-245','操作系统','804');
insert into course values('6-166','数字电路','856');
insert into course values('9-888','高等数学','831');
select * from score
-- 添加成绩信息
insert into score values('103','3-245','86');
insert into score values('105','3-245','75');
insert into score values('109','3-245','68');
insert into score values('103','3-105','92');
insert into score values('105','3-105','88');
insert into score values('109','3-105','76');
-- insert into score values('103','3-105','64');
-- insert into score values('105','3-105','91');
-- insert into score values('109','3-105','78');
-- 这三行数据在样例里面给出，但是主键重复了。- -，报错吓了我一跳
insert into score values('103','6-166','85');
insert into score values('105','6-166','79');
insert into score values('109','6-166','81')
go

create table grade 
(low  int,upp  int,ranks  char(1))
insert into grade values(90,100,'A')

insert into grade values(80,89,'B')

insert into grade values(70,79,'C')

insert into grade values(60,69,'D')

insert into grade values(0,59,'E')


select * from grade
--分数表
select * from Score 
--学生表 
select * from Student 
--教师表 
select * from Teacher 
--课程表 
select * from Course 

--28、查询“计算机系”与“电子工程系“不同职称的教师的Tname和Prof。?
select * from Teacher a
where Prof not in (select Prof from teacher b where b.Depart <> a.Depart)
select * from Teacher 

select Prof,Depart from Teacher as a
where Prof not in (select Prof from Teacher as b where b.Depart <> a.Depart)
--27、查询出“计算机系“教师所教课程的成绩表。
select s.* from Course c join Score s
on c.Cno = s.Cno
join Teacher t
on c.Tno = t.Tno
where t.Depart = '计算机系'

select A.* from Teacher as T
inner join Course as C
on T.Tno=C.Tno
inner join Score AS A
on A.Cno=C.Cno
where T.Depart='计算机系'

--26、  查询存在有85分以上成绩的课程Cno. 和去掉重复数据
select distinct Cno from Score where Degree > 85

select Cno from Score where Degree > 85
group by Cno

--25、查询95033班和95031班全体学生的记录。
select * from Student where Class = '95033' or Class = '95031'

--24、查询选修某课程的同学人数多于5人的教师姓名。
select t.Tname,COUNT(c.Tno) '人数' from Course c join Score s
on c.Cno = s.Cno
join Teacher t
on c.Tno = t.Tno
group by s.Cno,T.Tname
having COUNT(c.Tno) >5

--23、查询“张旭“教师任的学生成绩。
select A.* from Teacher as T
inner join Course as C
on T.Tno=C.Tno
inner join Score AS A
on A.Cno=C.Cno
where T.Tname='张旭'
--22、查询和学号为105的同学同年出生的所有学生的Sno、Sname和Sbirthday列。
select * from Score AS A
inner join Student AS S
on A.Sno=S.Sno
where year(S.Sbirthday) = (select year(Sbirthday) from Student where Sno='105')

--20、查询score中选学多门课程的同学中分数为非最高分成绩的记录。
select * from Score 
Select * from score a 
where degree <(select max(degree) from Score b where b.Cno=a.Cno) 
and Sno in (select Sno from Score group by Sno having count(*)>1)
--结合条件一定要写在子查询中,子查询内部设定的关联名称,只能在该子查询内部使用,也就是说内部可以看到外部,而
--外部看不到内部
--SQL是按照先内层子查询后补外层查询的顺序来执行的,这样,子查询执行结束后只会留下执行结果.


--19、  查询选修“3-105”课程的成绩高于“109”号同学成绩的所有同学的记录。
select * from Score sc join Student s
on sc.Sno = s.Sno
join Course c
on sc.Cno = c.Cno
where sc.Cno = '3-105' and sc.Degree > (select MAX(Degree) from Score where Sno='109')


select * from Score 
where Degree > (select Degree from Score where Sno='109' and Cno = '3-105') and  Cno = '3-105'
--18、现查询所有同学的Sno、Cno和rank列。
--方法一
select A.* , G.ranks from Score as A 
inner join grade as G
on A.Degree between G.low and G.upp

--方法二
select A.* , G.ranks from Score as A 
inner join grade as G
on A.Degree between G.low and G.upp


--17、 查询“95033”班学生的平均分。
select s.Class,AVG(c.Degree) from Student s join Score c 
on s.Sno = c.Sno
group by s.Class

select S.Class as 班级 ,avg(A.Degree) as 评分分 from Score as A
inner join Student as S
on S.Sno = A.Sno
group by S.Class

--16、查询所有学生的Sname、Cname和Degree列。
select st.Sname,c.Cname,s.Degree from Score s join Course c 
on s.Cno = c.Cno
join Student st
on s.Sno = st.Sno

select S.Sname,A.Degree,C.Cname from Score as A 
inner join Course as C
on A.Cno = C.Cno
inner join Student as S
on S.Sno=A.Sno

--15、查询所有学生的Sno、Cname和Degree列。
select s.Sno,c.Cname,s.Degree from Score s join Course c 
on s.Cno = c.Cno
--14、查询所有学生的Sname、Cno和Degree列。
select s.Sname,b.Cno,b.Degree from Student s  
join Score b 
on s.Sno = b.Sno

select A.Sno,A.Degree,B.Sname from Score as A 
inner join Student as B
on A.Sno = B.Sno
--13、查询分数大于70，小于90的Sno列。
select Sno from score where Degree between 71 and 89

--12、查询Score表中至少有5名学生选修的并以3开头的课程的平均分数。
select  convert(numeric(18,2),AVG(Degree)) '平均成绩',Cno '课程' from Score 
group by Cno 
having Cno like '3%' and Cno in (select Cno from Score group by Cno having count(Cno) >2)

select Cno,avg(Degree) from Score
group by Cno
having Cno like '3%' and Cno in (select Cno from Score group by Cno having count(Cno) > 1)
--11、查询每门课的平均成绩，要按照课程分组group by，然后求没门课平均avg
select convert(numeric(18,2),AVG(Degree)) '平均成绩',Cno '课程' from score group by Cno

select Cno, convert(numeric(18,2),avg(Degree)) 平均成绩 from Score
group by Cno
--10、 查询Score表中的最高分的学生学号和课程号。（子查询或者排序）
select top(1) Sno,Cno from Score order by Degree desc
select Sno,Cno from Score where Degree = (select max(Degree) from Score)
--9、查询“95031”班的学生人数。
select count(*) from Student where Class = '95031'

--8、以Cno升序、Degree降序查询Score表的所有记录。
select * from Score order by Cno,Degree desc

--7、以Class降序查询Student表的所有记录。
select * from Student order by Class desc

--6、查询Student表中“95031”班或性别为“女”的同学记录。
select * from Student
where Class='95031' or Ssex='女'

--5、查询Score表中成绩为85，86或88的记录。
select * from Score 
where Degree in(85,86,88)

--4、查询Score表中成绩在60到80之间的所有记录
select * from Score 
where Degree between 60 and 80

--3、查询Student表的所有记录。
select * from Student

--2、 查询教师所有的单位即不重复的Depart列。
select * from Teacher
select distinct Depart from Teacher
select distinct Prof from Teacher

--1、 查询Student表中的所有记录的Sname、Ssex和Class列。
select Sname,Ssex,Class from Student



