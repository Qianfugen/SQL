select * from emp 

--�����α�
declare

begin
    update emp set sal=5000 where empno in (7782,7788);
    if sql%isopen then
       dbms_output.put_line('�α��Ѵ�');
    else
       dbms_output.put_line('�α�δ��');
    end if;
    
    if sql%found then
       dbms_output.put_line('ִ�гɹ�');
    else
       dbms_output.put_line('ִ��ʧ��');
    end if;
    
    if sql%notfound then 
       dbms_output.put_line('ִ��ʧ��');
    else
       dbms_output.put_line('ִ�гɹ�');
    end if;
    
end;

--ʹ��loopѭ��
declare 
    cursor cs_emp is select * from emp;
    row_emp emp%rowtype;
begin
    open cs_emp;
    loop
         fetch cs_emp into row_emp;
         exit when cs_emp%notfound;
         dbms_output.put_line('loopԱ����ţ�'||row_emp.empno||'��Ա������:'||row_emp.ename||',Ա��н�ʣ�'||row_emp.sal);
    end loop;
    close cs_emp;
end;

--ʹ��whileѭ��
declare 
    cursor cs_emp is select * from emp;
    row_emp emp%rowtype; 
begin
    open cs_emp;
    fetch cs_emp into row_emp;
    while cs_emp%found loop
          dbms_output.put_line('whileԱ����ţ�'||row_emp.empno||'��Ա������:'||row_emp.ename||',Ա��н�ʣ�'||row_emp.sal);
          fetch cs_emp into row_emp;
    end loop;
    close cs_emp;
end;

--ʹ��forѭ��
declare 
    cursor cs_emp is select * from emp;
    row_emp emp%rowtype;
begin
    for row_emp in cs_emp loop
        dbms_output.put_line('forԱ����ţ�'||row_emp.empno||'��Ա������:'||row_emp.ename||',Ա��н�ʣ�'||row_emp.sal);
    end loop;
end;


declare 
    --�����α�����
    type emp_cur_type is ref cursor return emp%rowtype;
    --�����α����
    emp_cur emp_cur_type;
    --�����б���
    emp_row emp%rowtype;
begin
    open emp_cur for select * from emp;
    loop
         fetch emp_cur into emp_row;
         exit when emp_cur%notfound;
         dbms_output.put_line('Ա����ţ�'||emp_row.empno||',Ա��������'||emp_row.ename||',Ա��н�ʣ�'||emp_row.sal);
    end loop;
    close emp_cur;
end;



declare 
        --���徲̬�α��Ų�����Ϣ
        cursor dept_cur is select * from dept;
        --�Զ���һ����̬�α�����:���α���ֻ�ܷ�emp���������
        type emp_cur_type is ref cursor return emp%rowtype;
        --�����α����
        emp_cur emp_cur_type;
        --�����б���
        emp_row emp%rowtype;
        dept_row dept%rowtype;
begin
        open dept_cur;
        loop
             fetch dept_cur into dept_row;
             exit when dept_cur%notfound;
             dbms_output.put_line('���ű��:'||dept_row.deptno||',��������:'||dept_row.dname);
             open emp_cur for select * from emp where deptno=dept_row.deptno;
             loop
                  fetch emp_cur into emp_row;
                  exit when emp_cur%notfound;
                  dbms_output.put_line('      Ա�����:'||emp_row.empno||',Ա������:'||emp_row.ename||',н��:'||emp_row.sal);
             end loop;
             close emp_cur;
        end loop;
        close dept_cur;
end;
