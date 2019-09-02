--plsql:���̻�sql���
declare
  --����������������
  /*
  ��ͨ����:
  �ֶ����ͱ���:
  �����ͱ���:
  */
  /*
    :=:��ֵ�����
    ||:ƴ�ӷ�
  */
  --��ͨ����:������������v_sal����������number,������5,Ĭ�ϵĳ�ʼֵ��3000
  v_sal number(5):=3000;
begin
  --���̵�����
  select sal into v_sal from emp where empno=7782;
  dbms_output.put_line(v_sal);--������̨���һ�仰
end;

--�����ֶ����ͱ���
declare
  v_sal emp.sal%type;
begin
  select sal into v_sal from emp where empno=7782;
  dbms_output.put_line(v_sal);--������̨���һ�仰
end;

--���������ͱ���
declare
  row_emp emp%rowtype;
begin
  select * into row_emp from emp where empno=7782;
  dbms_output.put_line('Ա�����:'||row_emp.empno||'Ա������:'||row_emp.ename||',н��:'||row_emp.sal);
end;
--if:���7788�Ĺ��ʴ���3000,�����300,����2000��200,����1000��100
declare 
  v_sal emp.sal%type;
begin
  --��ѯ7782��н�ʲ��Ҹ�ֵ��v_sal����
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

--ѭ���ṹ
  --loop
declare 
  v_i number(2):=0;
begin
  dbms_output.put_line('ѭ����ʼ');
  loop  
      /*
      exit:�˳�ѭ��
      continue:��������ѭ��
      */
      --i����
      v_i:=v_i+1;
      exit when v_i>10; 
      if v_i=4 then
         --continue;--��������ѭ��
         --return;������������
         goto ok;
      end if; 
      dbms_output.put_line('��ǰ��i:'||v_i);
  end loop;
  <<ok>>
  dbms_output.put_line('ѭ������'); 
end;

--whileѭ���ṹ
declare 
  v_i number(2):=1;
begin
  while v_i<=10 loop
        dbms_output.put_line('��ǰ��i:'||v_i);
        v_i:=v_i+1;
  end loop;
end;

--forѭ��
declare 
begin
  for v_i in 1..10 loop
      dbms_output.put_line('for��ǰ��i:'||v_i);
  end loop;
end;

--������ְ������һ�´���:����38���ɾ��,����20���н��1000,����10��ļ�500

--ѭ��:�žų˷���

--forѭ��
declare 
begin
  for v_i in 1..9 loop
      for v_y in 1..v_i loop
          dbms_output.put(v_y||'*'||v_i||'='||(v_y*v_i)||'   ');
      end loop;  
           dbms_output.new_line();
  end loop;
end;

--�쳣����
declare 
  v_sal emp.sal%type;
begin
  select sal into v_sal from emp where deptno=30;
  exception--�൱��java�����try
         when TOO_MANY_ROWS then
              dbms_output.put_line('���ض��ֵ');  
  dbms_output.put_line('-----------------');  
end;
--ʹ��others���������쳣
declare
begin
  update emp set deptno=60 where empno=7782;
  exception 
         when others then
              dbms_output.put_line('�����쳣'); 
end;

--�Զ����쳣����,���쳣����
--https://www.cnblogs.com/lonelywolfmoutain/p/4234325.html
declare
  --�Զ����쳣����
  no_deptno_id exception;
  --���Զ����쳣���ƺ��쳣��Ű�
  pragma exception_init(no_deptno_id,-02291);
begin
  update emp set deptno=60 where empno=7782;
  exception 
         when no_deptno_id then
            dbms_output.put_line('û�иĲ��ű��');   
end;
--�α�,����(ACID),��




