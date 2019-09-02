--1.������ռ���ΪstuSpace���ļ������D�̸�Ŀ¼�£���ʼ��СΪ32M�������Զ�������
create tablespace stuSpace
datafile 'C:\stuSpace.dbf'
size 32M
autoextend on next 32M maxsize unlimited


--2.����Oracle�û�

--�û���ΪstuDBA,����Ϊstu
create user stuDBA identified by stu
--����ռ�stuSpace����Ϊ�û�stuDBA��Ĭ�ϱ�ռ�
alter user stuDBA default tablespace stuSpace
--Ϊ�û�stuDBA����DBA��ɫ
grant dba to stuDBA


--ʹ��stuDBA�û���¼������ѧԱ��Ϣ���
create table StudentInfo(
       StuID number(4) not null,
       StuNumber varchar2(10) not null,
       StuName varchar2(32) not null,
       StuAge number(4),
       StuSex varchar2(2) not null,
       StuCard varchar2(2),
       StuJoinTime date not null,
       StuAddress varchar2(50),
       SClassID number(4) 
)
--�������
comment on table studentinfo is 'ѧԱ��Ϣ��';
comment on column studentinfo.stuid is '������¼���';
comment on column studentinfo.stunumber is 'ѧԱѧ��';
comment on column studentinfo.stuname is 'ѧԱ����';
comment on column studentinfo.stuage is 'ѧԱ���䣬������16-35��֮��';
comment on column studentinfo.stusex is 'ѧԱ�Ա�Ĭ��Ϊ���С���ȡֵ��Χ�ڡ��С���Ů��֮��';
comment on column studentinfo.stucard is 'ѧԱ���֤����';
comment on column studentinfo.stujointime is 'ѧԱ��ѧʱ��';
comment on column studentinfo.stuaddress is 'ѧԱ��ͥסַ';
comment on column studentinfo.sclassid is 'ѧԱ���ڰ༶ID�����������ClassInfo�������ClassID'


--�������
alter table studentinfo add constraint pk_studentinfo_id primary key (stuid)

--���Լ��
alter table studentinfo add constraint ch_studentinfo_age check(stuage>=16 and stuage<=35);




--�����༶��Ϣ��
create table classinfo(
       classid number(4) not null,
       classnumber varchar2(20) not null,
       cteacherid number(4) not null,
       classgrade varchar2(2) not null
)

--�������
comment on table classinfo is '�༶��Ϣ��';
comment on column classinfo.classid is '������¼���';
comment on column classinfo.classnumber is '�༶���(����)';
comment on column classinfo.cteacherid is '������ID�����������TeacherInfo�������TeacherID';
comment on column classinfo.classgrade is '�༶�����꼶��Ĭ��Ϊ��S1����ȡֵ��Χ�ڡ�S1������S2������Y2��֮��'

--�������
alter table classinfo add constraint pk_classinfo_id primary key(classid)

--��Ӽ��Լ��

alter table classinfo add constraint ch_classinfo_grade check(classgrade in ('S1','S2','Y2')) 

--ȡ�����Լ��
alter table classinfo drop constraint ch_classinfo_grade

--������
select * from classinfo
insert into classinfo(classid,classnumber,cteacherid,classgrade) values(2,'1',1,'S1')
update classinfo set classgrade='Y2' where classid=1
delete from classinfo
commit

--������������Ϣ��
create table teacherinfo(
       teacherid number(4),
       teachername varchar2(20),
       teachertel varchar2(20),
       teacheremail varchar2(20)
)
--�޸��ֶ����Ͳ�Ϊ��,not null
alter table teacherinfo modify(teacherid number(4) not null)
alter table teacherinfo modify(teachername varchar2(20) not null)

--���������Ϣ
comment on table teacherinfo is '��������Ϣ��';
comment on column teacherinfo.teacherid is '������¼���';
comment on column teacherinfo.teachername is '����������'; 
comment on column teacherinfo.teachertel is '�����ε绰'; 
comment on column teacherinfo.teacheremail is '�������ҩ����@����';


--�������
alter table teacherinfo add constraint pk_teacherinfo_id primary key(teacherid)





--�����ɼ���
create table studentexam(
       examid number(4) not null,
       examnumber varchar2(32) not null,
       estuid number(4) not null,
       examsubject varchar2(20) not null,
       examresult number(3) not null
)

--�������
comment on table studentexam is '�ɼ���';
comment on column studentexam.examid is '������¼���';
comment on column studentexam.examnumber is '���Եı��';
comment on column studentexam.estuid is '����ѧ���������ֶ�';
comment on column studentexam.examsubject is 'ѧ���Ŀ��Կ�Ŀ';
comment on column studentexam.examresult is '���Գɼ�';

--�������
alter table studentexam add constraint pk_studentexam_id primary key(examid)


--�������
--ѧԱ���ڰ༶ID�����������ClassInfo�������ClassID
alter table studentinfo add constraint fk_studentinfo_classinfo foreign key(sclassid) references classinfo(classid) on delete cascade;
--������ID�����������TeacherInfo�������TeacherID
alter table classinfo add constraint fk_classinfo_teacherinfo foreign key(cteacherid) references teacherinfo(teacherid) on delete cascade;



--��һ����ѧԱ��Ϣ����studentinfo��
create sequence seq_student
       minvalue 1
       maxvalue 1000
       increment by 1
       cache 20;

select * from studentinfo
alter table studentinfo modify(stucard varchar2(20))
insert into studentinfo(stuid,stunumber,stuname,stuage,stusex,stucard,stujointime,stuaddress)
values(seq_student.nextval,001,'����а��',18,'��','430105198905022032',date'2007-3-1','��ɳ�п�����');
insert into studentinfo(stuid,stunumber,stuname,stuage,stusex,stucard,stujointime,stuaddress)
values(seq_student.nextval,002,'��������',20,'��','430104198703012011',date'2007-3-10','������̶');
insert into studentinfo(stuid,stunumber,stuname,stuage,stusex,stucard,stujointime,stuaddress)
values(seq_student.nextval,003,'С��ɳ�',18,'��','420106198912064044',date'2007-3-2','�㶫��ɽ');
insert into studentinfo(stuid,stunumber,stuname,stuage,stusex,stucard,stujointime,stuaddress)
values(seq_student.nextval,004,'ӣ��������',18,'Ů','420106198908061085',date'2007-3-6','��ɳ����´��');

--����ʦ��Ϣ����teacherinfo��     
select * from teacherinfo
insert into teacherinfo(teacherid,teachername,teachertel,teacheremail) 
values(001,'������','13907311119','834287832@qq.com');

insert into teacherinfo(teacherid,teachername,teachertel,teacheremail) 
values(002,'������','13907315200','dshjjksa@163.com');



--���༶��Ϣ����classinfo��
create sequence seq_class
       minvalue 1
       maxvalue 1000
       increment by 1
       cache 20;
       
select * from classinfo
select * from teacherinfo
select 
select teacherid from teacherinfo where teachername='������'
insert into classinfo(classid,classnumber,cteacherid,classgrade) 
values(seq_class.nextval,'07034',2,'S1')

select * from studentinfo
update studentinfo set sclassid=1 where stuname='����а��'
update studentinfo set sclassid=1 where stuname='С��ɳ�'


insert into classinfo(classid,classnumber,cteacherid,classgrade)
values(seq_class.nextval,'07038',
(select teacherid from teacherinfo where teachername='������'),'S1')



--��������
select * from teacherinfo
insert into TEACHERINFO (TEACHERID, TEACHERNAME, TEACHERTEL, TEACHEREMAIL)
values (4, '����', '13507458168', 'lb@sina.com');
update teacherinfo set teacheremail='tsz@yahoo.com' where teacherid=1
insert into TEACHERINFO (TEACHERID, TEACHERNAME, TEACHERTEL, TEACHEREMAIL)
values (2, '������', '13907315200', 'qtz@yahoo.com');
commit;




select * from classinfo
insert into CLASSINFO (CLASSID, CLASSNUMBER, CTEACHERID, CLASSGRADE)
values (5, '070315', 4, 'S2');
insert into CLASSINFO (CLASSID, CLASSNUMBER, CTEACHERID, CLASSGRADE)
values (1, '07034', 1, 'S1');
insert into CLASSINFO (CLASSID, CLASSNUMBER, CTEACHERID, CLASSGRADE)
values (2, '07038', 2, 'S1');
commit;


insert into STUDENTINFO (STUID, STUNUMBER, STUNAME, STUAGE, STUSEX, STUCARD, STUJOINTIME, STUADDRESS, SCLASSID)
values (8, '005', '�����', 19, '��', '430106198801010001', to_date('02-03-2007', 'dd-mm-yyyy'), '����ɽˮ����', 1);
insert into STUDENTINFO (STUID, STUNUMBER, STUNAME, STUAGE, STUSEX, STUCARD, STUJOINTIME, STUADDRESS, SCLASSID)
values (9, '006', '��Ʒ�', 20, '��', '430106198701010002', to_date('08-03-2007', 'dd-mm-yyyy'), '��������������', 2);
insert into STUDENTINFO (STUID, STUNUMBER, STUNAME, STUAGE, STUSEX, STUCARD, STUJOINTIME, STUADDRESS, SCLASSID)
values (11, '007', '����', 16, 'Ů', '430120199138380438', to_date('12-03-2007', 'dd-mm-yyyy'), '�����Ѳ����', 5);
insert into STUDENTINFO (STUID, STUNUMBER, STUNAME, STUAGE, STUSEX, STUCARD, STUJOINTIME, STUADDRESS, SCLASSID)
values (12, '008', '����', null, '��', '430122198011111111', to_date('14-03-2007', 'dd-mm-yyyy'), '���ϳ�ɳ', 5);
insert into STUDENTINFO (STUID, STUNUMBER, STUNAME, STUAGE, STUSEX, STUCARD, STUJOINTIME, STUADDRESS, SCLASSID)
values (1, '001', '����а��', 18, '��', '430105198905022032', to_date('01-03-2007', 'dd-mm-yyyy'), '��ɳ�п�����', 1);
insert into STUDENTINFO (STUID, STUNUMBER, STUNAME, STUAGE, STUSEX, STUCARD, STUJOINTIME, STUADDRESS, SCLASSID)
values (2, '002', '��������', 20, '��', '430104198703012011', to_date('10-03-2007', 'dd-mm-yyyy'), '������̶', 2);
insert into STUDENTINFO (STUID, STUNUMBER, STUNAME, STUAGE, STUSEX, STUCARD, STUJOINTIME, STUADDRESS, SCLASSID)
values (4, '003', 'С��ɳ�', 19, '��', '420106198812064044', to_date('02-03-2007', 'dd-mm-yyyy'), '�㶫��ɽ', 1);
insert into STUDENTINFO (STUID, STUNUMBER, STUNAME, STUAGE, STUSEX, STUCARD, STUJOINTIME, STUADDRESS, SCLASSID)
values (6, '004', 'ӣ��������', 18, 'Ů', '420106198908061085', to_date('06-03-2007', 'dd-mm-yyyy'), '��������ɳ����´��', 2);
commit;

insert into STUDENTEXAM (EXAMID, EXAMNUMBER, ESTUID, EXAMSUBJECT, EXAMRESULT)
values (6, 'S1_2007070801', 8, 'SQL', 70);
insert into STUDENTEXAM (EXAMID, EXAMNUMBER, ESTUID, EXAMSUBJECT, EXAMRESULT)
values (7, 'S1_2007070801', 8, 'Java', 78);
insert into STUDENTEXAM (EXAMID, EXAMNUMBER, ESTUID, EXAMSUBJECT, EXAMRESULT)
values (8, 'S1_2007070801', 9, 'SQL', 68);
insert into STUDENTEXAM (EXAMID, EXAMNUMBER, ESTUID, EXAMSUBJECT, EXAMRESULT)
values (9, 'S1_2007070801', 9, 'Java', 85);
insert into STUDENTEXAM (EXAMID, EXAMNUMBER, ESTUID, EXAMSUBJECT, EXAMRESULT)
values (1, 'S1_2007070801', 1, 'SQL', 80);
insert into STUDENTEXAM (EXAMID, EXAMNUMBER, ESTUID, EXAMSUBJECT, EXAMRESULT)
values (2, 'S1_2007070801', 1, 'Java', 56);
insert into STUDENTEXAM (EXAMID, EXAMNUMBER, ESTUID, EXAMSUBJECT, EXAMRESULT)
values (3, 'S1_2007070801', 4, 'SQL', 90);
insert into STUDENTEXAM (EXAMID, EXAMNUMBER, ESTUID, EXAMSUBJECT, EXAMRESULT)
values (4, 'S1_2007070801', 6, 'SQL', 95);
insert into STUDENTEXAM (EXAMID, EXAMNUMBER, ESTUID, EXAMSUBJECT, EXAMRESULT)
values (5, 'S1_2007070801', 6, 'Java', 80);
commit;


