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

-----------------------------------------------------------------------------------------
                                   --�򵥲�ѯ                                                                                    
--��ѯ����Ա����Ϣ
select * from emp;
--��ѯ��Ա����ţ�������н��
select empno,ename,sal from emp;
--��ѯ��Ա����ţ�������н�� ��������ʾ����
select empno ���,ename ����,sal н�� from emp;
--��ѯ��Ա����ţ�������н�� ƴ����һ������ʾ:Ա�����:8329,����:dsa,����:3453
select 'Ա�����:'||empno||'��������'||ename||'�����ʣ�'||sal ���� from emp;
--��ѯ30�Ų��ŵ�����Ա��
select * from emp where deptno=30;
--��ѯ��30�Ų�������Ա������Щ������λ:distinctȥ�ظ�
select distinct(job) from emp where deptno=30;
--�����ֶζ��ظ��������ظ�
select distinct * from emp where deptno=30;
--ֻ�й��ʺ͸�λ���ظ���ʱ��������ظ�,���ҽ��ֻ����ʾ���ʺ͸�λ
select distinct sal,job from emp where deptno=30;
--��ѯ��30�Ų���,��λΪSALESMAN��Ա��
select * from emp where deptno=30 and job='SALESMAN';
--��ѯ��������30�Ų��������Ա��
select * from emp where deptno!=30;
select * from emp where deptno<>30;
--��ѯԱ��н�� >=2000 and <=3000 ��Ա��
select ename,sal from emp where sal between  2000 and 3000;
select ename,sal from emp where sal>=2000 and sal<=3000;
--��ѯ��20,30���������Ա����Ϣ
select * from emp where deptno in (20,30);
select * from emp where deptno=20 or deptno=30;
--��ѯ��û���ϼ���Ա����Ϣ
select * from emp where mgr is null;
--��ѯ���ϼ���Ա����Ϣ
select * from emp where mgr is not null;

                               --�߼���ѯ
/*
       ģ��ƥ�䣺like
        %:��ʾƥ��������ַ�
        _:��ʾƥ��һ���ַ�
*/
--��ѯԱ������������S'��Ա��
select ename from emp where ename like '%S%';
--��ѯԱ�������������ַ�Ϊ��C'��Ա��
select ename from emp where ename like '_C%';
--����Ա���Ĺ��ʽ�������:desc����,asc����
select ename,sal from emp order by sal;
select ename,sal from emp order by sal desc;
--��30���ŵ�Ա�������ʽ�������
select ename,sal,deptno from emp where deptno=30 order by sal desc;
/*
�Ӳ�ѯ:sql����Ƕ��,�����sql�����Ӿ�,����Ľ�����,һ��sql����ѯ�����Ľ��������Ϊһ�������,
        ����һ��sql�����Դ�������������ٴβ�ѯ������
        �����Ӳ�ѯ:�Ӿ�ֻ����һ�����
        �����Ӳ�ѯ:�Ӿ䷵�ض�����
����Ӳ�ѯ:�Ӿ��ڲ�ѯ�Ĺ����л��õ������ĳ���ֶ���Ϊ����,����ÿִ��һ����¼,�Ӿ�ͻ�ִ��һ��
������Ӳ�ѯ:�Ӿ�ִֻ��һ��,ִ�н����������ʹ��
*/
--��ѯ����SALES������(dept)�����Ա����Ϣ(emp):��where��������ʹ���Ӳ�ѯ
select * from emp where deptno=(select deptno from dept where dname='SALES');
--�г�н��ȡ�SMITH���������Ա��
select ename,sal from emp where sal>(select sal from emp where ename='SMITH');
--��ѯ����Ա����SCOTT����ͬһ�����ŵ�Ա��
select ename,deptno from emp where deptno=(select deptno from emp where ename='SCOTT') and ename !='SCOTT';
--����Ӳ�ѯ������select��ʹ���Ӳ�ѯ:��ѯ��Ա����ţ�������job��н�ʣ��Լ����ڲ�������
select e.empno Ա�����,e.ename ����,e.job ְλ,e.sal н��,(select d.dname from dept d where d.deptno=e.deptno) �������� from emp e;
--����Ӳ�ѯ:�г�����Ա������������ֱ���ϼ�������
--e1 Ա����,e2 ��˾��
select e1.ename Ա��,(select e2.ename from emp e2 where e2.empno=e1.mgr) ��˾ from emp e1;
--exists :�жϺ�����Ӿ���û�в�ѯ�����,�����ѯ���������true���򷵻�false
--��ѯ����Ա���Ĳ�����Ϣ
select d.* from dept d where exists (select e.ename from emp e where e.deptno=d.deptno);
--��ѯ������Ա���Ĳ�����Ϣ
--not exists:�෴
select d.* from dept d where not exists (select e.ename from emp e where e.deptno=d.deptno);

                 
                                   --������Ӳ�ѯ
/*
������Ӳ�ѯ;������Ҫ�Ľ������������ű������
*/
--�ѿ�����:��һ�ű������ÿһ����¼�͵ڶ��ű��ÿһ����¼����
select * from emp,dept;
--��ֵ���ӣ����������á�=�����й���,������ĵ�ֵ����
--��ѯ�����е�Ա����Ϣ�Լ����ڲ�����Ϣ
select e.*,d.dname,d.loc from emp e,dept d where e.deptno=d.deptno; 
--������:����߱�Ϊ��,����ʾ��߱�������Ϣ,������ұ����й���,��ô��ʾ���������,���û�й�����ô��ʾ��ֵ
select * from emp e left join dept d on e.deptno=d.deptno;
--������
select * from emp e right join dept d on e.deptno=d.deptno;
--ʹ��+�ŵ���������
--+��д�������ʾ������,+��д����߱�ʾ������
--������
select * from emp e,dept d where e.deptno=d.deptno(+);
--������
select * from emp e,dept d where e.deptno(+)=d.deptno;

create table emp1 as select * from emp;
delete from emp where ename='SMITH';
insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno,id) values(1234,'QIAN','BOSS',null,to_date('1999-01-01','yyyy-mm-dd'),1000,null,10,sys_guid());
-- union all  ����������ѯ���������һ���ѯ��ʾ�������ظ���¼
select * from emp union all select * from emp1;
--union  ����������ѯ���������һ���ѯ��ʾ���������ظ���¼
select * from emp union select * from emp1; 
--intersect :��������������ѯ�����ȫ��ͬ�ļ�¼��ѯ��ʾ
select * from emp intersect select * from emp1;
--minus ����������ȥ����Ĳ�ѯ��������Ҽ�ȥ�ཻ�Ľ��
select * from emp minus select * from emp1;

---------------------------------------------------------------------------------------

--���õĺ���                              
                                --�ַ����� 
--lower(��ת�����ַ���):������������ַ�����ת����Сд
select lower('ABCED') from dual;
--upper(��ת�����ַ���):������������ַ�����ת���ɴ�д
select upper('abcde') from dual;
--initCap (��ת�����ַ���)�����ַ�������ĸת���ɴ�д�������ת����Сд
select initCap('i love you') from dual;
--concat(�ַ���1���ַ���2):ֻ��ƴ�������ַ���,���ַ���1���ַ���2�����������һ���µ��ַ���
select concat('hello ','world') from dual;
--instr(�ַ����������ַ�):���ظ��ַ����ַ����еĵ�һ������λ��,�±��1��ʼ
select instr('abcdefg','e') from dual;
--substr(�ַ�������ʼλ�ã�����):��ȡ�ַ���,������ʼ��λ��,�ӿ�ʼλ�ÿ�ʼ��ȡָ��λ�����ַ�
select substr('abcdefg',3,4) from dual;
--32432423@sina.com��ȡsina
select substr('32432423@sina.com',instr('32432423@sina.com','@')+1,instr('32432423@sina.com','.')-instr('32432423@sina.com','@')-1) from dual;
--lpad(�����ַ��������岹���λ��������λ������ָ�����ַ�)������
select lpad('32',4,'##') from dual;
--rpad(�����ַ��������岹���λ��������λ������ָ�����ַ�)���Ҳ���
select rpad('32',4,'##') from dual;
--length�� �����ַ����ĳ���(�ַ�) 2
select length('����') from dual;
--lengthb:�ֽ�      
select lengthb('����') from dual;

                              --���ֺ���
--ceil(������ȡ����ֵ):�컨�� 2
select ceil(1.01) from dual;
--floor(������ȡ����ֵ):�ذ� 1
select floor(1.99) from dual;
--mod (ֵ1��ֵ2):% ȡ�� 1
select mod(10,3) from dual;
--round(�����������ֵ������С�����λ��):
select round(3.1415926,2) from dual;
--trunc(���ضϵ�ֵ������С��λ) 2.5 
select trunc(2.59,1) from dual;

                          --���ں���
--to_date()�ַ���������ת������
select to_date('2019-09-09 20:00','yyyy-mm-dd hh24:mi:ss') from dual;
--add_months(�����ӵ����ڣ�Ҫ���ӵ��·���)���������·���������ڷ���
select add_months(to_date('2019-7-5','yyyy-mm-dd'),5) from dual;
--next_day(ָ��������,���ڼ�)������ָ�����ڵ���һ�������ڼ�
select next_day(sysdate,'������') from dual;
--trunc(ָ��������)/*�ض�ʱ���룬����������*/
select trunc(sysdate) from dual;
--to_char(ָ��������,��ĸ��ʽ):����ָ����ʽ��ʱ����Ϣ
select to_char(sysdate,'yyyy-mm-dd') from dual;
                         
                          --��������
--nvl(ֵ1��ֵ2)�� ���ֵ1Ϊ�գ��򷵻�ֵ2,��֮�򷵻�ֵ1
select empno ���,ename ����,sal+nvl(comm,0) ���� from emp;
--decode(ֵ1��if1,then1,if2,then2,else ):�ж�  ��Ա����н,10������10%,20������20%.....
update emp set sal=sal*decode(deptno,10,1.1,20,1.2,1.3);
select * from emp;
                         --�����Լ��ۺϺ��������ڶ��з���һ�����
--�����е�Ա��ƽ��н��,��߹���,��͹��ʣ��ܹ��ʣ�������
select avg(sal) ƽ��н��,max(sal) ��߹�,min(sal) ��͹���,sum(sal) �ܹ���,count(1) ������ from emp;
--count���н�������:�������Ϊ��һ�ֶ���ô����ֶ�ֵΪnull�Ͳ���
select count(comm) from emp;
--����group by
/*
���������ôselect����ֻ��д�ۺϺ����Լ�����
*/
--���ݲ��ŷ��飬��ѯÿ�����ŵ�ƽ��н��avg()����Сн��min()�����н��max()����н��sum()����������count()
select round(avg(sal),2) ƽ��н��,min(sal) ��Сн��,max(sal) ���н��,sum(sal) ��н��,count(1) �������� from emp group by deptno;
--where���治�ܸ��ۺϺ���,whereֻ������ɸѡ����,�����������ɸѡҪ��having
--ƽ�����ʴ���2000�Ĳ���
select deptno ����,avg(sal) ƽ������ from emp group by deptno having avg(sal)>2000;
--����ƽ�����ʵ�Ա��
select ename ����,sal ����,e.* from emp,(select avg(sal) ƽ������ from emp) e where sal>(select avg(sal) from emp);
--��ѯ10,20���ŵ�Ա����ƽ������,����ƽ������Ҫ����2000
select deptno ����,avg(sal) ƽ������ from emp where deptno in (10,20) group by deptno having avg(sal)>2000 order by avg(sal) desc;
--case when��ϰ
--��Ա����н,10������10%,20������20%....
update emp set sal=sal*(
       case deptno
         when 10 then 1.1
         when 20 then 1.2
         when 30 then 1.3
         when 40 then 1.4
         else 1
       end
);
select * from emp;
--ͳ��ÿ������ÿ����λ������
select distinct job from emp
select deptno,
       count(case job when 'CLERK' then 1 else null end) CLERK,
       count(case job when 'SALESMAN' then 1 else null end) SALESMAN,
       count(case job when 'PRESIDENT' then 1 else null end) PRESIDENT,
       count(case job when 'MANAGER' then 1 else null end) MANAGER,
       count(case job when 'ANALYST' then 1 else null end) ANALYST
from emp group by deptno;


------------------------------------------------------------------------------------------
