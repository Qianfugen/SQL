/*
  表空间：用来存储该用户存到数据库里的数据，表创建的时候使用system登录
*/
create tablespace pipixia
datafile 'C:\Users\28754\Desktop\tablespace\pipixia.dbf'
size 10M
autoextend on next 10M maxsize unlimited

--drop用来删除表空间，用户，表，触发器，序列。。。
drop tablespace oracletest
--删除表空间以及数据文件
drop tablespace test1 including contents and datafiles

--alter表空间，用户，表，触发器，序列。。。
--只读
alter tablespace pipixia read only

--可读可写
alter tablespace pipixia read write

--select查询表数据
select * from pipixia

--创建用户
create user pipixia identified by 123456 default tablespace pipixia

/*
系统权限：关于用户以及表结构的操作，比如登录，建表，建过程函数。。。
对象权限：访问其他用户的表的时候，该用户对其他用户表的增删改查操作
*/
--grant赋予权限
grant create session to pipixia

--撤销权限或角色
revoke create session from pipixia

/*
每个角色的权限是独立的：需要把CONNECT和RESOURCE两个最基本的权限给一个用户
CONNECT权限：赋予最终用户的最基本的权利，能够连接到ORACLE数据库中
RESOURCE权限：赋予开发人员的，做 SELECT,UPDATE,INSERT,DELETE等操作
DBA:数据库管理员角色，拥有管理数据库的最高权限
*/

grant CONNECT to pipixia

--修改用户密码
alter user pipixia identified by 654321
revoke CONNECT from pipixia





