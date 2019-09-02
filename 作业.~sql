--1.创建表空间名为stuSpace，文件存放于D盘根目录下，初始大小为32M，允许自动增长。
create tablespace stuSpace
datafile 'C:\stuSpace.dbf'
size 32M
autoextend on next 32M maxsize unlimited


--2.创建Oracle用户

--用户名为stuDBA,密码为stu
create user stuDBA identified by stu
--将表空间stuSpace设置为用户stuDBA的默认表空间
alter user stuDBA default tablespace stuSpace
--为用户stuDBA授予DBA角色
grant dba to stuDBA


--使用stuDBA用户登录，创建学员信息表表
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
--添加描述
comment on table studentinfo is '学员信息表';
comment on column studentinfo.stuid is '本条记录编号';
comment on column studentinfo.stunumber is '学员学号';
comment on column studentinfo.stuname is '学员姓名';
comment on column studentinfo.stuage is '学员年龄，必须在16-35岁之间';
comment on column studentinfo.stusex is '学员性别，默认为‘男’，取值范围在‘男’或‘女’之间';
comment on column studentinfo.stucard is '学员身份证号码';
comment on column studentinfo.stujointime is '学员入学时间';
comment on column studentinfo.stuaddress is '学员家庭住址';
comment on column studentinfo.sclassid is '学员所在班级ID，外键，引用ClassInfo表的主键ClassID'


--添加主键
alter table studentinfo add constraint pk_studentinfo_id primary key (stuid)

--检查约束
alter table studentinfo add constraint ch_studentinfo_age check(stuage>=16 and stuage<=35);




--创建班级信息表
create table classinfo(
       classid number(4) not null,
       classnumber varchar2(20) not null,
       cteacherid number(4) not null,
       classgrade varchar2(2) not null
)

--添加描述
comment on table classinfo is '班级信息表';
comment on column classinfo.classid is '本条记录编号';
comment on column classinfo.classnumber is '班级编号(名称)';
comment on column classinfo.cteacherid is '班主任ID，外键，引用TeacherInfo表的主键TeacherID';
comment on column classinfo.classgrade is '班级所在年级，默认为‘S1’，取值范围在‘S1’，‘S2’，‘Y2’之间'

--添加主键
alter table classinfo add constraint pk_classinfo_id primary key(classid)

--添加检查约束

alter table classinfo add constraint ch_classinfo_grade check(classgrade in ('S1','S2','Y2')) 

--取消检查约束
alter table classinfo drop constraint ch_classinfo_grade

--检查测试
select * from classinfo
insert into classinfo(classid,classnumber,cteacherid,classgrade) values(2,'1',1,'S1')
update classinfo set classgrade='Y2' where classid=1
delete from classinfo
commit

--创建班主任信息表
create table teacherinfo(
       teacherid number(4),
       teachername varchar2(20),
       teachertel varchar2(20),
       teacheremail varchar2(20)
)
--修改字段类型不为空,not null
alter table teacherinfo modify(teacherid number(4) not null)
alter table teacherinfo modify(teachername varchar2(20) not null)

--添加描述信息
comment on table teacherinfo is '班主任信息表';
comment on column teacherinfo.teacherid is '本条记录编号';
comment on column teacherinfo.teachername is '班主任姓名'; 
comment on column teacherinfo.teachertel is '班主任电话'; 
comment on column teacherinfo.teacheremail is '邮箱的中药带有@符号';


--添加主键
alter table teacherinfo add constraint pk_teacherinfo_id primary key(teacherid)





--创建成绩表
create table studentexam(
       examid number(4) not null,
       examnumber varchar2(32) not null,
       estuid number(4) not null,
       examsubject varchar2(20) not null,
       examresult number(3) not null
)

--添加描述
comment on table studentexam is '成绩表';
comment on column studentexam.examid is '本条记录编号';
comment on column studentexam.examnumber is '考试的编号';
comment on column studentexam.estuid is '关联学生表的外键字段';
comment on column studentexam.examsubject is '学生的考试科目';
comment on column studentexam.examresult is '考试成绩';

--添加主键
alter table studentexam add constraint pk_studentexam_id primary key(examid)


--设置外键
--学员所在班级ID，外键，引用ClassInfo表的主键ClassID
alter table studentinfo add constraint fk_studentinfo_classinfo foreign key(sclassid) references classinfo(classid) on delete cascade;
--班主任ID，外键，引用TeacherInfo表的主键TeacherID
alter table classinfo add constraint fk_classinfo_teacherinfo foreign key(cteacherid) references teacherinfo(teacherid) on delete cascade;



--将一批新学员信息插入studentinfo中
create sequence seq_student
       minvalue 1
       maxvalue 1000
       increment by 1
       cache 20;

select * from studentinfo
alter table studentinfo modify(stucard varchar2(20))
insert into studentinfo(stuid,stunumber,stuname,stuage,stusex,stucard,stujointime,stuaddress)
values(seq_student.nextval,001,'火云邪神',18,'男','430105198905022032',date'2007-3-1','长沙市开福区');
insert into studentinfo(stuid,stunumber,stuname,stuage,stusex,stucard,stujointime,stuaddress)
values(seq_student.nextval,002,'东方不败',20,'男','430104198703012011',date'2007-3-10','湖南湘潭');
insert into studentinfo(stuid,stunumber,stuname,stuage,stusex,stucard,stujointime,stuaddress)
values(seq_student.nextval,003,'小李飞车',18,'男','420106198912064044',date'2007-3-2','广东佛山');
insert into studentinfo(stuid,stunumber,stuname,stuage,stusex,stucard,stujointime,stuaddress)
values(seq_student.nextval,004,'樱桃肉丸子',18,'女','420106198908061085',date'2007-3-6','长沙市岳麓区');

--将老师信息填入teacherinfo中     
select * from teacherinfo
insert into teacherinfo(teacherid,teachername,teachertel,teacheremail) 
values(001,'唐三藏','13907311119','834287832@qq.com');

insert into teacherinfo(teacherid,teachername,teachertel,teacheremail) 
values(002,'擎天柱','13907315200','dshjjksa@163.com');



--将班级信息填入classinfo中
create sequence seq_class
       minvalue 1
       maxvalue 1000
       increment by 1
       cache 20;
       
select * from classinfo
select * from teacherinfo
select 
select teacherid from teacherinfo where teachername='擎天柱'
insert into classinfo(classid,classnumber,cteacherid,classgrade) 
values(seq_class.nextval,'07034',2,'S1')

select * from studentinfo
update studentinfo set sclassid=1 where stuname='火云邪神'
update studentinfo set sclassid=1 where stuname='小李飞车'


insert into classinfo(classid,classnumber,cteacherid,classgrade)
values(seq_class.nextval,'07038',
(select teacherid from teacherinfo where teachername='唐三藏'),'S1')



--插入数据
select * from teacherinfo
insert into TEACHERINFO (TEACHERID, TEACHERNAME, TEACHERTEL, TEACHEREMAIL)
values (4, '刘备', '13507458168', 'lb@sina.com');
update teacherinfo set teacheremail='tsz@yahoo.com' where teacherid=1
insert into TEACHERINFO (TEACHERID, TEACHERNAME, TEACHERTEL, TEACHEREMAIL)
values (2, '擎天柱', '13907315200', 'qtz@yahoo.com');
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
values (8, '005', '孙悟空', 19, '男', '430106198801010001', to_date('02-03-2007', 'dd-mm-yyyy'), '花果山水帘洞', 1);
insert into STUDENTINFO (STUID, STUNUMBER, STUNAME, STUAGE, STUSEX, STUCARD, STUJOINTIME, STUADDRESS, SCLASSID)
values (9, '006', '大黄蜂', 20, '男', '430106198701010002', to_date('08-03-2007', 'dd-mm-yyyy'), '湖南汽车大世界', 2);
insert into STUDENTINFO (STUID, STUNUMBER, STUNAME, STUAGE, STUSEX, STUCARD, STUJOINTIME, STUADDRESS, SCLASSID)
values (11, '007', '貂蝉', 16, '女', '430120199138380438', to_date('12-03-2007', 'dd-mm-yyyy'), '马王堆博物馆', 5);
insert into STUDENTINFO (STUID, STUNUMBER, STUNAME, STUAGE, STUSEX, STUCARD, STUJOINTIME, STUADDRESS, SCLASSID)
values (12, '008', '关羽', null, '男', '430122198011111111', to_date('14-03-2007', 'dd-mm-yyyy'), '湖南长沙', 5);
insert into STUDENTINFO (STUID, STUNUMBER, STUNAME, STUAGE, STUSEX, STUCARD, STUJOINTIME, STUADDRESS, SCLASSID)
values (1, '001', '火云邪神', 18, '男', '430105198905022032', to_date('01-03-2007', 'dd-mm-yyyy'), '长沙市开福区', 1);
insert into STUDENTINFO (STUID, STUNUMBER, STUNAME, STUAGE, STUSEX, STUCARD, STUJOINTIME, STUADDRESS, SCLASSID)
values (2, '002', '东方不败', 20, '男', '430104198703012011', to_date('10-03-2007', 'dd-mm-yyyy'), '湖南湘潭', 2);
insert into STUDENTINFO (STUID, STUNUMBER, STUNAME, STUAGE, STUSEX, STUCARD, STUJOINTIME, STUADDRESS, SCLASSID)
values (4, '003', '小李飞车', 19, '男', '420106198812064044', to_date('02-03-2007', 'dd-mm-yyyy'), '广东佛山', 1);
insert into STUDENTINFO (STUID, STUNUMBER, STUNAME, STUAGE, STUSEX, STUCARD, STUJOINTIME, STUADDRESS, SCLASSID)
values (6, '004', '樱桃肉丸子', 18, '女', '420106198908061085', to_date('06-03-2007', 'dd-mm-yyyy'), '开福区长沙市岳麓区', 2);
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


