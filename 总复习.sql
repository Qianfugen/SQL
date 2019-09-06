--������ռ�
create tablespace pipixia
datafile 'C:\Users\28754\Desktop\tablespace\pipixia.dbf'
size 100M
autoextend on next 100M maxsize unlimited


--������ռ�test1�������ļ�
drop tablespace test1 including contents and datafiles;

--alter���ڱ�ռ䣬�û����������������С�����
--���ñ�ռ�ֻ��
alter tablespace pipixia read only;

--���ñ�ռ�ɶ���д
alter tablespace pipixia read write;

--����pipixia�û�,��������ͱ�ռ�
create user pipixia identified by 123456 default tablespace pipixia;

--grant����Ȩ��
/*
ϵͳȨ�ޣ������û��Լ���ṹ�Ĳ���,����:��¼,����,�����̺���....
����Ȩ��:���������û�������ʱ��,���û��������û������ɾ��Ĳ���....
*/

--�����ỰȨ��
grant create session to pipixia;
--�����ỰȨ��
revoke create session from pipixia;

/*
ÿ����ɫ��Ȩ���Ƕ���:��Ҫ��CONNECT��RESOURCE�����������Ȩ�޸�һ���û�
       CONNECT��ɫ�������������û��ĵ���Ȩ�����������Ȩ�����ܹ����ӵ�ORACLE���ݿ��У�
       ���ڶ������û��ı��з���Ȩ��ʱ����SELECT��UPDATE��INSERTT,DELETE�Ȳ�����
       RESOURCE��ɫ�������迪����Ա�ģ������Լ��ķ����д��� �����С���ͼ�ȡ�
       DBA�����ݿ����Ա��ɫ��ӵ�й������ݿ�����Ȩ�� 
*/
--����connectȨ��
grant connect to pipixia;
--����resourceȨ��
grant resource to pipixia;
--����dbaȨ��
grant dba to pipixia;

--����dbaȨ��
revoke dba from pipixia;

--�޸��û�����
alter user pipixia identified by 111111;

--------------------------------------------------------------------------------

--����scott��emp,dept�����û�
create table emp as select * from scott.emp;
create table dept as select * from scott.dept;
--ֻ����scott��bonus��ṹ�����û�
create table bonus as select * from scott.bonus where 1=2;

--��ѯ��
--��ѯ��������Ϣ
select * from emp;
select * from bonus;

--ɾ��bonus��
drop table bonus;

/*
������������:
      �ַ�����:
          char:�̶����ȵ��ַ���
          varchar2:�ɱ䳤�ȵ��ַ���(4000�ֽ�)
          long:�ɱ䳤�ַ�������󳤶�2GB
       ��������:
          number:number(2)��ʾ��λ����,number(5,2)��Чλ�����5λ������λС��
       ����:
          DATE:������������
          TIMESTAMP:ʱ���
          
       length:�����ַ�����
       lengthb:�����ֽڸ���
*/
--�����ַ����� 2
select length('����') from dual;
--�����ֽڸ��� 4
select lengthb('����') from dual;

--����student��id,sid,name,age,birdate����idΪ����
create table student(
       id number(4) primary key,
       sid number(4),
       name varchar2(20),
       age number(3),
       birdate date
)
select * from student;

--������������
create sequence seq_student
       minvalue 1
       maxvalue 9999
       increment by 1;

--�����м���������ÿ���һ���Զ��������id
create or replace trigger tri_student_primary
before insert on student
for each row
begin
    select seq_student.nextval into :new.id from dual;
end;

--insert ��������
insert into student(sid,name,age,birdate) values(1,'ABCDE',22,sysdate);
insert into student(sid,name,age,birdate) values(2,'ABCDF',23,to_date('1997-01-01','yyyy-mm-dd'));

--delete ɾ������
delete from student where sid=1; 

--update �޸�����
update student set name='pipixia' where sid=1;

--select ��ѯ����
select * from student;

--�Զ�����100����¼
declare 
       v_i number(3):=1;
begin
       loop
           v_i := v_i+1;
           insert into student(sid,name,age) values(dbms_random.value(1,500),dbms_random.string('u',6),dbms_random.value(10,30));
           exit when v_i>100;
       end loop;
end;

--�������ע��
comment on table student is 'ѧ����';
--�����ֶ����ע��
comment on column student.sid is 'ѧ��';
comment on column student.name is '����';
comment on column student.age is '����';
comment on column student.birdate is '����';
--��������ֶ�
alter table student add(sex number);
alter table student add(hobby varchar2(20));
/*
�ֶ�����,����,����Ҫ�ڽ����ʱ��ȷ������
*/
--�޸�sex���ݳ���
alter table student modify(sex number(1));

--�޸�����
select * from student where 1=2;
alter table student rename column birdate to birthday;

------------------------------------------------------------------------------
/*
���ݶ������ԣ�DDL��:CREATE,ALERT,DROP,TRUNCATE
���ݲ������ԣ�DML��:INSERT,UPDATE,DELETE,SELECT
����������ԣ�TCL��:COMMIT,SAVEPOINT,ROLLBACK
���ݿ������ԣ�DCL��:GRANT,REVOKE
*/

/*
�������ɵ����ֲ���:
      ����:����������
      ���:�������32λ�ַ���
*/
--���:�������32λ�ַ���
select sys_guid() from dual;

/*
Լ��:
       ����Լ��Primary Key:Ψһ���Ҳ�Ϊ��,��ҪΪ��ȷ�����������ڱ�����һ��Ψһ�ı�ʶ
       Ψһunique:Ҫ�����Ψһ������Ϊ��
       ���Լ��check:����ȷ�����ݷ���Ҫ��
       ���Լ��foreign key:��������������
       �ǿ�Լ��not null:����Ϊ��
*/
/*
����Լ��:һ�������ÿ�ű��л�һ��id�ֶ�������ʶ����,��ôid����ֶζ��ڱ��������˵��û���������õ�
       ֻ��������ʶ��������Ψһ��
��������������һ���ֶ�,Ҳ�ɶ���ֶ���Ϊ��������
*/

               --��emp�����id�ֶΣ����������,ʹ��sys_guid()
--�޸�id�ֶ�               
alter table emp modify(id varchar2(32));
--��ѯemp��    
select * from emp;

--���Id�ֶ�
alter table emp add(id number(5));
--ʹ���α��������
declare 
      --�Զ��嶯̬�α�����
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
           update emp set id=sys_guid();
           dbms_output.put_line('Ա��������'||emp_row.ename||',      н�ʣ�'||emp_row.sal);
      end loop;
end;


--����Լ��
alter table emp add constraint pk_emp_id primary key(id);

--�Ƚ������Լ��
alter table emp drop constraint pk_emp_id;
--����Լ��
alter table emp add constraint pk_emp_id primary key(id,empno);

--ΨһԼ��:����Ϊ�յ��ǲ����ظ�
alter table emp add constraint uniq_emp_name unique(ename);
update emp set ename='ALLEN' where empno=7369;

--���Լ��:
alter table emp add constraint ch_emp_sal check(sal>100 and sal <10000);
update emp set sal=12000 where empno=7369;



