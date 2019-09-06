
--һ������� ���ܷ�50�֣�
--1������һ����ʦ����������ʦ��š��������Ա�н�ʡ����֤�š�������λ�����ű�ţ�������һ�Ų��ű����������ű�š��������ơ�������������2�֣�

--����һ����ʦ��
create table teacher(
       id number(4),
       name varchar2(20),
       sex char(2),
       sal number(5),
       card varchar2(18),
       job varchar2(20),
       deptno number(2)           
)
--����һ�Ų��ű�
create table dept(
       deptno number(2),
       dname varchar2(20),
       dinfo varchar(50)
)
--��Ӳ�������
comment on table dept is '���ű�';
comment on column dept.deptno is '���ű��';
comment on column dept.dname is '��������';
comment on column dept.dinfo is '��������';
--2��Ϊ��ʦ����ֶ����Լ������ʦ��ţ�����Լ�������Ա𣨼��Լ����ֻ�����С�Ů�������֤���루ΨһԼ���������ű�ţ����Լ�������ò��ű�Ĳ��ű�ţ���3�֣�
--����Լ��
alter table teacher add constraint pk_teacher_primary primary key(id);
alter table dept add constraint pk_dept_primary primary key(deptno);
--���Լ��
alter table teacher add constraint ch_teacher_sex check(sex='��' or sex='Ů');
--ΨһԼ��
alter table teacher add constraint uniq_teacher_card unique(card);
--���Լ��
alter table teacher add constraint fk_teacher_dept foreign key(deptno) references dept(deptno);

--3���޸ı�ṹ��Ϊ��ʦ����������У�ɾ�����ű��еĲ��������У�2�֣�
--���������
alter table teacher add(age number(3));
select * from teacher;
--ɾ�����ű��еĲ���������
alter table dept drop column dinfo;
select * from dept;

--4����дSQL��䣺��3�֣�
--a.�����ű����3�����ݷֱ��ǣ���ѧ�����г����������� 
insert into dept(deptno,dname) values(10,'��ѧ��');
insert into dept(deptno,dname) values(20,'�г���');
insert into dept(deptno,dname) values(30,'������');
commit;
--b.����ʦ�����6�����ݣ��ֱ����ڽ�ѧ�����г�����������
--������������
create sequence seq_teacher
       minvalue 1
       maxvalue 999
       increment by 1;
--����������
create or replace trigger tri_teacher_id
before insert on teacher
for each row
begin
       select seq_teacher.nextval into :new.id from dual;
end;
--����6������
insert into teacher(name,sex,sal,card,job,deptno,age) values('Ǯһ','��',55800,'330621199805068913','��ѧ',10,26);
insert into teacher(name,sex,sal,card,job,deptno,age) values('����','��',63300,'330621199705158913','�з�',10,21);
insert into teacher(name,sex,sal,card,job,deptno,age) values('����','Ů',44800,'330621199406028919','��ѧ',20,24);
insert into teacher(name,sex,sal,card,job,deptno,age) values('����','��',64800,'330621199205068513','�з�',20,26);
insert into teacher(name,sex,sal,card,job,deptno,age) values('����','��',71800,'330621199204068913','�з�',30,26);
insert into teacher(name,sex,sal,card,job,deptno,age) values('����','Ů',25800,'330621199005068913','��ѧ',30,29);
commit;
select * from teacher;

--5����дSQL��䣺��ѯ��ʦ������н�ʣ�Ҫ��ȥ���ظ����ݣ�2�֣�
select distinct name,sal from teacher;

--6����ѯн����[10000,60000����Ů��ʦ��3�֣�
select * from teacher where sal>=10000 and sal<60000 and sex='Ů';

--7����ѯ����Ϊ��������ʦ��š��Ա�н�ʣ���ѯ���ĸ��ֶ���Ҫȡ������2�֣�
select id ���,sex �Ա�,sal н�� from teacher where name='����';

--8����ѯ���ŵ���ʦ��Ϣ��3�֣�
select * from teacher where name like '��%';

--9����ѯ�����а����ŵ���ʦ��Ϣ��2�֣�
select * from teacher where name like '%��%';

--10������һ�ű���ṹ����ʦ��һ�£����´������ı�������ݣ�������Դ����ʦ��3�֣�
create table teacher_copy as select * from teacher;

--11����ѯ��ʦ����������ݣ���н�ʽ���2�֣�
select * from teacher order by sal desc;

--12���޸���ʦ����������н��Ϊ50000���Ա�ΪŮ��3�֣�
update teacher set sal=50000,sex='Ů' where name='����';
commit;

--13����ѯ���ű��в�������Ϊ�յ����ݣ�2�֣�
insert into dept(deptno) values(40);
commit;
select * from dept where dname is null;

--14����ѯ��ʦ�����Ա𲻵����У�н��С��50000�����ݣ�3�֣�
select * from teacher where sex!='��' and sal<50000;

--15����ѯ������λΪ��ѧ���з�����ʦ���ݣ�2�֣�
select * from teacher where job in('��ѧ','�з�');

--16��ɾ����ʦ������Ϊ���������ĵ����ݣ�3�֣�
delete from teacher where name in('����','����');
commit;

--17��ɾ����ʦ�������е����ݣ�Ҫ����delete��truncate������ʽɾ����3�֣�
--ʹ��delete
delete from teacher where 1=1;
commit;
--ʹ��truncate
truncate table teacher;

--18��ɾ����ʦ��Ͳ��ű�2�֣�
drop table teacher;
drop table dept;

--19����ѯ�ճ£�н�ʴ���20000������ʦ��2�֣�
select * from teacher where name like '��%' and sal>20000;

--20����ѯ�����������Ա����Ϣ�Ĳ��ţ�3�֣�
select distinct d.* from dept d,teacher t where d.deptno=t.deptno;


--��������� ���ܷ�50�֣�
  --��Ʊ�
  --1ѧԱ�� ��ѧԱ��ţ�ѧԱ������ѧԱ�༶��ţ�ѧԱ��ѧʱ�䣩 ��2�֣� 
  create table student(
         id number(4),
         name varchar2(20),
         classid number(4),
         jointime date
  )
  
  --2�γ̱� ���γ̱�ţ��γ����ƣ� ��2�֣�
  create table class_schedule(
         id number(4),
         name varchar2(20)
  )
  
  --3 ѧԱ�ɼ��� ���ɼ���ţ�ѧԱ��ţ��γ̱�ţ����Գɼ������Գɼ�����2�֣�
  create table student_exam(
         examno number(4),
         sid number(4),
         csid number(4),
         written number(3),
         machine number(3)
  )
  
  --4.�༶��(�༶��ţ��༶����)(2��)
  create table class_info(
         id number(4),
         name varchar2(20)
  )
  
  --4������������ ��2�֣�
  --ѧԱ��
  select * from student;
  insert into student(id,name,classid,jointime) values(1001,'�Ƿ�',1,to_date('2018-01-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(1002,'����',null,to_date('2018-01-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(1003,'����',1,to_date('2018-01-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(1004,'ɨ��ɮ',1,to_date('2018-01-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(1005,'Ľ�ݲ�',1,to_date('2018-01-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(1006,'Ľ�ݸ�',null,to_date('2018-02-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(1007,'��ɽͯ��',1,to_date('2018-03-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(1008,'����ˮ',1,to_date('2018-04-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(1009,'�Ħ��',2,to_date('2018-06-01','yyyy-mm-dd'));
  
  insert into student(id,name,classid,jointime) values(2001,'���޼�',2,to_date('2018-01-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(2002,'����',2,to_date('2018-01-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(2003,'������',2,to_date('2018-01-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(2004,'���ʦ̫',2,to_date('2018-01-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(2005,'����ţ',2,to_date('2018-01-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(2006,'������',2,to_date('2018-02-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(2007,'�Ŵ�ɽ',2,to_date('2018-03-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(2008,'лѷ',2,to_date('2018-04-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(2009,'������',2,to_date('2018-06-01','yyyy-mm-dd'));
  commit;
  
  insert into student(id,name,classid,jointime) values(3001,'�����',3,to_date('2018-01-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(3002,'��������',3,to_date('2018-01-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(3003,'����Ⱥ',3,to_date('2018-01-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(3004,'��ƽ֮',3,to_date('2018-01-01','yyyy-mm-dd'));
  insert into student(id,name,classid,jointime) values(3005,'�ҹ�����',3,to_date('2018-01-01','yyyy-mm-dd'));
  commit;
  --�༶��
  select * from class_info;
  insert into class_info(id,name) values(1,'�����');
  insert into class_info(id,name) values(2,'�ص��');
  insert into class_info(id,name) values(3,'ƽ�а�');
  commit;
  
  --�ɼ���
  select * from student_exam;
  insert into student_exam(examno,sid,csid,written,machine) values(101,1001,1,100,99);
  insert into student_exam(examno,sid,csid,written,machine) values(102,1002,1,90,89);
  insert into student_exam(examno,sid,csid,written,machine) values(103,1003,1,80,80);
  insert into student_exam(examno,sid,csid,written,machine) values(104,1006,1,70,70);
  insert into student_exam(examno,sid,csid,written,machine) values(105,1007,1,60,60);
  insert into student_exam(examno,sid,csid,written,machine) values(106,1008,1,50,50);
  insert into student_exam(examno,sid,csid,written,machine) values(107,1009,1,30,30);
  insert into student_exam(examno,sid,csid,written,machine) values(108,1010,1,null,null);
  insert into student_exam(examno,sid,csid,written,machine) values(101,1001,2,60,89);
  insert into student_exam(examno,sid,csid,written,machine) values(102,1002,2,60,89);
  insert into student_exam(examno,sid,csid,written,machine) values(103,1003,2,90,80);
  insert into student_exam(examno,sid,csid,written,machine) values(104,1006,2,60,70);
  insert into student_exam(examno,sid,csid,written,machine) values(105,1007,2,40,60);
  insert into student_exam(examno,sid,csid,written,machine) values(106,1008,2,60,50);
  insert into student_exam(examno,sid,csid,written,machine) values(107,1009,2,60,30);
  insert into student_exam(examno,sid,csid,written,machine) values(108,1010,2,null,null);
  commit;
  
  insert into student_exam(examno,sid,csid,written,machine) values(201,2001,1,88,99);
  insert into student_exam(examno,sid,csid,written,machine) values(201,2002,2,45,58);
  insert into student_exam(examno,sid,csid,written,machine) values(202,2003,1,80,79);
  insert into student_exam(examno,sid,csid,written,machine) values(202,2004,2,80,98);
  insert into student_exam(examno,sid,csid,written,machine) values(203,2005,1,78,69);
  insert into student_exam(examno,sid,csid,written,machine) values(203,2006,2,69,59);
  insert into student_exam(examno,sid,csid,written,machine) values(204,2007,1,34,78);
  insert into student_exam(examno,sid,csid,written,machine) values(204,2008,2,45,50);
  commit;
  
  insert into student_exam(examno,sid,csid,written,machine) values(301,3001,1,88,99);
  insert into student_exam(examno,sid,csid,written,machine) values(301,3002,2,46,58);
  insert into student_exam(examno,sid,csid,written,machine) values(302,3003,1,80,79);
  insert into student_exam(examno,sid,csid,written,machine) values(302,3004,2,87,98);
  insert into student_exam(examno,sid,csid,written,machine) values(303,3005,1,68,69);
  insert into student_exam(examno,sid,csid,written,machine) values(303,3006,2,99,89);
  insert into student_exam(examno,sid,csid,written,machine) values(304,3007,1,64,88);
  insert into student_exam(examno,sid,csid,written,machine) values(304,3008,2,45,80);
  commit;
  
  --�γ̱�
  select * from class_schedule;
  insert into class_schedule(id,name) values(1,'Java');
  insert into class_schedule(id,name) values(2,'SQL');
  commit;

  --5 ɾ��û�а༶��ŵ�ѧԱ��Ϣ ��5�֣�
  delete from student where classid is null;
  commit;
  
  --6 ɾ��û�вμӿ��Ե�ѧԱ��Ϣ ��5�֣�
  delete from student where id in (select sid from student_exam where written is null or machine is null);
  delete from student_exam where written is null or machine is null; 
  commit;

 -- 7 �����Գɼ�û�м����ѧԱ���Գɼ����5�� ��5�֣�
  select * from student_exam;
  update student_exam set machine=machine+5 where written<60;
  commit;
 
  --9 ��ѯ���Գɼ���ߵ�ѧԱ��Ϣ�����γ����� ��5�֣�
  select e1.*,e2.* from 
  (select * from student where id=(
  select e.sid from (select * from student_exam order by written desc) e where rownum=1)) e1 
  ,
    (select * from class_schedule where id=(
  select e.csid from (select * from student_exam order by written desc) e where rownum=1)) e2
  
  --10 ��ѯÿ������ܳɼ������Ժͻ��ԣ���ƽ���ɼ������Ժͻ��ԣ�  ��5��)
  select sum(written+machine) �ܳɼ�,avg(written+machine) ƽ���ɼ� from
  (select * from student s,student_exam se,class_info ci where s.id=se.sid and s.classid=ci.id) group by classid;
  
  --11 ��ѯÿ�ſγ��ܳɼ������Ժͻ��ԣ���ߵ�ѧԱ��Ϣ ��5�֣�
  select * from student where id in(
  select sid from student_exam where written+machine in
  (select max(written+machine) from (select s.*,se.* from student s,student_exam se where s.id=se.sid) e group by csid)
  )
  
  --12 ��ѯÿ������ܳɼ������Ժͻ��ԣ���һ����ѧԱ��Ϣ  ��5�֣�
  select * from student where id in
  (select sid from student_exam where written+machine in (
  select max(written+machine) from (select s.*,se.* from student s,student_exam se where s.id=se.sid) e group by classid))
