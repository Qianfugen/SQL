--查询表
--查询表所有信息
select * from scott.emp
--复制scott用户下面的emp表
create table emp as select * from scott.emp
--复制表不带数据,只复制表结构
/*
       where:条件,只有返回true那么才会返回该条数据
*/
create table emp as select * from scott.emp where 1=2
--删除表
drop table emp
--把操作scott里面emp表的权限赋予java38这个用户
grant select on scott.emp to java38
grant all on scott.emp to java38
revoke dba from java38
grant connect,resource to java38
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
select lengthb('汉字') from dual
--create创建表
/*
       如果是varchar2必须要赋长度
*/
drop table student
create table student(
       id number(4) primary key,--编号
       name varchar2(8),
       age number(3),
       birdate date
)
--添加数据insert
insert into student(id,name,age,birdate,birdates) values (1003,'李四',22,sysdate,systimestamp);
insert into student(id,name,age,birdate,birdates) values (1004,'王五',23,sysdate,systimestamp);
commit;
select * from student
--给表添加注释
comment on table student is '学生表'
--给表字段添加注释
comment on column student.birdate is '学生出生日期'
--给表添加字段
alter table student add(birdates timestamp)
--修改列名
alter table student rename column name to myname
/*
字段名称,类型,长度要在建表的时候确定下来
*/
alter table student modify(myname varchar2(100))
/*
数据定义语言（DDL）:CREATE,ALERT,DROP,TRUNCATE
数据操纵语言（DML）:INSERT,UPDATE,DELETE,SELECT
事务控制语言（TCL）:COMMIT,SAVEPOINT,ROLLBACK
数据控制语言（DCL）:GRANT,REVOKE
*/
--insert插入数据
insert into student(id,age,myname) values (1001,22,'张三');
--delete删除
delete from student where id=1004
delete from student
/*
drop和delete区别:drop会把表数据以及表结构全部删除,delete只会删除表数据
*/
--update 修改
update student set myname='赵六' where id=1003
update student set myname='李四',age=88 where id=1003
update student set id=1006 where myname='张三'
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
alter table student add constraint pk_student_id primary key (id)
--联合主键
alter table student add constraint pk_student_id primary key (id,myname)
--删除约束
alter table student drop constraint pk_student_id
/*
主键生成的两种策略:
      序列:让主键自增
      随机:随机生成32位字符串
*/
--创建序列
create sequence seq_student
     --最小值  
     minvalue 1
     --最大值
     maxvalue 9999999
     --增量
     increment by 1
     --缓存
     cache 20;
--从序列中拿出下一个值
select seq_student.nextval from dual;
--查询当前的值
select seq_student.currval from dual;
insert into student(id,age,name) values(seq_student.nextval,20,'bb');
commit;
--随机生成32位的主键
select sys_guid() from dual;
--唯一约束:可以为空但是不能重复
alter table student add constraint unq_student_name unique (name)
--检查约束:
alter table student add constraint ch_student_age check(age>0 and age<150)



select * from student












