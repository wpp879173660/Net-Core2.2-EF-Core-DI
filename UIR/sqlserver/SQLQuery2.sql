
USE [master]
GO
IF EXISTS(SELECT count(*) FROM sysdatabases WHERE NAME='HkTemp')
BEGIN
DROP DATABASE HkTemp --������ݿ������ɾ�����ݿ�
END
GO
CREATE DATABASE HkTemp
ON
PRIMARY --���������ݿ��ļ�
(
NAME='HkTemp',
FILENAME='E:\HkTemp.dbf',
SIZE=5MB,
MaxSize=20MB,
FileGrowth=1MB  
)
LOG ON --������־�ļ�
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

insert into AA(name,sex,age,address) values('����','��',20,'����ʡ��ɳ����´��')
insert into AA(name,sex,age,address) values('Т��','Ů',22,'����ʡ��ɳ����´��')
insert into AA(name,sex,age,address) values('���','��',23,'����ʡ��ɳ����´��')
insert into AA(name,sex,age,address) values('����÷','Ů',24,'����ʡ��ɳ����´��')
insert into AA(name,sex,age,address) values('��÷','Ů',19,'����ʡ��ɳ����´��')

--ѧ����
create table Student(
	Sno varchar(20) not null,
	Sname varchar(20) not null,
	Ssex char(2) not null,
	Sbirthday datetime,
	Class varchar(20)
)
--��ʦ��
create table Teacher(
	Tno varchar(20) not null,
	Tname varchar(20) not null,
	Tsex char(2) not null,
	Tbrithday datetime,
	Prof varchar(20),
	Depart varchar(20) not null
)

--�γ̱�
create table Course(
	Cno varchar(20) not null,
	Cname varchar(20) not null,
	Tno varchar(20) not null
)
--�ɼ���
create table Score(
	Sno varchar(20) not null,
	Cno varchar(20) not null,
	--�ɼ�
	Degree Decimal
)

--ѧ����Լ��
alter table Student
add constraint CK_Sno check(Sno is not null),	--Ϊ��Sno��ӷǿ�Լ��
	constraint PK_Sno primary key(Sno),			--Ϊ��Sno�������Լ��
	constraint CK_Ssex check(Ssex='��' or Ssex='Ů')	--Ϊ��Ssex��Ӽ��Լ��,����Ssex��ֻ�������л�Ů

alter table Course
add constraint CK_Cno check(Cno is not null),
	constraint PK_Cno primary key(Cno),		--Ϊ��Cno�������Լ��
	constraint UQ_Cname unique(Cname)		--Ϊ��Cname���ΨһԼ��

alter table Teacher
add constraint CK_Tno check(Tno is not null),
	constraint PK_Tno primary key(Tno),				 --Ϊ��Tno�������Լ��
	constraint CK_Tsex check(Tsex='��' or Tsex='Ů')	--Ϊ��Tsex��Ӽ��Լ

	go
	--�������
-- ���ѧ����Ϣ
insert into student values('108','����','��','1977-09-01','95033');
insert into student values('105','����','��','1975-10-02','95031');
insert into student values('107','����','Ů','1976-01-23','95033');
insert into student values('101','���','��','1976-02-20','95033');
insert into student values('109','����','Ů','1975-02-10','95031');
insert into student values('103','½��','��','1974-06-03','95031');

-- ��ӽ�ʦ��Ϣ
insert into Teacher values('804','���','��','1958-12-02','������','�����ϵ');
insert into Teacher values('856','����','��','1969-03-12','��ʦ','���ӹ���ϵ');
insert into Teacher values('825','��Ƽ','Ů','1972-05-05','����','�����ϵ');
insert into Teacher values('831','����','Ů','1977-08-14','����','���ӹ���ϵ');
insert into Teacher values('834','����s','Ů','1977-08-14','����','���ӹ���ϵ');
insert into Teacher values('837','����s','Ů','1977-08-14','����','AA');
-- ��ӿγ���Ϣ
insert into course values('3-105','���������','825');
insert into course values('3-245','����ϵͳ','804');
insert into course values('6-166','���ֵ�·','856');
insert into course values('9-888','�ߵ���ѧ','831');
select * from score
-- ��ӳɼ���Ϣ
insert into score values('103','3-245','86');
insert into score values('105','3-245','75');
insert into score values('109','3-245','68');
insert into score values('103','3-105','92');
insert into score values('105','3-105','88');
insert into score values('109','3-105','76');
-- insert into score values('103','3-105','64');
-- insert into score values('105','3-105','91');
-- insert into score values('109','3-105','78');
-- ����������������������������������ظ��ˡ�- -������������һ��
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
--������
select * from Score 
--ѧ���� 
select * from Student 
--��ʦ�� 
select * from Teacher 
--�γ̱� 
select * from Course 

--28����ѯ�������ϵ���롰���ӹ���ϵ����ְͬ�ƵĽ�ʦ��Tname��Prof��?
select * from Teacher a
where Prof not in (select Prof from teacher b where b.Depart <> a.Depart)
select * from Teacher 

select Prof,Depart from Teacher as a
where Prof not in (select Prof from Teacher as b where b.Depart <> a.Depart)
--27����ѯ���������ϵ����ʦ���̿γ̵ĳɼ���
select s.* from Course c join Score s
on c.Cno = s.Cno
join Teacher t
on c.Tno = t.Tno
where t.Depart = '�����ϵ'

select A.* from Teacher as T
inner join Course as C
on T.Tno=C.Tno
inner join Score AS A
on A.Cno=C.Cno
where T.Depart='�����ϵ'

--26��  ��ѯ������85�����ϳɼ��Ŀγ�Cno. ��ȥ���ظ�����
select distinct Cno from Score where Degree > 85

select Cno from Score where Degree > 85
group by Cno

--25����ѯ95033���95031��ȫ��ѧ���ļ�¼��
select * from Student where Class = '95033' or Class = '95031'

--24����ѯѡ��ĳ�γ̵�ͬѧ��������5�˵Ľ�ʦ������
select t.Tname,COUNT(c.Tno) '����' from Course c join Score s
on c.Cno = s.Cno
join Teacher t
on c.Tno = t.Tno
group by s.Cno,T.Tname
having COUNT(c.Tno) >5

--23����ѯ�����񡰽�ʦ�ε�ѧ���ɼ���
select A.* from Teacher as T
inner join Course as C
on T.Tno=C.Tno
inner join Score AS A
on A.Cno=C.Cno
where T.Tname='����'
--22����ѯ��ѧ��Ϊ105��ͬѧͬ�����������ѧ����Sno��Sname��Sbirthday�С�
select * from Score AS A
inner join Student AS S
on A.Sno=S.Sno
where year(S.Sbirthday) = (select year(Sbirthday) from Student where Sno='105')

--20����ѯscore��ѡѧ���ſγ̵�ͬѧ�з���Ϊ����߷ֳɼ��ļ�¼��
select * from Score 
Select * from score a 
where degree <(select max(degree) from Score b where b.Cno=a.Cno) 
and Sno in (select Sno from Score group by Sno having count(*)>1)
--�������һ��Ҫд���Ӳ�ѯ��,�Ӳ�ѯ�ڲ��趨�Ĺ�������,ֻ���ڸ��Ӳ�ѯ�ڲ�ʹ��,Ҳ����˵�ڲ����Կ����ⲿ,��
--�ⲿ�������ڲ�
--SQL�ǰ������ڲ��Ӳ�ѯ������ѯ��˳����ִ�е�,����,�Ӳ�ѯִ�н�����ֻ������ִ�н��.


--19��  ��ѯѡ�ޡ�3-105���γ̵ĳɼ����ڡ�109����ͬѧ�ɼ�������ͬѧ�ļ�¼��
select * from Score sc join Student s
on sc.Sno = s.Sno
join Course c
on sc.Cno = c.Cno
where sc.Cno = '3-105' and sc.Degree > (select MAX(Degree) from Score where Sno='109')


select * from Score 
where Degree > (select Degree from Score where Sno='109' and Cno = '3-105') and  Cno = '3-105'
--18���ֲ�ѯ����ͬѧ��Sno��Cno��rank�С�
--����һ
select A.* , G.ranks from Score as A 
inner join grade as G
on A.Degree between G.low and G.upp

--������
select A.* , G.ranks from Score as A 
inner join grade as G
on A.Degree between G.low and G.upp


--17�� ��ѯ��95033����ѧ����ƽ���֡�
select s.Class,AVG(c.Degree) from Student s join Score c 
on s.Sno = c.Sno
group by s.Class

select S.Class as �༶ ,avg(A.Degree) as ���ַ� from Score as A
inner join Student as S
on S.Sno = A.Sno
group by S.Class

--16����ѯ����ѧ����Sname��Cname��Degree�С�
select st.Sname,c.Cname,s.Degree from Score s join Course c 
on s.Cno = c.Cno
join Student st
on s.Sno = st.Sno

select S.Sname,A.Degree,C.Cname from Score as A 
inner join Course as C
on A.Cno = C.Cno
inner join Student as S
on S.Sno=A.Sno

--15����ѯ����ѧ����Sno��Cname��Degree�С�
select s.Sno,c.Cname,s.Degree from Score s join Course c 
on s.Cno = c.Cno
--14����ѯ����ѧ����Sname��Cno��Degree�С�
select s.Sname,b.Cno,b.Degree from Student s  
join Score b 
on s.Sno = b.Sno

select A.Sno,A.Degree,B.Sname from Score as A 
inner join Student as B
on A.Sno = B.Sno
--13����ѯ��������70��С��90��Sno�С�
select Sno from score where Degree between 71 and 89

--12����ѯScore����������5��ѧ��ѡ�޵Ĳ���3��ͷ�Ŀγ̵�ƽ��������
select  convert(numeric(18,2),AVG(Degree)) 'ƽ���ɼ�',Cno '�γ�' from Score 
group by Cno 
having Cno like '3%' and Cno in (select Cno from Score group by Cno having count(Cno) >2)

select Cno,avg(Degree) from Score
group by Cno
having Cno like '3%' and Cno in (select Cno from Score group by Cno having count(Cno) > 1)
--11����ѯÿ�ſε�ƽ���ɼ���Ҫ���տγ̷���group by��Ȼ����û�ſ�ƽ��avg
select convert(numeric(18,2),AVG(Degree)) 'ƽ���ɼ�',Cno '�γ�' from score group by Cno

select Cno, convert(numeric(18,2),avg(Degree)) ƽ���ɼ� from Score
group by Cno
--10�� ��ѯScore���е���߷ֵ�ѧ��ѧ�źͿγ̺š����Ӳ�ѯ��������
select top(1) Sno,Cno from Score order by Degree desc
select Sno,Cno from Score where Degree = (select max(Degree) from Score)
--9����ѯ��95031�����ѧ��������
select count(*) from Student where Class = '95031'

--8����Cno����Degree�����ѯScore������м�¼��
select * from Score order by Cno,Degree desc

--7����Class�����ѯStudent������м�¼��
select * from Student order by Class desc

--6����ѯStudent���С�95031������Ա�Ϊ��Ů����ͬѧ��¼��
select * from Student
where Class='95031' or Ssex='Ů'

--5����ѯScore���гɼ�Ϊ85��86��88�ļ�¼��
select * from Score 
where Degree in(85,86,88)

--4����ѯScore���гɼ���60��80֮������м�¼
select * from Score 
where Degree between 60 and 80

--3����ѯStudent������м�¼��
select * from Student

--2�� ��ѯ��ʦ���еĵ�λ�����ظ���Depart�С�
select * from Teacher
select distinct Depart from Teacher
select distinct Prof from Teacher

--1�� ��ѯStudent���е����м�¼��Sname��Ssex��Class�С�
select Sname,Ssex,Class from Student



