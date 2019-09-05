/*
  程序包:类似于java里面的接口
    包的定义:可以定义全局变量,可以定义游标类型,定义存储过程或者函数
*/
create or replace package pack_emp
is
       --声明全局变量
       v_i number(5):=3000;
       --声明游标类型
       type emp_cur_type is ref cursor;
       --声明存储过程
       procedure query_all_emp(emp_cur out emp_cur_type);
       --声明函数
       function add_sal_comm(v_empno emp.empno%type) return emp.sal%type;
end;
/*
  给声明好的包定义编写主体
*/
create or replace package body pack_emp 
is
      --给过程定义主体
      procedure  query_all_emp(emp_cur out emp_cur_type)
      is     
      begin
            open emp_cur for select * from emp;
      end query_all_emp;
      
      --给函数定义主体
      function add_sal_comm(v_empno emp.empno%type) return emp.sal%type
      is
           v_sal emp.sal%type;
      begin
           select (nvl(comm,0)+sal+pack_emp.v_i) into  v_sal from emp where empno=v_empno;
           return v_sal;
      end;
end pack_emp;

select pack_emp.add_sal_comm(empno) from emp;


declare 
       emp_cur pack_emp.emp_cur_type;
       emp_row emp%rowtype;
begin
       pack_emp.query_all_emp(emp_cur);
       loop
               fetch emp_cur into emp_row;
               exit when emp_cur%notfound;
                    dbms_output.put_line(emp_row.ename);
       end loop;
       close emp_cur;
end;

--触发器:发生某些特定操作(insert,delete,update)的时候自动执行的一段业务逻辑
--当我们往bank里面添加数据之前从序列中获取写一个,添加为该数据的主键
create sequence seq_bank
minvalue 1
maxvalue 9999
increment by 1;

--创建主键自动增长的触发器
create or replace trigger tri_bank_primary
--发生添加操作之前
before insert on bank 
--每一插入一条数据触发一次该触发器
for each row
/*
行级触发器,如果不写为语句块级触发器
    行级触发器:每一行操作都会触发
    语句块级触发器:如果同一条sql数据对多行数据造成影响也是触发一次
    
注意事项:
    1. 触发器中不能存在事务相关的操作,并且调用的过程以及方法中也不能存在事务
*/
begin
    select seq_bank.nextval into :new.id from dual;
end;

create or replace trigger tri_emp_test1
after delete on emp
for each row
begin
    dbms_output.put_line('删除数据');
end;
--当我们对emp表发生删除,更新的时候记录操作日志:id,c_type,c_date,c_empno
--创建日志表
create table emp_info(
       id number(5) primary key,
       c_type number(1),
       c_date date,
       c_empno number(5)
)

create sequence seq_emp_info
minvalue 1
maxvalue 99999
increment by 1;

create or replace trigger tri_emp_info
before insert on emp_info
for each row
begin
    select seq_emp_info.nextval into :new.id from dual;
end;

--记录操作日志的触发器
create or replace trigger tri_emp_write_info
after update or delete on emp
for each row
--触发条件
when (old.deptno!=30)
declare
    c_type number(1);
begin
    /*
    1. 如果判断操作类型
    2. 如果获取已经删除的数据
       :new:获取新插入的数据--->insert,update
       :old:获取之的数据---->update,delete
    */
    if updating then 
       c_type:=1;
    elsif deleting then
       c_type:=0;
    end if;
    insert into emp_info(c_type,c_date,c_empno) values(c_type,sysdate,:old.empno);
end;



select * from emp;
select * from emp_info;
update emp set sal=111 where empno=7566;
commit;
delete emp where empno=7369;
delete emp;
delete from bank;
commit;
insert into bank (name,money)values('张三',4444);
commit;
select * from emp;
--索引:B树索引
/*
       1. 主键会默认加上唯一索引 435260
*/
select * from bank where id=435260;-->0.015QQKUBT
select * from bank where name='QQKUBT';-->0.031
--给name添加普通索引
create index index_bank_name on bank(name);
drop index index_bank_name;
select * from bank order by name;
--视图View:把复杂sql语句执行的结果映射成一张虚拟表
select e.empno,e.ename,e.sal,d.dname from emp e,dept d where e.deptno=d.deptno 

create or replace view emp_dept as select e.empno,e.ename,e.sal,d.dname from emp e,dept d where e.deptno=d.deptno with read only;

grant create view to java38;--如果该用户不是dba权限,不能创建视图

select * from emp_dept;

update emp_dept set sal=4 where empno=7839

select * from emp


作业:
       1. 添加员工信息
       2. 通过员工编号增加工资
       3. 通过员工名称修改工资
       4. 通过员工编号查询员工信息
       
       

触发器



索引

视图

优化







表分区





















