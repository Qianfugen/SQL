--创建表空间
create tablespace pipixia
datafile 'C:\Users\28754\Desktop\tablespace\pipixia.dbf'
size 100M
autoextend on next 100M maxsize unlimited


--丢弃表空间test1及数据文件
drop tablespace test1 including contents and datafiles;

--alter用于表空间，用户，表，触发器，序列。。。
--设置表空间只读
alter tablespace pipixia read only;

--设置表空间可读可写
alter tablespace pipixia read write;

--创建pipixia用户,设置密码和表空间
create user pipixia identified by 123456 default tablespace pipixia;

--grant赋予权限
/*
系统权限：关于用户以及表结构的操作,比如:登录,建表,建过程函数....
对象权限:访问其他用户里面表的时候,该用户对其他用户表的增删查改操作....
*/

--创建会话权限
grant create session to pipixia;
--撤销会话权限
revoke create session from pipixia;

/*
每个角色的权限是独立:需要把CONNECT和RESOURCE两个最基本的权限给一个用户
       CONNECT角色：是授予最终用户的典型权利，最基本的权力，能够连接到ORACLE数据库中，
       并在对其他用户的表有访问权限时，做SELECT、UPDATE、INSERTT,DELETE等操作。
       RESOURCE角色：是授予开发人员的，能在自己的方案中创建 表、序列、视图等。
       DBA：数据库管理员角色，拥有管理数据库的最高权限 
*/
--赋予connect权限
grant connect to pipixia;
--赋予resource权限
grant resource to pipixia;
--赋予dba权限
grant dba to pipixia;

--撤销dba权限
revoke dba from pipixia;

--修改用户密码
alter user pipixia identified by 111111;

--------------------------------------------------------------------------------

--复制scott的emp,dept表到本用户
create table emp as select * from scott.emp;
create table dept as select * from scott.dept;
--只复制scott的bonus表结构到本用户
create table bonus as select * from scott.bonus where 1=2;

--查询表
--查询表所有信息
select * from emp;
select * from bonus;

--删除bonus表
drop table bonus;

/*
常用数据类型:
      字符类型:
          char:固定长度的字符串
          varchar2:可变长度的字符串(4000字节)
          long:可变长字符串，最大长度2GB
       数字类型:
          number:number(2)表示两位整数,number(5,2)有效位数最多5位包括两位小数
       日期:
          DATE:常用日期类型
          TIMESTAMP:时间戳
          
       length:返回字符个数
       lengthb:返回字节个数
*/
--返回字符个数 2
select length('汉字') from dual;
--返回字节个数 4
select lengthb('汉字') from dual;

--创建student表，id,sid,name,age,birdate，设id为主键
create table student(
       id number(4) primary key,
       sid number(4),
       name varchar2(20),
       age number(3),
       birdate date
)
select * from student;

--增加自增序列
create sequence seq_student
       minvalue 1
       maxvalue 9999
       increment by 1;

--创建行级触发器，每添加一列自动添加主键id
create or replace trigger tri_student_primary
before insert on student
for each row
begin
    select seq_student.nextval into :new.id from dual;
end;

--insert 插入数据
insert into student(sid,name,age,birdate) values(1,'ABCDE',22,sysdate);
insert into student(sid,name,age,birdate) values(2,'ABCDF',23,to_date('1997-01-01','yyyy-mm-dd'));

--delete 删除数据
delete from student where sid=1; 

--update 修改数据
update student set name='pipixia' where sid=1;

--select 查询数据
select * from student;

--自动插入100条记录
declare 
       v_i number(3):=1;
begin
       loop
           v_i := v_i+1;
           insert into student(sid,name,age) values(dbms_random.value(1,500),dbms_random.string('u',6),dbms_random.value(10,30));
           exit when v_i>100;
       end loop;
end;

--给表添加注释
comment on table student is '学生表';
--给表字段添加注释
comment on column student.sid is '学号';
comment on column student.name is '姓名';
comment on column student.age is '年龄';
comment on column student.birdate is '生日';
--给表添加字段
alter table student add(sex number);
alter table student add(hobby varchar2(20));
/*
字段名称,类型,长度要在建表的时候确定下来
*/
--修改sex数据长度
alter table student modify(sex number(1));

--修改列名
select * from student where 1=2;
alter table student rename column birdate to birthday;

------------------------------------------------------------------------------
/*
数据定义语言（DDL）:CREATE,ALERT,DROP,TRUNCATE
数据操纵语言（DML）:INSERT,UPDATE,DELETE,SELECT
事务控制语言（TCL）:COMMIT,SAVEPOINT,ROLLBACK
数据控制语言（DCL）:GRANT,REVOKE
*/

/*
主键生成的两种策略:
      序列:让主键自增
      随机:随机生成32位字符串
*/
--随机:随机生成32位字符串
select sys_guid() from dual;

/*
约束:
       主键约束Primary Key:唯一并且不为空,主要为了确保该条数据在表中有一个唯一的标识
       唯一unique:要求该列唯一，允许为空
       检查约束check:用来确保数据符合要求
       外键约束foreign key:用来关联其他表
       非空约束not null:不能为空
*/
/*
主键约束:一般情况下每张表都有会一个id字段用来标识主键,那么id这个字段对于表的数据来说是没有其他作用的
       只是用来标识这行数据唯一的
主键可以作用于一个字段,也可多个字段作为联合主键
*/

               --给emp表添加id字段，并填充数据,使用sys_guid()
--修改id字段               
alter table emp modify(id varchar2(32));
--查询emp表    
select * from emp;

--添加Id字段
alter table emp add(id number(5));
--使用游标填充数据
declare 
      --自定义动态游标类型
      type emp_cur_type is ref cursor return emp%rowtype;
      --定义游标变量
      emp_cur emp_cur_type;
      --定义行变量
      emp_row emp%rowtype;
begin
      open emp_cur for select * from emp;
      loop
           fetch emp_cur into emp_row;
           exit when emp_cur%notfound;
           update emp set id=sys_guid();
           dbms_output.put_line('员工姓名：'||emp_row.ename||',      薪资：'||emp_row.sal);
      end loop;
end;


--主键约束
alter table emp add constraint pk_emp_id primary key(id);

--先解除主键约束
alter table emp drop constraint pk_emp_id;
--联合约束
alter table emp add constraint pk_emp_id primary key(id,empno);

--唯一约束:可以为空但是不能重复
alter table emp add constraint uniq_emp_name unique(ename);
update emp set ename='ALLEN' where empno=7369;

--检查约束:
alter table emp add constraint ch_emp_sal check(sal>100 and sal <10000);
update emp set sal=12000 where empno=7369;



