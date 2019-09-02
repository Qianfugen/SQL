create table emp as select * from scott.emp 
create table dept as select * from scott.dept

--1.列出至少有一个员工的所有部门。
select d.dname from dept d where d.deptno in(
select distinct e.deptno from emp e where ename is not null)
--2.列出薪金比“SMITH”多的所有员工。
select * from emp where sal>(select sal from emp where ename='SMITH')
--3.列出所有员工的姓名及其直接上级的姓名。
select e2.ename 员工,(select e1.ename from emp e1 where e1.empno=e2.mgr) 直接上司 from emp e2
--4.列出受雇日期早于其直接上级的所有员工。
select e2.ename from emp e2 where e2.hiredate<(select e1.hiredate from emp e1 where e1.empno=e2.mgr)
--5.列出部门名称和这些部门的员工信息，同时列出那些没有员工的部门
select d.dname,e.ename from dept d,emp e  where e.deptno=d.deptno 
--6.列出所有“CLERK”(办事员)的姓名及其部门名称。
select e.ename,(select d.dname from dept d where d.deptno=e.deptno) from emp e where job='CLERK'
--7.列出最低薪金大于1500的各种工作。
select job 岗位,min(sal) 最低工资 from emp group by job having min(sal)>1500
--8.列出在部门“SALES”(销售部)工作的员工的姓名，假定不知道销售部的部门编号。
select e.ename from emp e where e.deptno=(select  d.deptno from  dept d where d.dname='SALES')
--9.列出薪金高于公司平均薪金的所有员工。
select * from emp where sal>(select avg(sal) from emp)
--10.列出与“SCOTT”从事相同工作的所有员工。
select * from emp where job=(
select job from emp where ename='SCOTT')
and ename!='SCOTT'
--11.列出薪金等于部门30中员工的薪金的所有员工的姓名和薪金。
select ename 姓名,sal 薪金 from emp where deptno=30
--12.列出薪金高于在部门30工作的所有员工的薪金的员工姓名和薪金。
select ename,sal from emp where sal>(
select max(sal) from emp where deptno=30)
--13.列出在每个部门工作的员工数量、平均工资和平均服务期限。
select * from emp
select count(1) 员工数量,avg(sal) 平均工资,avg((sysdate-to_date(hiredate))/365) 平均服务期限 from emp group by deptno 
--14.列出所有员工的姓名、部门名称和工资。
select e.ename 姓名,(select d.dname from dept d where d.deptno=e.deptno) 部门名称,e.sal 工资 from emp e
--15.列出所有部门的详细信息和部门人数。
select d.*,(select count(1) from emp e where e.deptno=d.deptno) from dept d
--16.列出各种工作的最低工资。
select * from emp
select job,min(sal) from emp group by job
--17.列出各个部门的MANAGER(经理)的最低薪金。
select min(sal),deptno from emp where job='MANAGER' group by deptno
--18.列出所有员工的年工资,按年薪从低到高排序。
select ename,sal from emp order by sal
select (sal+nvl(comm,0))*12 from emp  order by (sal+nvl(comm,0))*12;

