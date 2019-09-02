--to_date()字符串和日期转换函数
select (sysdate-to_date('2019-8-29 11:00:32','yyyy-MM-dd hh:mi:ss')) from dual;
--add_months(待增加的日期，要增加的月份数)：把增加月份数后的日期返回
select add_months(sysdate,2) from dual;
--next_day(指定的日期,星期几)：返回指定日期的下一个的星期几
select next_day(sysdate,'星期三') from dual;
--trunc(指定的日期)/*截断时分秒，返回年月日*/
select trunc(sysdate) from dual;
--to_char(指定的日期,字母格式):返回指定格式的时间信息
select to_char(sysdate,'hh:mi:ss') from dual;
select * from emp where (sysdate-hiredate)/365>38
          --其他函数
--nvl(值1，值2)： 如果值1为空，则返回值2,反之则返回值1
select * from emp;
select empno,ename,sal+nvl(comm,0) from emp;
select empno,ename,(sal+nvl(comm,0)) from emp
--decode(值1，if1,then1,if2,then2,else ):判断  给员工涨薪,10部门涨10%,20部门涨20%.....
update emp set sal=sal*decode(deptno,10,1.1,20,1.2,30,1.3,40,1.4,null,1)
select * from emp
                                  --分组以及聚合函数：基于多行返回一个结果
--求所有的员工平均薪资
select avg(sal) 平均工资，min(sal) 最低工资，max(sal) 最高工资，count(*) 人数 from emp
--count求员工总人数:如果参数为单一字段那么如果字段值为null就不算
insert into emp(empno) values(7999);
delete from emp where empno=7999;
select count(1) from emp
--分组group by
/*
如果分组那么select后面只能写聚合函数以及组名
*/
--根据部门分组，查询每个部门的平均薪资avg()，最小薪资min()，最大薪资max()，总薪资sum()，部门人数count()
select * from dept;
select decode(e.deptno,10,'ACCOUNTING',20,'RESEARCH',30,'SALES',40,'OPERATIONS') 部门,avg(sal) 平均工资,max(sal) 最大薪资,min(sal) 最小薪资,sum(sal) 总薪资,count(1) 部门人数  from emp e group by e.deptno
--where后面不能跟聚合函数,where只能用来筛选数据,如果想对组进行筛选要用having
select deptno,avg(sal) from emp group by deptno having avg(sal)>2000
--大于平均工资的员工
select * from emp where sal>(select avg(sal) from emp)
--查询10,20部门的员工的平均工资,并且平均工资要大于2000
select deptno 部门,avg(sal) 平均工资 from emp where deptno in(10,20) group by deptno having avg(sal)>2000 order by avg(sal) desc
--case when练习
--给员工涨薪,10部门涨10%,20部门涨20%....
update emp set sal=sal*(
       case deptno
            when 10 then 1.1
            when 20 then 1.2
            when 30 then 1.3
            when 40 then 1.4
            else 1
            end       
)
select * from emp
--统计每个部门每个岗位的人数
select distinct job from emp;
select deptno,count(case job when 'CLERK' then 1 else null end) CLERK ,
count(case job when 'SALESMAN' then 1 else null end) SALESMAN,
count(case job when 'PRESIDENT' then 1 else null end) PRESIDENT ,
count(case job when 'MANAGER' then 1 else null end) MANAGER,
count(case job when 'ANALYST' then 1 else null end) ANALYST
from emp group by deptno
             
