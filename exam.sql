
--一，编程题 （总分50分）
--1、创建一张老师表，包含（老师编号、姓名、性别、薪资、身份证号、工作岗位、部门编号）；创建一张部门表，包含（部门编号、部门名称、部门描述）（2分）

--创建一张老师表
create table teacher(
       id number(4),
       name varchar2(20),
       sex char(2),
       sal number(5),
       card varchar2(18),
       job varchar2(20),
       deptno number(2)           
)
--创建一张部门表
create table dept(
       deptno number(2),
       dname varchar2(20),
       dinfo varchar(50)
)
--添加部门描述
comment on table dept is '部门表';
comment on column dept.deptno is '部门编号';
comment on column dept.dname is '部门名称';
comment on column dept.dinfo is '部门描述';
--2、为老师表的字段添加约束，老师编号（主键约束）、性别（检查约束，只能是男、女）、身份证号码（唯一约束）、部门编号（外键约束，引用部门表的部门编号）（3分）
--主键约束
alter table teacher add constraint pk_teacher_primary primary key(id);
alter table dept add constraint pk_dept_primary primary key(deptno);
--检查约束
alter table teacher add constraint ch_teacher_sex check(sex='男' or sex='女');
--唯一约束
alter table teacher add constraint uniq_teacher_card unique(card);
--外键约束
alter table teacher add constraint fk_teacher_dept foreign key(deptno) references dept(deptno);

--3、修改表结构，为老师表添加年龄列；删除部门表中的部门描述列（2分）
--添加年龄列
alter table teacher add(age number(3));
select * from teacher;
--删除部门表中的部门描述列
alter table dept drop column dinfo;
select * from dept;

--4、编写SQL语句：（3分）
--a.给部门表插入3条数据分别是：教学部、市场部、行政部 
insert into dept(deptno,dname) values(10,'教学部');
insert into dept(deptno,dname) values(20,'市场部');
insert into dept(deptno,dname) values(30,'行政部');
commit;
--b.给老师表插入6条数据，分别属于教学部、市场部、行政部
--创建自增序列
create sequence seq_teacher
       minvalue 1
       maxvalue 999
       increment by 1;
--创建触发器
create or replace trigger tri_teacher_id
before insert on teacher
for each row
begin
       select seq_teacher.nextval into :new.id from dual;
end;
--插入6条数据
insert into teacher(name,sex,sal,card,job,deptno,age) values('钱一','男',55800,'330621199805068913','教学',10,26);
insert into teacher(name,sex,sal,card,job,deptno,age) values('汪二','男',63300,'330621199705158913','研发',10,21);
insert into teacher(name,sex,sal,card,job,deptno,age) values('张三','女',44800,'330621199406028919','教学',20,24);
insert into teacher(name,sex,sal,card,job,deptno,age) values('李四','男',64800,'330621199205068513','研发',20,26);
insert into teacher(name,sex,sal,card,job,deptno,age) values('王五','男',71800,'330621199204068913','研发',30,26);
insert into teacher(name,sex,sal,card,job,deptno,age) values('陈六','女',25800,'330621199005068913','教学',30,29);
commit;
select * from teacher;

--5、编写SQL语句：查询老师姓名、薪资，要求去掉重复数据（2分）
select distinct name,sal from teacher;

--6、查询薪资是[10000,60000）的女老师（3分）
select * from teacher where sal>=10000 and sal<60000 and sex='女';

--7、查询姓名为张三的老师编号、性别、薪资，查询出的各字段需要取别名（2分）
select id 编号,sex 性别,sal 薪资 from teacher where name='张三';

--8、查询姓张的老师信息（3分）
select * from teacher where name like '张%';

--9、查询姓名中包含张的老师信息（2分）
select * from teacher where name like '%张%';

--10、创建一张表，表结构与老师表一致；往新创建出的表插入数据，数据来源于老师表（3分）
create table teacher_copy as select * from teacher;

--11、查询老师表的所有数据，按薪资降序（2分）
select * from teacher order by sal desc;

--12、修改老师表中张三的薪资为50000，性别为女（3分）
update teacher set sal=50000,sex='女' where name='张三';
commit;

--13、查询部门表中部门名称为空的数据（2分）
insert into dept(deptno) values(40);
commit;
select * from dept where dname is null;

--14、查询老师表中性别不等于男，薪资小于50000的数据（3分）
select * from teacher where sex!='男' and sal<50000;

--15、查询工作岗位为教学和研发的老师数据（2分）
select * from teacher where job in('教学','研发');

--16、删除老师中姓名为张三和李四的数据（3分）
delete from teacher where name in('张三','李四');
commit;

--17、删除老师表中所有的数据，要求用delete、truncate两个方式删除（3分）
--使用delete
delete from teacher where 1=1;
commit;
--使用truncate
truncate table teacher;

--18、删除老师表和部门表（2分）
drop table teacher;
drop table dept;

--19、查询姓陈，薪资大于20000的男老师（2分）
select * from teacher where name like '陈%' and sal>20000;

--20、查询部门里面存在员工信息的部门（3分）
select distinct d.* from dept d,teacher t where d.deptno=t.deptno;


--二，编程题 （总分50分）
  --设计表，
  --1学员表 （学员编号，学员姓名，学员班级编号，学员入学时间） （2分） 
  create table student(
         id number(4),
         name varchar2(20),
         classid number(4),
         jointime date
  )
  
  --2课程表 （课程编号，课程名称） （2分）
  create table class_schedule(
         id number(4),
         name varchar2(20)
  )
  
  --3 学员成绩表 （成绩编号，学员编号，课程编号，笔试成绩，机试成绩）（2分）
  create table student_exam(
         examno number(4),
         sid number(4),
         csid number(4),
         written number(3),
         machine number(3)
  )
  
  --4.班级表(班级编号，班级名称)(2分)
  create table class_info(
         id number(4),
         name varchar2(20)
  )
  
  --4向各表插入数据 （2分）
  --学员表
  select * from student;
  insert into student(id,name,classid,jointime) values(1001,'乔峰',1,to_date('2018-01-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(1002,'段誉',null,to_date('2018-01-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(1003,'虚竹',1,to_date('2018-01-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(1004,'扫地僧',1,to_date('2018-01-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(1005,'慕容博',1,to_date('2018-01-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(1006,'慕容复',null,to_date('2018-02-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(1007,'天山童姥',1,to_date('2018-03-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(1008,'李秋水',1,to_date('2018-04-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(1009,'鸠摩智',2,to_date('2018-06-01','yyyy-mm-dd'));
  
  insert into student(id,name,classid,jointime) values(2001,'张无忌',2,to_date('2018-01-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(2002,'赵敏',2,to_date('2018-01-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(2003,'周芷若',2,to_date('2018-01-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(2004,'灭绝师太',2,to_date('2018-01-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(2005,'曾阿牛',2,to_date('2018-01-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(2006,'张三丰',2,to_date('2018-02-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(2007,'张翠山',2,to_date('2018-03-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(2008,'谢逊',2,to_date('2018-04-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(2009,'俞莲舟',2,to_date('2018-06-01','yyyy-mm-dd'));
  commit;
  
  insert into student(id,name,classid,jointime) values(3001,'令狐冲',3,to_date('2018-01-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(3002,'东方不败',3,to_date('2018-01-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(3003,'岳不群',3,to_date('2018-01-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(3004,'林平之',3,to_date('2018-01-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(3005,'桃谷四仙',3,to_date('2018-01-01','yyyy-mm-dd'));
  commit;
  --班级表
  select * from class_info;
  insert into class_info(id,name) values(1,'火箭班');
  insert into class_info(id,name) values(2,'重点班');
  insert into class_info(id,name) values(3,'平行班');
  commit;
  
  --成绩表
  select * from student_exam;
  insert into student_exam(examno,sid,csid,written,machine) values(101,1001,1,100,99);
  insert into student_exam(examno,sid,csid,written,machine) values(102,1002,1,90,89);
  insert into student_exam(examno,sid,csid,written,machine) values(103,1003,1,80,80);
  insert into student_exam(examno,sid,csid,written,machine) values(104,1006,1,70,70);
  insert into student_exam(examno,sid,csid,written,machine) values(105,1007,1,60,60);
  insert into student_exam(examno,sid,csid,written,machine) values(106,1008,1,50,50);
  insert into student_exam(examno,sid,csid,written,machine) values(107,1009,1,30,30);
  insert into student_exam(examno,sid,csid,written,machine) values(108,1010,1,null,null);
  insert into student_exam(examno,sid,csid,written,machine) values(101,1001,2,60,89);
  insert into student_exam(examno,sid,csid,written,machine) values(102,1002,2,60,89);
  insert into student_exam(examno,sid,csid,written,machine) values(103,1003,2,90,80);
  insert into student_exam(examno,sid,csid,written,machine) values(104,1006,2,60,70);
  insert into student_exam(examno,sid,csid,written,machine) values(105,1007,2,40,60);
  insert into student_exam(examno,sid,csid,written,machine) values(106,1008,2,60,50);
  insert into student_exam(examno,sid,csid,written,machine) values(107,1009,2,60,30);
  insert into student_exam(examno,sid,csid,written,machine) values(108,1010,2,null,null);
  commit;
  
  insert into student_exam(examno,sid,csid,written,machine) values(201,2001,1,88,99);
  insert into student_exam(examno,sid,csid,written,machine) values(201,2002,2,45,58);
  insert into student_exam(examno,sid,csid,written,machine) values(202,2003,1,80,79);
  insert into student_exam(examno,sid,csid,written,machine) values(202,2004,2,80,98);
  insert into student_exam(examno,sid,csid,written,machine) values(203,2005,1,78,69);
  insert into student_exam(examno,sid,csid,written,machine) values(203,2006,2,69,59);
  insert into student_exam(examno,sid,csid,written,machine) values(204,2007,1,34,78);
  insert into student_exam(examno,sid,csid,written,machine) values(204,2008,2,45,50);
  commit;
  
  insert into student_exam(examno,sid,csid,written,machine) values(301,3001,1,88,99);
  insert into student_exam(examno,sid,csid,written,machine) values(301,3002,2,46,58);
  insert into student_exam(examno,sid,csid,written,machine) values(302,3003,1,80,79);
  insert into student_exam(examno,sid,csid,written,machine) values(302,3004,2,87,98);
  insert into student_exam(examno,sid,csid,written,machine) values(303,3005,1,68,69);
  insert into student_exam(examno,sid,csid,written,machine) values(303,3006,2,99,89);
  insert into student_exam(examno,sid,csid,written,machine) values(304,3007,1,64,88);
  insert into student_exam(examno,sid,csid,written,machine) values(304,3008,2,45,80);
  commit;
  
  --课程表
  select * from class_schedule;
  insert into class_schedule(id,name) values(1,'Java');
  insert into class_schedule(id,name) values(2,'SQL');
  commit;

  --5 删除没有班级编号的学员信息 （5分）
  delete from student where classid is null;
  commit;
  
  --6 删除没有参加考试的学员信息 （5分）
  delete from student where id in (select sid from student_exam where written is null or machine is null);
  delete from student_exam where written is null or machine is null; 
  commit;

 -- 7 将笔试成绩没有及格的学员机试成绩提高5分 （5分）
  select * from student_exam;
  update student_exam set machine=machine+5 where written<60;
  commit;
 
  --9 查询笔试成绩最高的学员信息包含课程名称 （5分）
  select e1.*,e2.* from 
  (select * from student where id=(
  select e.sid from (select * from student_exam order by written desc) e where rownum=1)) e1 
  ,
    (select * from class_schedule where id=(
  select e.csid from (select * from student_exam order by written desc) e where rownum=1)) e2
  
  --10 查询每个班的总成绩（笔试和机试）和平均成绩（笔试和机试）  （5分)
  select sum(written+machine) 总成绩,avg(written+machine) 平均成绩 from
  (select * from student s,student_exam se,class_info ci where s.id=se.sid and s.classid=ci.id) group by classid;
  
  --11 查询每门课程总成绩（笔试和机试）最高的学员信息 （5分）
  select * from student where id in(
  select sid from student_exam where written+machine in
  (select max(written+machine) from (select s.*,se.* from student s,student_exam se where s.id=se.sid) e group by csid)
  )
  
  --12 查询每个班的总成绩（笔试和机试）第一名的学员信息  （5分）
  select * from student where id in
  (select sid from student_exam where written+machine in (
  select max(written+machine) from (select s.*,se.* from student s,student_exam se where s.id=se.sid) e group by classid))
