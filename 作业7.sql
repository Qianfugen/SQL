select * from emp 

--测试游标
declare

begin
    update emp set sal=5000 where empno in (7782,7788);
    if sql%isopen then
       dbms_output.put_line('游标已打开');
    else
       dbms_output.put_line('游标未打开');
    end if;
    
    if sql%found then
       dbms_output.put_line('执行成功');
    else
       dbms_output.put_line('执行失败');
    end if;
    
    if sql%notfound then 
       dbms_output.put_line('执行失败');
    else
       dbms_output.put_line('执行成功');
    end if;
    
end;

--使用loop循环
declare 
    cursor cs_emp is select * from emp;
    row_emp emp%rowtype;
begin
    open cs_emp;
    loop
         fetch cs_emp into row_emp;
         exit when cs_emp%notfound;
         dbms_output.put_line('loop员工编号：'||row_emp.empno||'，员工姓名:'||row_emp.ename||',员工薪资：'||row_emp.sal);
    end loop;
    close cs_emp;
end;

--使用while循环
declare 
    cursor cs_emp is select * from emp;
    row_emp emp%rowtype; 
begin
    open cs_emp;
    fetch cs_emp into row_emp;
    while cs_emp%found loop
          dbms_output.put_line('while员工编号：'||row_emp.empno||'，员工姓名:'||row_emp.ename||',员工薪资：'||row_emp.sal);
          fetch cs_emp into row_emp;
    end loop;
    close cs_emp;
end;

--使用for循环
declare 
    cursor cs_emp is select * from emp;
    row_emp emp%rowtype;
begin
    for row_emp in cs_emp loop
        dbms_output.put_line('for员工编号：'||row_emp.empno||'，员工姓名:'||row_emp.ename||',员工薪资：'||row_emp.sal);
    end loop;
end;


declare 
    --定义游标类型
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
         dbms_output.put_line('员工编号：'||emp_row.empno||',员工姓名：'||emp_row.ename||',员工薪资：'||emp_row.sal);
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
