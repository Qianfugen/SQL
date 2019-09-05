/*
作业:
       1. 添加员工信息
       2. 通过员工编号增加工资
       3. 通过员工名称修改工资
       4. 通过员工编号查询员工信息
*/
--存储过程
create or replace procedure add_emp
(
       emp_empno emp.empno%type,
       emp_ename emp.ename%type,
       emp_job emp.job%type,
       emp_mgr emp.mgr%type,
       emp_hiredate emp.hiredate%type,
       emp_sal emp.sal%type,
       emp_comm emp.comm%type,
       emp_deptno emp.deptno%type
)       
is
begin
       insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno) 
       values(emp_empno,emp_ename,emp_job,emp_mgr,emp_hiredate,emp_sal,emp_comm,emp_deptno); 
end;

select * from emp;


create or replace procedure add_emp
(
       emp_empno emp.empno%type,
       emp_ename emp.ename%type,
       emp_job emp.job%type,
       emp_mgr emp.mgr%type,
       emp_hiredate emp.hiredate%type,
       emp_sal emp.sal%type,
       emp_comm emp.comm%type,
       emp_deptno emp.deptno%type
)       
is
begin
       insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno) 
       values(emp_empno,emp_ename,emp_job,emp_mgr,emp_hiredate,emp_sal,emp_comm,emp_deptno);  
end;

--调用存储过程
declare

begin
     --add_emp(111);
     add_emp(1111,'QIAN','BOSS',7698,to_date('1996-01-01','yyyy-mm-dd'),1200,200,10);  
end;




-------------------------------------------------------------------------------------------------
--使用程序包
create or replace package pack_emp
is
       --1. 添加员工信息
         procedure add_emp(
           emp_empno emp.empno%type,
           emp_ename emp.ename%type,
           emp_job emp.job%type,
           emp_mgr emp.mgr%type,
           emp_hiredate emp.hiredate%type,
           emp_sal emp.sal%type,
           emp_comm emp.comm%type,
           emp_deptno emp.deptno%type
         );
       --2. 通过员工编号增加工资
       --3. 通过员工名称修改工资
       --4. 通过员工编号查询员工信息
end;

/*
  给声明好的包定义编写主体
*/
create or replace package body pack_emp
is
       procedure add_emp(
         emp_empno emp.empno%type,
         emp_ename emp.ename%type,
         emp_job emp.job%type,
         emp_mgr emp.mgr%type,
         emp_hiredate emp.hiredate%type,
         emp_sal emp.sal%type,
         emp_comm emp.comm%type,
         emp_deptno emp.deptno%type
       )
       is
       begin
         insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno) 
         values(emp_empno,emp_ename,emp_job,emp_mgr,emp_hiredate,emp_sal,emp_comm,emp_deptno); 
       end add_emp;
end pack_emp;

declare 
begin
       pack_emp.add_emp(1111,'QIAN','BOSS',7698,to_date('1996-01-01','yyyy-mm-dd'),1200,200,10);
end;
--查询结果
select * from emp;
---------------------------------------------------------------------------------
create or replace package pack_emp
is
       --1. 添加员工信息
       procedure add_emp(emp_empno emp.empno%type);

end;

/*
  给声明好的包定义编写主体
*/
create or replace package body pack_emp
is
       procedure add_emp(
         emp_empno emp.empno%type
       )
       is
       begin
         insert into emp(empno) values(emp_empno); 
       end add_emp;
end pack_emp;

declare 
begin
       pack_emp.add_emp(123);
end;

select * from emp;


---------------------------------------------------------------------------------
create table bank(
       id number(6),
       name varchar2(20),
       money number(5)
)
drop table bank;
alter table bank add constraint pk_bank_id primary key(id)

select * from bank;
insert into bank(id,name,money) values(3,'qianfg',1000)

create sequence seq_bank
       minvalue 1
       maxvalue 999999
       increment by 1;
drop sequence seq_bank
select seq_bank.nextval from dual;
--每一插入一条数据触发一次该触发器
create or replace trigger tri_bank_primary 
before insert on bank
for each row
begin
    select seq_bank.nextval into :new.id from dual;
end;

insert into bank(name,money) values('qianfg',1000)
select * from bank;

--每删除一条数据触发一次该触发器   
create  or replace trigger tri_bank_del
after delete on bank
for each row
begin
    dbms_output.put_line('删除数据');
end;  

delete from bank where id=3;

--当我们对emp表发生删除,更新的时候记录操作日志:id,c_type,c_date,c_empno
--创建日志表
create table emp_info(
       id number(5) primary key,
       c_type number(1),
       c_date date,
       c_empno number(5)
)

--自增序列
create sequence seq_emp_info
       minvalue 1
       maxvalue 99999
       increment by 1;
--插入触发器
create or replace trigger tri_emp_info
before insert on emp_info
for each row
begin
    select seq_emp_info.nextval into :new.id from dual;
end;

--记录操作日志的触发器
create or replace trigger tri_emp_write_info
after update or delete on emp
for  each row
declare 
     c_type number(1);
begin
     if updating then 
        c_type:=1;
     elsif deleting then
        c_type:=0;
     end if;
     insert into emp_info(c_type,c_date,c_empno) values(c_type,sysdate,:old.empno);
end;


--测试
select * from emp;
select * from emp_info;
update emp set sal=1000 where empno=7369;
delete from emp where empno=7499;
delete from emp where empno=7369;


-------------------------------------------------------------------------------
                      --插入500000条数据到bank
--删除之前的bank表
drop table bank;
--删除之前的seq_bank
drop sequence seq_bank;
--新建bank表
create table bank(
       id number(6),
       name varchar2(20),
       money number(5)
)
--添加主键
alter table bank add constraint pk_bank_id primary key(id)
--查询bank表
select * from bank;
--新增自增序列
create sequence seq_bank
       minvalue 1
       maxvalue 999999
       increment by 1;
--每一插入一条数据触发一次该触发器
create or replace trigger tri_bank_primary 
before insert on bank
for each row
begin
    select seq_bank.nextval into :new.id from dual;
end;

--添加500000行数据
declare 
       v_i number(6) := 0;
begin
       dbms_output.put_line('开始时间：'||systimestamp);
       loop
       v_i := v_i+1;
       exit when v_i>500000;
       insert into bank(name,money) values(dbms_random.string('u',6),dbms_random.value(1000,3000));
       commit;
       end loop;
       dbms_output.put_line('结束时间：'||systimestamp);
end;
--查看bank条数
select count(1) from bank;


--查询某条记录
select * from bank where name='ZRGXAZ';


--索引:B树索引

--给name添加普通索引
create index index_bank_name on bank(name);
--丢弃索引
drop index index_bank_name;

select * from bank order by name;

--视图View:把复杂sql语句执行的结果映射成一张虚拟表
select e.empno,e.ename,e.sal,d.dname from emp e,dept d where e.deptno=d.deptno;

create or replace view  emp_dept as select e.empno,e.ename,e.sal,d.dname from emp e,dept d where e.deptno=d.deptno;

select * from emp_dept;
drop view emp_dept;

update emp_dept set sal=1 where empno=7934;

drop view emp_dept;



