/*
��ҵ:
       1. ���Ա����Ϣ
       2. ͨ��Ա��������ӹ���
       3. ͨ��Ա�������޸Ĺ���
       4. ͨ��Ա����Ų�ѯԱ����Ϣ
*/
--�洢����
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

--���ô洢����
declare

begin
     --add_emp(111);
     add_emp(1111,'QIAN','BOSS',7698,to_date('1996-01-01','yyyy-mm-dd'),1200,200,10);  
end;




-------------------------------------------------------------------------------------------------
--ʹ�ó����
create or replace package pack_emp
is
       --1. ���Ա����Ϣ
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
       --2. ͨ��Ա��������ӹ���
       --3. ͨ��Ա�������޸Ĺ���
       --4. ͨ��Ա����Ų�ѯԱ����Ϣ
end;

/*
  �������õİ������д����
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
--��ѯ���
select * from emp;
---------------------------------------------------------------------------------
create or replace package pack_emp
is
       --1. ���Ա����Ϣ
       procedure add_emp(emp_empno emp.empno%type);

end;

/*
  �������õİ������д����
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
--ÿһ����һ�����ݴ���һ�θô�����
create or replace trigger tri_bank_primary 
before insert on bank
for each row
begin
    select seq_bank.nextval into :new.id from dual;
end;

insert into bank(name,money) values('qianfg',1000)
select * from bank;

--ÿɾ��һ�����ݴ���һ�θô�����   
create  or replace trigger tri_bank_del
after delete on bank
for each row
begin
    dbms_output.put_line('ɾ������');
end;  

delete from bank where id=3;

--�����Ƕ�emp����ɾ��,���µ�ʱ���¼������־:id,c_type,c_date,c_empno
--������־��
create table emp_info(
       id number(5) primary key,
       c_type number(1),
       c_date date,
       c_empno number(5)
)

--��������
create sequence seq_emp_info
       minvalue 1
       maxvalue 99999
       increment by 1;
--���봥����
create or replace trigger tri_emp_info
before insert on emp_info
for each row
begin
    select seq_emp_info.nextval into :new.id from dual;
end;

--��¼������־�Ĵ�����
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


--����
select * from emp;
select * from emp_info;
update emp set sal=1000 where empno=7369;
delete from emp where empno=7499;
delete from emp where empno=7369;


-------------------------------------------------------------------------------
                      --����500000�����ݵ�bank
--ɾ��֮ǰ��bank��
drop table bank;
--ɾ��֮ǰ��seq_bank
drop sequence seq_bank;
--�½�bank��
create table bank(
       id number(6),
       name varchar2(20),
       money number(5)
)
--�������
alter table bank add constraint pk_bank_id primary key(id)
--��ѯbank��
select * from bank;
--������������
create sequence seq_bank
       minvalue 1
       maxvalue 999999
       increment by 1;
--ÿһ����һ�����ݴ���һ�θô�����
create or replace trigger tri_bank_primary 
before insert on bank
for each row
begin
    select seq_bank.nextval into :new.id from dual;
end;

--���500000������
declare 
       v_i number(6) := 0;
begin
       dbms_output.put_line('��ʼʱ�䣺'||systimestamp);
       loop
       v_i := v_i+1;
       exit when v_i>500000;
       insert into bank(name,money) values(dbms_random.string('u',6),dbms_random.value(1000,3000));
       commit;
       end loop;
       dbms_output.put_line('����ʱ�䣺'||systimestamp);
end;
--�鿴bank����
select count(1) from bank;


--��ѯĳ����¼
select * from bank where name='ZRGXAZ';


--����:B������

--��name�����ͨ����
create index index_bank_name on bank(name);
--��������
drop index index_bank_name;

select * from bank order by name;

--��ͼView:�Ѹ���sql���ִ�еĽ��ӳ���һ�������
select e.empno,e.ename,e.sal,d.dname from emp e,dept d where e.deptno=d.deptno;

create or replace view  emp_dept as select e.empno,e.ename,e.sal,d.dname from emp e,dept d where e.deptno=d.deptno;

select * from emp_dept;
drop view emp_dept;

update emp_dept set sal=1 where empno=7934;

drop view emp_dept;



