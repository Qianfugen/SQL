--练习一：导入数据
--将上机作业中school.dmp文件中的数据导入到数据库中。
--该文件中包含4个表数据，分别是：StudentInfo表，TeacherInfo表，ClassInfo表，StudentExam表。

--练习二：单行函数练习
--1、查询所有学员从入学到今天，一共度过了多少天
select * from studentinfo
select trunc(sysdate-to_date(stujointime),2) 学习天数 from studentinfo
--2、查询每月2号入学的学员信息
select * from studentinfo where to_char(stujointime,'dd')='02'
--3、查询所有学员的毕业日期，假定按每个学员入学时间1年半之后将毕业。
select add_months(to_date(stujointime),18) from studentinfo
--4、查询星期四入学的学员姓名，性别，年龄，班级编号
select * from studentinfo where next_day(stujointime,'星期四')-7=stujointime
--5、查询‘2007-3-10’之前入学的学员信息
select * from studentinfo where stujointime<to_date('2007-03-10','yyyy-mm-dd')
--6、查询所有学员姓名的长度
select length(stuname) from studentinfo
--7、查询身份证中第9，10位为‘89’的学员信息（要求使用字符串函数）
select * from studentinfo where stucard like '________89%'
--8、查询所有班主任的邮箱的用户名
select substr(teacheremail,0,instr(teacheremail,'@')-1) from teacherinfo 
--9、查询所有班主任的邮箱的所属网站
--提示：如果邮箱为qtz@yahoo.com，用户名即qtz，所属网站即yahoo。可先查找出‘@’和‘.’的下标，再截取
select substr(teacheremail,instr(teacheremail,'@')+1,instr(teacheremail,'.')-instr(teacheremail,'@')-1) from teacherinfo
--10、求小于-58.9的最大整数
select floor(-58.9) from dual;
--11、求大于78.8的最小整数
select ceil(78.8) from dual;
--12、求64除以7的余数
select mod(64,7) from dual;
--13、查询所有学员入学时间，要求显示格式为‘2007年03月02日’
select to_char(stujointime,'yyyy')||'年'||to_char(stujointime,'mm')||'月'||to_char(stujointime,'dd')||'日' from studentinfo
--14、查询当前时间，要求显示格式为‘22时57:37’
select to_char(sysdate,'hh24')||'时'||to_char(sysdate,'mi:ss') 北京时间 from dual;
--15、查询2007年入学的学员信息
select * from studentinfo where to_char(stujointime,'yyyy')='2007'
--练习三：分组函数练习
--1、查询所有学员的平均年龄（要求保留两位小数）
select round(avg(stuage),2) 平均年龄 from studentinfo 
--2、查询所有考试的总成绩
select sum(examresult) from studentexam
--3、查询SQL考试的最低分数
select min(examresult) SQL最低分数 from studentexam where examsubject='SQL'
--4、查询Java考试成绩最高的学员姓名
select stuname from studentinfo where stuid=( 
select estuid from studentexam where examresult=(
select max(examresult) from studentexam where examsubject='Java') and examsubject='Java')
--5、查询学员‘火云邪神’一共参加了几次考试
select count(1) from studentexam where estuid=(
select stuid from studentinfo where stuname='火云邪神')
--6、查询各科目的平均成绩
select examsubject 科目,avg(examresult) 平均成绩 from studentexam group by examsubject
--7、查询每个班级学员的最小年龄
select min(stuage) from studentinfo group by sclassid
--8、查询考试不及格的人数
select count(distinct estuid) 不及格的人数 from studentexam  where examresult<60
--9、查询各学员的总成绩，要求筛选出总成绩在140分以上的
select sum(examresult) from studentexam group by estuid having sum(examresult)>140
--10、查询男女学员的平均年龄
select stusex 性别,avg(stuage) 平均年龄 from studentinfo group by stusex 
--11、查询每门功课的平均分，要求显示平均分在80分以上的(包括80分)
select avg(examresult) from studentexam group by examsubject having  avg(examresult)>=80
--12、按班主任姓名分组，查所带班级的总成绩分（假定每个班主任只带一个班级）(提示：4表连接)
select * from teacherinfo;
select * from classinfo;
select * from studentinfo;
select * from studentexam;

select sum(se.examresult) from teacherinfo ti,classinfo ci,studentinfo si,studentexam se 
where ti.teacherid=ci.cteacherid and ci.classid=si.sclassid and si.stuid=se.estuid group by teacherid;
--练习四：分析函数练习
--查询学员成绩，按成绩排序，并计算出名次
--1、要求不论成绩是否相同，名次是连续的序号
select se.*,row_number()over(order by se.examresult desc) from studentexam se
--2、要求成绩相等的排位相同，名次随后跳跃
select se.*,rank()over(order by se.examresult desc) from studentexam se
--3、要求成绩相等的排位相同，名次是连续的
select se.*,dense_rank()over(order by se.examresult desc) from studentexam se
select se.*,rank()over(order by se.examresult desc) from studentexam se
