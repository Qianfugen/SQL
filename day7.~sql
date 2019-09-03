/*
表与表的关系
  一对多:在多的一方建立外键关联一的一方
  多对多:通过中间表维护多对多关系
*/
create table t_user(
       id number(5) primary key,
       user_id number(5),
       name varchar2(50),
       pwd varchar2(32),
       age number(3),
       sex number(1),
       r_id number(5)    
)

create table t_role(
      id number(5) primary key,
      role_id number(5),
      name varchar2(50)
)

alter table t_user add constraint fk_t_user_rid foreign key (r_id) references t_role(id);

create table t_power(
      id number(5) primary key,
      power_id number(5),
      name varchar(50)
)

create table t_role_power(
      id number(5) primary key,
      r_id number(5),
      p_id number(5)
)

select tp.* from t_user tu,t_role tr,t_power tp,t_role_power trp 
       where tu.r_id=tr.id and tr.id=trp.r_id and tp.id=trp.p_id and tu.name='张三'

                                              --游标
/*
   隐式游标:当我们执行DML语句的时候系统会自动的给该语句生成隐式游标,隐式游标的名称固定为sql
   显式游标:
       静态游标:我们在定义游标的时候就已经把数据放到游标里面了
       动态游标(自定义游标):
*/
declare 

begin
       update emp set sal=5000 where empno in (7782,7788);
       --isopen:游标是有开启,对于隐式游标来说都是开启,
       --在隐式游标里一般这个属性是自动打开和关闭的.且任何时候查询都返回False
       if sql%isopen then
          dbms_output.put_line('游标已打开');
       else
          dbms_output.put_line('游标未打开');
       end if;
       --found:对于隐式游标如果执行成功返回true,对于显式游标是判断是有没有下一条
       if sql%found then
          dbms_output.put_line('执行成功');
       else
          dbms_output.put_line('执行失败');
       end if;
       --notfound:对于隐式游标如果执行成功返回false,对于显式游标是判断是有没有下一条
       if sql%notfound then
          dbms_output.put_line('执行失败');
       else
          dbms_output.put_line('执行成功');
       end if;
       --rowcount:返回该条sql语句执行完以后对数据库数据影响的行数
        dbms_output.put_line('影响行数:'||(sql%rowcount));
end;



declare 
        --静态游标
        cursor cs_emp is select e.*,d.loc from emp e ,dept d where e.deptno=d.deptno;
        --定义行变量
        row_emp emp%rowtype;
begin
        --通过循环把游标里面的数据一行一行的取出
        --打开游标
        open cs_emp;
        loop
             --把一条数据放到行变量里面去
             fetch cs_emp into row_emp;
             --当游标里面没有数据退出
             exit when cs_emp%notfound; 
             dbms_output.put_line(row_emp.loc||'loop员工编号:'||row_emp.empno||',员工姓名:'||row_emp.ename||',薪资:'||row_emp.sal);
        end loop;
        --关闭游标
        close cs_emp;  
        --使用while循环遍历游标
        open cs_emp;
        fetch cs_emp into row_emp;
        while cs_emp%found loop
             dbms_output.put_line('while员工编号:'||row_emp.empno||',员工姓名:'||row_emp.ename||',薪资:'||row_emp.sal);
             --把一条数据放到行变量里面去
             fetch cs_emp into row_emp;
        end loop;
        close cs_emp;
        --for循环遍历游标,不需要打开以及关闭游标
        for row_emp in cs_emp loop
            dbms_output.put_line('for员工编号:'||row_emp.empno||',员工姓名:'||row_emp.ename||',薪资:'||row_emp.sal);
        end loop;
        
        if cs_emp%isopen then
          dbms_output.put_line('游标已打开');
        else
          dbms_output.put_line('游标未打开');
        end if;      
end;
--打印每个部门的员工
declare 
        --自定义一个动态游标类型:该游标中只能放emp表的行类型
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
             dbms_output.put_line('loop员工编号:'||emp_row.empno||',员工姓名:'||emp_row.ename||',薪资:'||emp_row.sal);
        end loop;
        close emp_cur;
end;

declare 
        --定义静态游标存放部门信息
        cursor dept_cur is select * from dept;
        --自定义一个动态游标类型:该游标中只能放emp表的行类型
        type emp_cur_type is ref cursor return emp%rowtype;
        --定义游标变量
        emp_cur emp_cur_type;
        --定义行变量
        emp_row emp%rowtype;
        dept_row dept%rowtype;
begin
        open dept_cur;
        loop
             fetch dept_cur into dept_row;
             exit when dept_cur%notfound;
             dbms_output.put_line('部门编号:'||dept_row.deptno||',部门名称:'||dept_row.dname);
             open emp_cur for select * from emp where deptno=dept_row.deptno;
             loop
                  fetch emp_cur into emp_row;
                  exit when emp_cur%notfound;
                  dbms_output.put_line('      员工编号:'||emp_row.empno||',员工姓名:'||emp_row.ename||',薪资:'||emp_row.sal);
             end loop;
             close emp_cur;
        end loop;
        close dept_cur;
end;


--系统动态游标
declare 
        dept_cur sys_refcursor;
        dept_row dept%rowtype;
        emp_row emp%rowtype;
begin
        open dept_cur for select * from dept;
        loop
             fetch dept_cur into dept_row;
             exit when dept_cur%notfound;
             dbms_output.put_line('部门编号:'||dept_row.deptno||',部门名称:'||dept_row.dname);
        end loop;
        close dept_cur;
        
        open dept_cur for select * from emp;
        loop
             fetch dept_cur into emp_row;
             exit when dept_cur%notfound;
             dbms_output.put_line('员工编号:'||emp_row.empno||',员工姓名:'||emp_row.ename||',薪资:'||emp_row.sal);
        end loop;
        close dept_cur;
end;

/*
    事务用来保证一系列的sql语句同时执行成功或者全部执行失败   
    事务四大属性:
        A(Atomicity)原子性:一系列的sql语句组成一个不分割的整体,在执行的时候要么同时执行成功要么同时执行失败
        C(Consistemcy)一致性:满足业务逻辑的一致性
        I(Isolation)隔离性:每个事务操作原则上必须完全隔离
        D(Durability)持久性:事务一旦成功提交,数据就永远保存在数据库中了,不能再变化了
    一个完整的事务步骤:
        第一步:开启事务
        第二步:如果出现异常回滚
        第三步:提交    
    事务并发导致的问题:
        脏读:假如两个事务,第一个事务读取了第二个事务修改但是还没有提交的数据,假如第二个事务回滚,
             那么第一个事务读取到的数据就是临时的无效的
        不可重复读(update):主要是针对一行数据,事务两次查询一个数据结果不一样,原因可能是在两次查询期间有其他事务对其进行操作
        幻读(insert,delete):主要是针对一张表,假如t1查询表中所有人的总工资两次查询的结果不一致,原因可能是在两次查询的过程中其他事务删除或者添加表数据 
    数据库隔离级别:
        读已提交(read commit)默认:只能读取别的事务已经提交的数据,可以避免脏读,但是不可重复读,幻读的情况会发生
        序列化(serializable):一个事务一个事务执行,可以避免任何问题发生,但是效率很低 
*/

create table bank(
       id number(5) primary key,
       name varchar2(50),
       money number(5)   
)

--转账
declare 
       c_i number(1):=0;
begin
       --开启事务
       update bank set money=money-5000 where name='张三';
       savepoint aa;
       --select 10/c_i into c_i from dual;
       update bank set money=money+5000 where name='李四';
       --提交事务
       commit;
       --出现异常回滚
       exception 
              when others then
                   dbms_output.put_line('转账出现异常...');
                   rollback to savepoint aa;--回滚  
                   commit;--回滚到保存点以后可以跟提交             
end;



--数据库锁:https://www.cnblogs.com/zhoading/p/8547320.html






