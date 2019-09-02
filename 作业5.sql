--关于员工表的普通查询
--1.找出EMP表中的姓名（ENAME）第三个字母是A 的员工姓名。
select ename from emp where ename like '__A%'
--2.找出EMP表员工名字中含有A 和N的员工姓名。
select ename from emp where ename like '%A%N%' or ename like '%N%A%'
--3.找出所有有佣金的员工，列出姓名、工资、佣金，显示结果按工资从小到大，佣金从大到小。
select ename,sal,comm from emp where comm is not null order by sal,comm desc
--4.列出部门编号为20的所有职位。
select distinct job from emp where deptno=20
--5.列出不属于SALES 的部门。
select dname from dept where dname !='SALES'
--6.显示工资不在1000 到1500 之间的员工信息：名字、工资，按工资从大到小排序。
select ename,sal from emp where sal<1000 or sal>1500 order by sal desc
--7.显示职位为MANAGER 和SALESMAN，年薪在15000 和20000 之间的员工的信息：名字、职位、年薪。
select ename,job,sal from emp where job='MANAGER' or job='SALESMAN' and sal between 1500 and 2000

--关于员工表的高级查询
--1    列出薪金高于在部门30工作的所有员工的薪金的员工姓名和薪金、部门名称。
select e.ename 员工姓名,e.sal 薪金,(select dname from dept d where d.deptno=e.deptno) 部门名称 from emp e where sal>(
select max(sal) from emp where deptno=30)
--2、  列出在每个部门工作的员工数量、平均工资和平均服务期限。
select count(2) 员工数量,avg(sal) 平均工资,avg((sysdate-to_date(hiredate))/365) 平均服务期限 from emp group by deptno
--3、  列出所有员工的姓名、部门名称和工资。
select e.ename,(select d.dname from dept d where d.deptno=e.deptno),e.sal from emp e
--4、  列出所有部门的详细信息和部门人数。
select count(1),(select dname from dept d where d.deptno=e.deptno) from emp e group by e.deptno
--5、  列出各种工作的最低工资及从事此工作的雇员姓名。
select * from emp
select min(sal),job from emp group by job
--6、  列出各个部门的MANAGER（经理）的最低薪金、姓名、部门名称、部门人数。
select min(e1.sal) 最低薪金,(select e2.ename from emp e2 where e2.deptno=e1.deptno and e2.job='MANAGER') 姓名,
(select d.dname from dept d where d.deptno=e1.deptno) 部门名称,(select count(1) from emp e3 where e3.deptno=e1.deptno) 部门人数
from emp e1 where e1.job='MANAGER' group by e1.deptno
--7、  列出所有员工的年工资，所在部门名称，按年薪从低到高排序。
select (e.sal*12+nvl(comm,0)) 年工资,d.dname 部门名称 from dept d,emp e order by (e.sal*12+nvl(comm,0)) 
--8、  求出部门名称中，带‘S’字符的部门员工的工资合计、部门人数。
select sum(sal) 工资合计,count(1) 部门人数 from emp where ename in(
select ename from emp where ename like '%S%')
--9、  给任职日期超过30年雇员加薪，加薪原则：10部门增长10%，20部门增长20%，30部门增	 长30%，依次类推。
update emp set sal=sal*(
       case deptno
       when 10 then 1.1
       when 20 then 1.2
       when 30 then 1.3
       when 40 then 1.4
       else 1
       end
)
where ename in(
select ename from emp where (sysdate-hiredate)/365>30)


select * from emp
