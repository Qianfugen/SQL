--��ѯ��
--��ѯ��������Ϣ
select * from scott.emp
--����scott�û������emp��
create table emp as select * from scott.emp
--���Ʊ�������,ֻ���Ʊ�ṹ
/*
       where:����,ֻ�з���true��ô�Ż᷵�ظ�������
*/
create table emp as select * from scott.emp where 1=2
--ɾ����
drop table emp
--�Ѳ���scott����emp���Ȩ�޸���java38����û�
grant select on scott.emp to java38
grant all on scott.emp to java38
revoke dba from java38
grant connect,resource to java38
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
select lengthb('����') from dual
--create������
/*
       �����varchar2����Ҫ������
*/
drop table student
create table student(
       id number(4) primary key,--���
       name varchar2(8),
       age number(3),
       birdate date
)
--�������insert
insert into student(id,name,age,birdate,birdates) values (1003,'����',22,sysdate,systimestamp);
insert into student(id,name,age,birdate,birdates) values (1004,'����',23,sysdate,systimestamp);
commit;
select * from student
--�������ע��
comment on table student is 'ѧ����'
--�����ֶ����ע��
comment on column student.birdate is 'ѧ����������'
--��������ֶ�
alter table student add(birdates timestamp)
--�޸�����
alter table student rename column name to myname
/*
�ֶ�����,����,����Ҫ�ڽ����ʱ��ȷ������
*/
alter table student modify(myname varchar2(100))
/*
���ݶ������ԣ�DDL��:CREATE,ALERT,DROP,TRUNCATE
���ݲ������ԣ�DML��:INSERT,UPDATE,DELETE,SELECT
����������ԣ�TCL��:COMMIT,SAVEPOINT,ROLLBACK
���ݿ������ԣ�DCL��:GRANT,REVOKE
*/
--insert��������
insert into student(id,age,myname) values (1001,22,'����');
--deleteɾ��
delete from student where id=1004
delete from student
/*
drop��delete����:drop��ѱ������Լ���ṹȫ��ɾ��,deleteֻ��ɾ��������
*/
--update �޸�
update student set myname='����' where id=1003
update student set myname='����',age=88 where id=1003
update student set id=1006 where myname='����'
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
alter table student add constraint pk_student_id primary key (id)
--��������
alter table student add constraint pk_student_id primary key (id,myname)
--ɾ��Լ��
alter table student drop constraint pk_student_id
/*
�������ɵ����ֲ���:
      ����:����������
      ���:�������32λ�ַ���
*/
--��������
create sequence seq_student
     --��Сֵ  
     minvalue 1
     --���ֵ
     maxvalue 9999999
     --����
     increment by 1
     --����
     cache 20;
--���������ó���һ��ֵ
select seq_student.nextval from dual;
--��ѯ��ǰ��ֵ
select seq_student.currval from dual;
insert into student(id,age,name) values(seq_student.nextval,20,'bb');
commit;
--�������32λ������
select sys_guid() from dual;
--ΨһԼ��:����Ϊ�յ��ǲ����ظ�
alter table student add constraint unq_student_name unique (name)
--���Լ��:
alter table student add constraint ch_student_age check(age>0 and age<150)



select * from student












