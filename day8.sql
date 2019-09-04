--存储过程:可以存储在数据库中的过程
--给我一个员工姓名,查询其工资
create or replace procedure query_sal_by_name
(
       /*
       该存储过程需要的参数
                 1. 数据类型:数据库常用的数据类型比如number varchar2 date.....
                 2. 参数类型
                    in:只能用来往存储过程中传入参数
                    out:只能从存储过程中中带出执行过程中产生的结果
                    inout:既能传入又能带出数据
       */
       in_name in emp.ename%type,
       out_sal out emp.sal%type
)
is --或者as
--该部分用来定义存储过程中需要用到的变量
       v_i number(5);
begin
       dbms_output.put_line(out_sal);
       select sal into out_sal from emp where ename=in_name;
end query_sal_by_name;
--调用存储过程必须要使用过程
declare 
    out_sal emp.sal%type:=4444;
begin
    query_sal_by_name('KING',out_sal);
    --dbms_output.put_line(out_sal);
end;


--返回行类型数据:根据用户名查询用户的所有信息
create or replace procedure query_all_by_name
(
       in_name in emp.ename%type,
       row_emp out emp%rowtype
)
is

begin

       select * into row_emp from emp where ename=in_name;
end;
declare 
    row_emp emp%rowtype;
begin
    query_all_by_name('KING',row_emp);
    
    dbms_output.put_line(row_emp.sal);
end;

--根据用户名称模糊查询所有员工信息
create or replace procedure  query_all_by_like
(
       in_name in emp.ename%type,
       cur_emp out sys_refcursor
)
is

begin
       --open cur_emp for select * from emp where ename like concat('%',concat(in_name,'%'));
       open cur_emp for select * from emp where ename like '%'||in_name||'%';
end query_all_by_like;

declare 
    cur_emp sys_refcursor;
    row_emp emp%rowtype;
begin
    query_all_by_like('S',cur_emp);
    loop
            fetch cur_emp into row_emp;
            exit when cur_emp%notfound;      
            dbms_output.put_line(row_emp.sal);
    end loop;
    close cur_emp;
end;
--使用存储实现多条件分页查询


--查询所有员工
create or replace procedure query_all_emp
is
       emp_cur sys_refcursor;
       emp_row emp%rowtype;
begin
       open emp_cur for select * from emp;
       loop
            fetch emp_cur into emp_row;
            exit when emp_cur%notfound;
                 dbms_output.put_line(emp_row.ename);    
       end loop;
       close emp_cur;
end;



declare 

begin
       query_all_emp;
end;



/*
   方法  
       1. 必须要有返回值
       2. 可以直接在sql语句中调用     
       3. 过程可以返回任意数据了下以及任意多的结果,方法同样可以返回任意类型但是只能返回一个结果   
   使用存储过程与函数的原则:
       (1).如果需要返回多个值和不返回值，就使用存储过程；如果只需要返回一个值，就使用函数。
       (2).存储过程一般用于执行一个指定的动作，函数一般用于计算和返回一个值。
       (3).可以在SQL语句内部（如表达式）调用函数来完成复杂的计算问题，但不能调用储存过程。所以这是函数的特色。
   使用存储过程或者函数的优点:
       (1).共同使用的代码可以只需要被编写和测试一次，就可以被需要该代码的任何程序调用
       (2).这种集中编写、集中维护更新、大家共享（或重用）的方法，简化了应用程序的开发和维护，提高效率与性能。
       (3).这种模块化的方法使得一个复杂的问题、大的程序逐步简化成几个简单的、小的程序部分，进行分别编写、调试。因此程序的结构更加清晰、简单、也容易实现。
       (4).可以在各个开发者间提供处理数据、控制流程、提示信息等方面的一致性。
       (5).节省内存空间。它们以一种压缩的形式被储存在外存中，当被调用的时才被放入内存进行处理。并且如果多个用户要执行相同的储存过程或函数时就只需要在内存中加载一个该存储过程或函数。
       (6).提高数据的安全性与完整性。通过把一些对数据的操作放到存储过程或函数中，就可以通过是否授予用户有执行该过程或函数的权限，来限制某些用户对数据进行这些操作
*/
--给我员工编号,返回工资加奖金
create or replace function add_sal_comm
(
       v_empno emp.empno%type
)return emp.sal%type
is
        v_sal_and_comm emp.sal%type;
begin
        select (sal+nvl(comm,0)) into v_sal_and_comm from emp where empno=v_empno;
        return v_sal_and_comm;
end;

--可以在过程中调用
declare
        v_sal_and_comm emp.sal%type; 
begin
        v_sal_and_comm:=add_sal_comm(7782);
        dbms_output.put_line(v_sal_and_comm);
end;
--也可以直接在sql语句中调用
select add_sal_comm(empno) from emp;



create or replace function query_all_emp_fun return sys_refcursor
is
       emp_cur sys_refcursor;
begin
       open emp_cur for select * from emp;
       return emp_cur;
end;



declare
       emp_cur sys_refcursor; 
       emp_row emp%rowtype; 
begin
       emp_cur:=query_all_emp_fun;
       loop
            fetch emp_cur into emp_row;
            exit when    emp_cur%notfound;
            dbms_output.put_line(emp_row.ename);
       end loop;
       close emp_cur;
end;
--多条件分页查询

create or replace procedure query_all_emp_by_fy
(
       v_ename in emp.ename%type,--用于按照姓名模糊查询
       v_start_hiredate in varchar2,--用于按照入职日期查询的开始入职日期
       v_end_hiredate in varchar2,--用于按照入职日期查询的结束入职日期
       v_start_row in number,--本页从第几条开始
       v_end_row in number,--本页到第几条结束 S '%'||'S'||'%'
       v_row_count out number,--返回符合要求的记录总数
       v_emp_cur out sys_refcursor--返回本页数据
)
is
       v_select_emp varchar2(2000);--用来拼接查询该页数据的sql语句
       v_select_emp_count varchar2(2000);--用来拼接查询符合要求记录总数的sql语句
       
       v_select_where varchar2(2000);--应为上面的两条sql语句where条件一样,所以定义为一个变量
begin
       --拼接查询条件
       v_select_where:=' where 1=1 '; 
       if v_ename is not null then
          v_select_where:=v_select_where||' and ename like concat(''%'',concat('''||v_ename||''',''%''))';
       end if;
       if v_start_hiredate is not null then
          v_select_where:=v_select_where||' and hiredate>=to_date('''||v_start_hiredate||''',''yyyy-mm-dd'')';
       end if;
       if v_end_hiredate is not null then
          v_select_where:=v_select_where||' and hiredate<=to_date('''||v_end_hiredate||''',''yyyy-mm-dd'')';
       end if; 
       --拼接查询该页数据的sql语句
       v_select_emp:='select empno,ename,job,mgr,hiredate,sal,comm,deptno from (select e.*,rownum r from (select * from emp '||v_select_where||')e) where r>'||v_start_row||' and r<='||v_end_row;
       --执行该条sql语句包结果给游标
       open v_emp_cur for v_select_emp;
       --拼接查询符合要求记录总数的sql语句
       v_select_emp_count:='select count(*) from emp '||v_select_where;
       --执行sql语句
       execute immediate v_select_emp_count into v_row_count;
end;


declare 
       v_row_count  number;--返回符合要求的记录总数
       v_emp_cur  sys_refcursor ;
       emp_row emp%rowtype;
begin
       query_all_emp_by_fy('S','1981-03-08',null,3,6,v_row_count,v_emp_cur);
       dbms_output.put_line('符合要求的记录总数:'||v_row_count);
       loop
               fetch v_emp_cur into emp_row;
               exit when v_emp_cur%notfound;
                     dbms_output.put_line('用户名:'||emp_row.ename||'入职日期:'||emp_row.hiredate);
       end loop;
      close v_emp_cur;
    
end;

--程序包,触发器,索引,视图,表分区,优化















