select * from studentinfo
delete from studentinfo where stuid=6
delete from studentinfo where stuid=2
update studentinfo set stunumber='002' where stuid=3
update studentinfo set stunumber='003' where stuid=4
update studentinfo set stunumber='004' where stuid=5


select * from teacherinfo
select * from studentexam
select * from classinfo
--基本查询
--1、查询所有学员信息
select * from studentinfo
--2、查询所有学员的姓名，年龄（要求列名用中文显示）
select stuname "姓名",stuage "年龄" from studentinfo
--3.查询学员的年龄共有哪几种值（要求不计算重复项）
select distinct stuage "年龄" from studentinfo
--4.查询所有女性学员的信息
select * from studentinfo where stusex='女'
--5.查询学号前两个学员的信息（要求使用rownum）

--6.查询学员信息，要求显示效果如下：
select '姓名:'||stuname||',年龄:'||stuage||',家住:'||stuaddress "学员信息" from studentinfo
--7、查询年龄小于20岁，家住长沙的男性学员信息
select * from studentinfo where stuage<20 and stuaddress like '长沙%'
--8.查询年龄在16-18岁(包括16,18岁)的学员信息
select * from studentinfo where stuage between 16 and 18
--9、查询身份证中包含有‘1989’字符的学员信息
select * from studentinfo where stucard like '%1989%'
--10、查询‘2007-3-5’后入学的学员信息
select * from studentinfo where stujointime>date'2007-3-5'
--11、查询邮箱地址为yahoo的班主任信息
select * from teacherinfo
select * from teacherinfo where teacheremail like '%@yahoo%'
--12、查询手机以‘139’开头的班主任信息
select * from teacherinfo where teachertel like '139%'
--13、查询年龄不为空男性学员的学号，姓名，住址
select stunumber,stuname,stuaddress from studentinfo where stuage is not null
--14、查询学号是‘001’,‘003’,‘004’的学员姓名和入学时间
select stuname "姓名",stujointime "入学时间" from studentinfo where stunumber in ('001','003','004')
--15、查询所有学员信息，并按年龄降序排序
select * from studentinfo order by stuage desc
--16、查询所有成绩，按考试分数降序排序，分数相同的，按学员编号升序排序
select * from studentexam order by examresult desc,examid
 

--高级查询
select * from studentinfo
select * from studentexam
select * from teacherinfo
select * from classinfo

update studentexam set estuid=3 where examid=5

--设置外键
alter table studentexam add constraint fk_studentexam_studentinfo foreign key(estuid) references studentinfo(stuid) on delete cascade

--1、查询成绩大于80分的学员姓名和考试科目
select examsubject "科目",(select stuname from studentinfo where stuid=estuid) "姓名" from studentexam where examresult>80
--2、查询所有学员信息，要求显示姓名，学号，考试科目，考试成绩，并按照考试成绩降序和学号升序排序
select si.stuname,si.stunumber,se.examsubject,se.examresult from studentinfo si,studentexam se where si.stuid=se.estuid order by se.examresult desc,si.stunumber
--3、查询每个班所对应的班主任名称，要求显示班级名称和班主任名称
select ci.classnumber,ti.teachername from classinfo ci,teacherinfo ti where ci.cteacherid=ti.teacherid
--4、查询每个班主任所带学员信息，要求显示：班主任姓名，班主任联系电话，班级名称，学员姓名，学员学号。(3表连接)
select * from classinfo
select * from studentinfo
select * from studentexam
select ti.teachername 班主任姓名,ti.teachertel 班主任电话,ci.classnumber 班级名称,si.stuname 学员姓名,si.stunumber 学员学号 from studentinfo si,classinfo ci,teacherinfo ti where ti.teacherid=ci.cteacherid and ci.classid=si.sclassid
--5、查询所有学员信息，按所在班级分组，要求显示班级编号，和该班级考试平均分,并按平均分的降序排序。（3表连接）
select ci.classnumber,avg(se.examresult) from studentexam se,studentinfo si,classinfo ci where ci.classid=si.sclassid and si.stuid=se.estuid group by ci.classnumber order by avg(se.examresult) desc
--6、查询与学员‘火云邪神’属于同一班的学员信息
select * from studentinfo where sclassid=(
select si.sclassid from studentinfo si where si.stuname='火云邪神')
and stuname !='火云邪神'
--7、查询Java考试及格（>=60分）的学员详细信息
select * from studentinfo where stuid in (
select estuid from studentexam where examsubject='Java' and examresult>60)
--8、查询与学员‘孙悟空’属于同一班且年龄相同的学员信息
select * from studentinfo where (sclassid,stuage) in(
select sclassid,stuage from studentinfo where stuname='孙悟空')
and stuname!='孙悟空'
--9、查询年龄最小的三位学员的姓名和家庭住址
select * from (
select stuname,stuaddress,stuage from studentinfo order by stuage) where rownum<=3
--10、查询考试成绩中SQL课程的前三名的成绩信息
select * from(
select * from studentexam where examsubject='SQL' order by examresult desc) where rownum<=3
--11、查询考试成绩中Java课程的第二名的成绩信息
select * from(
select e.*,rownum r from (
select * from studentexam where examsubject='Java' order by examresult desc) e) where r=2
--12、查询学员信息，筛选出第3-4条记录
select * from(
select si.*,rownum r from studentinfo si) where r between 3 and 4
