--外键:外键必须关联关联表的主键
select * from student
select * from cla
/*
表与表之间的关系
       一对多:例如班级和学生的关系
         一的一方是班级,多的一方就是学生,在多的一方创建外键用来关联一的一方
       多对多:...........
*/
--给学生表添加一个字段,作为关联班级表的外键
alter table student add (claid number(5))
--创建班级表
create table cla(
       id number(5) primary key,
       claid number(5) not null,
       name varchar2(50) not null
)
--给student的claid添加外键,用来关联cla表里面的主键id
alter table student add constraint for_student_cla foreign key(claid) references cla(id)
insert into cla(id,claid,name)values(1,31,'31班');
insert into cla(id,claid,name)values(2,35,'35班');
insert into cla(id,claid,name)values(3,38,'38班');
commit;
insert into student(id,name,age,birdate,claid) values (seq_student.nextval,'cc',33,sysdate,2)
insert into student(id,name,age,birdate,claid) values (seq_student.nextval,'dd',12,sysdate,3)
--删除班级35班:默认删除不成功
delete from cla where id=2
/*
外键级联操作:当我们删除一的一方数据库的时候,多的一方外键字段如何处理
       no action:删除主表中被引用列的数据时，如果子表的引用列中包含该值，则禁止该操作执行
       set null:删除主表中被引用列的数据时，将子表中相应引用列的值设置为NULL值
       cascade:删除主表中被引用列的数据时，级联删除子表中相应的数据行
*/
alter table student drop constraint  for_student_cla;
--添加外键约束,使用 set null级联操作
alter table student add constraint for_student_cla foreign key(claid) references cla(id) on delete cascade
                                   --简单查询  
grant all on scott.dept to java38   
create table dept as select * from scott.dept                                                                                     
--查询所有员工信息
select * from emp
--查询出员工编号，姓名，薪资
--在数据库里面关键字以及字段名称是不区分大小写的,但是字段的值区分大小写
select empno,ename,sal from emp
--查询出员工编号，姓名，薪资 以中文显示列名
select e.empno "员工编号",e.ename "姓名",e.sal "薪资" from emp e
--查询出员工编号，姓名，薪资 拼接在一个列显示:员工编号:8329,姓名:dsa,工资:3453
--在oracle里面的拼接符为:||,在java里面为+
select  '员工编号:'||empno||',姓名:'||ename||',工资:'||sal "详情" from emp
--查询30号部门的所有员工
select * from emp where deptno=30
--查询出30号部门下面员工在那些工作岗位:distinct去重复
select distinct(job) from emp where deptno=30
--所有字段都重复才算是重复
select distinct * from emp where deptno=30
--只有工资和岗位都重复的时候才算是重复,并且结果只会显示工资和岗位
select distinct sal,job from emp where deptno=30
--查询出30号部门,岗位为SALESMAN的员工
select * from emp where deptno=30 and job='SALESMAN'
--查询出不等于30号部门下面的员工
select * from emp where deptno!=30
--查询员工薪资 >=2000 and <=3000 的员工
select * from emp where sal>=2000 and sal<=3000 and deptno=30
select * from emp where sal between 2000 and 3000
--查询出20,30部门下面的员工信息
select * from emp where deptno=20 or deptno=30
select * from emp where deptno in(20,30)
--查询出没有上级的员工信息
--is null:为空,is not null:不为空
select * from emp where mgr is null
--查询有上级的员工信息
select * from emp where mgr is not null
                               --高级查询
/*
       模糊匹配：like
        %:表示匹配任意个字符
        _:表示匹配一个字符
*/
--查询员工姓名包含‘S'的员工
select  * from emp where ename like '%S%'
--查询员工姓名第两个字符为’C'的员工
select  * from emp where ename like '_C%'
--根据员工的工资进行排序:desc倒叙,asc正序
select * from emp order by sal desc,comm
--对30部门的员工按工资进行排序
select * from emp where deptno=30 order by sal desc
/*
子查询:sql语句的嵌套,里面的sql语句叫子句,外面的叫主句,一条sql语句查询出来的结果可以作为一张虚拟表,
        另外一条sql语句可以从这张虚拟表中再次查询出数据
        单行子查询:子句只返回一个结果
        多行子查询:子句只返回多个结果
相关子查询:子句在查询的过程中会拿到主句的某个字段作为条件,主句每执行一条记录,子句就会执行一遍
非相关子查询:子句只执行一次,执行结果交给主句使用
*/
--查询出‘SALES’部门(dept)下面的员工信息(emp):在where条件里面使用子查询
        --根据部门名称查询部门编号
        select deptno from dept where dname='SALES'
        --根据部门编号查询员工信息
        select * from emp where deptno=30
select * from emp where deptno=(select deptno from dept where dname='SALES')
--列出薪金比“SMITH”多的所有员工
select * from emp where sal>(select sal from emp where ename='SMITH')
--查询出和员工‘SCOTT’在同一个部门的员工
select * from emp where deptno in (select deptno from emp where ename='SCOTT') and ename!='SCOTT'
--相关子查询并且在select中使用子查询:查询出员工编号，姓名，job，薪资，以及所在部门名称
select e.empno "编号",e.ename "姓名",e.job "岗位",e.sal "工资",(select d.dname from dept d where d.deptno=e.deptno) "部门" from emp e
--相关子查询:列出所有员工的姓名及其直接上级的姓名
--e1 员工表,e2 上司表
select e1.ename "员工姓名",(select e2.ename from emp e2 where e2.empno=e1.mgr) "直接上司" from emp e1
--exists :判断后面的子句有没有查询出结果,如果查询出结果返回true否则返回false
select d.* from dept d  where not exists (select e.ename from emp e where e.deptno=d.deptno)
--not exists:相反
--查询存在员工的部门信息
