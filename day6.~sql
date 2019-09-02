--plsql:过程化sql语句
declare
  --可以用来声明变量
  /*
  普通变量:
  字段类型变量:
  行类型变量:
  */
  /*
    :=:赋值运算符
    ||:拼接符
  */
  --普通变量:变量的名称是v_sal数据类型是number,长度是5,默认的初始值是3000
  v_sal number(5):=3000;
begin
  --过程的主体
  select sal into v_sal from emp where empno=7782;
  dbms_output.put_line(v_sal);--往控制台输出一句话
end;

--定义字段类型变量
declare
  v_sal emp.sal%type;
begin
  select sal into v_sal from emp where empno=7782;
  dbms_output.put_line(v_sal);--往控制台输出一句话
end;

--定义行类型变量
declare
  row_emp emp%rowtype;
begin
  select * into row_emp from emp where empno=7782;
  dbms_output.put_line('员工编号:'||row_emp.empno||'员工姓名:'||row_emp.ename||',薪资:'||row_emp.sal);
end;
--if:如果7788的工资大于3000,奖金加300,大于2000加200,大于1000加100
declare 
  v_sal emp.sal%type;
begin
  --查询7782的薪资并且赋值给v_sal变量
  select sal into v_sal from emp where empno=7782;
  if v_sal>3000 then--if(){}
     update emp set comm=nvl(comm,0)+300 where empno=7782;
  elsif  v_sal>2000 then
     update emp set comm=nvl(comm,0)+200 where empno=7782;
  elsif  v_sal>1000 then
     update emp set comm=nvl(comm,0)+100 where empno=7782;
  end if;
  commit;
end;

--循环结构
  --loop
declare 
  v_i number(2):=0;
begin
  dbms_output.put_line('循环开始');
  loop  
      /*
      exit:退出循环
      continue:跳过本次循环
      */
      --i自增
      v_i:=v_i+1;
      exit when v_i>10; 
      if v_i=4 then
         --continue;--跳过本次循环
         --return;结束整个程序
         goto ok;
      end if; 
      dbms_output.put_line('当前的i:'||v_i);
  end loop;
  <<ok>>
  dbms_output.put_line('循环结束'); 
end;

--while循环结构
declare 
  v_i number(2):=1;
begin
  while v_i<=10 loop
        dbms_output.put_line('当前的i:'||v_i);
        v_i:=v_i+1;
  end loop;
end;

--for循环
declare 
begin
  for v_i in 1..10 loop
      dbms_output.put_line('for当前的i:'||v_i);
  end loop;
end;

--根据入职年限做一下处理:大于38年的删除,大于20年加薪资1000,大于10年的加500

--循环:九九乘法表

--for循环
declare 
begin
  for v_i in 1..9 loop
      for v_y in 1..v_i loop
          dbms_output.put(v_y||'*'||v_i||'='||(v_y*v_i)||'   ');
      end loop;  
           dbms_output.new_line();
  end loop;
end;

--异常处理
declare 
  v_sal emp.sal%type;
begin
  select sal into v_sal from emp where deptno=30;
  exception--相当于java里面的try
         when TOO_MANY_ROWS then
              dbms_output.put_line('返回多个值');  
  dbms_output.put_line('-----------------');  
end;
--使用others处理所有异常
declare
begin
  update emp set deptno=60 where empno=7782;
  exception 
         when others then
              dbms_output.put_line('出现异常'); 
end;

--自定义异常名称,绑定异常编码
--https://www.cnblogs.com/lonelywolfmoutain/p/4234325.html
declare
  --自定义异常名称
  no_deptno_id exception;
  --将自定义异常名称和异常编号绑定
  pragma exception_init(no_deptno_id,-02291);
begin
  update emp set deptno=60 where empno=7782;
  exception 
         when no_deptno_id then
            dbms_output.put_line('没有改部门编号');   
end;
--游标,事务(ACID),锁




