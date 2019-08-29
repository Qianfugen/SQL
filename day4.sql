create table emp1 as select * from emp where empno in(7369,7499,7788)
select * from emp1
--并集：union  
-- union all  ：把两个查询结果联合在一起查询显示，会有重复记录
select * from emp
union all
select * from emp1
--union  ：把两个查询结果联合在一起查询显示，不会有重复记录
select * from emp
union
select * from emp1
--intersect :交集：把两个查询结果完全相同的记录查询显示
select * from emp
intersect
select * from emp1
--minus ：补集：减去后面的查询结果，并且减去相交的结果
select * from emp
minus
select * from emp1                                 
                                   --多表连接查询
/*
多表连接查询;我们想要的结果里面包含多张表的数据
*/
--笛卡尔积:那一张表里面的每一条记录和第二张表的每一条记录连接
select * from emp,dept  
--等值连接：连接条件用“=”进行关联,主外键的等值连接
--查询出所有的员工信息以及所在部门信息
select e.empno,e.ename,e.sal,d.dname from emp e,dept d where e.deptno=d.deptno
--左连接:以左边表为主,会显示左边表所有信息,如果和右边有有关联,那么显示右面表数据,如果没有关联那么显示空值
select * from emp e left join dept d on e.deptno=d.deptno
--右连接
select * from emp e right join dept d on e.deptno=d.deptno
select e1.ename,e2.ename from emp e1 ,emp e2 where e1.mgr=e2.empno
--使用+号的左右连接
select * from emp e,dept d where e.deptno=d.deptno(+)
--+号写在右面表示左连接,+号写在左边表示右连接
                                  --常用的函数                              
        --字符函数 
--lower(待转换的字符串):将参数里面的字符串，转换成小写
select lower('HJHGDSJGDJ') from dual;
--upper(待转换的字符串):将参数里面的字符串，转换成大写
select upper('sdfdsf') from dual;
--initCap (待转换的字符串)：将字符串首字母转换成大写，其余的转换成小写
select initCap('lnit select') from dual;
--concat(字符串1，字符串2):只能拼接两个字符串,将字符串1和字符串2连接起来获得一个新的字符串
select concat('hello',concat('my','oracle')) from dual;
--instr(字符串，查找字符):返回该字符在字符串中的第一个出现位置,下标从1开始
select instr('sfdsaf23dsfdsf','2') from dual
--substr(字符串，开始位置，数量):截取字符串,包括开始的位置,从开始位置开始截取指定位数的字符
select substr('sfdsaf23dsfdsf',3) from dual
--32432423@sina.com 14-9  5
select substr('32432423@qq.com',instr('32432423@qq.com','@')+1,instr('32432423@qq.com','.')-(instr('32432423@qq.com','@')+1)) from dual;
--lpad(补齐字符串，整体补齐的位数，不够位数就用指定的字符)：左补齐   0080
select lpad(32,4,'0') from dual;
--rpad(补齐字符串，整体补齐的位数，不够位数就用指定的字符)：右补齐
select rpad(32,4,'0') from dual;
--length： 返回字符串的长度(字符)
--lengthb:字节
          --数字函数
--ceil(待向上取整的值):天花板
select ceil(1.00009) from dual
--floor(待向下取整的值):地板
select floor(1.99999) from dual
--mod (值1，值2):% 取余
select mod(10,3) from dual
--round(待四舍五入的值，保留小数点的位数):
select round(2.555,0) from dual;
--trunc(待截断的值，保留小数位)
select trunc(2.455,2) from dual
					--日期函数
/*
Year:      
    yy  两位年                显示值:07
    yyy  三位年                显示值:007
    yyyy  四位年                显示值:2007
            
Month:      
    mm    number     两位月              显示值:11
    mon    abbreviated 字符集表示          显示值:11月,若是英文版,显示nov     
    month spelled out 字符集表示          显示值:11月,若是英文版,显示november 
          
Day:      
    dd    number         当月第几天        显示值:02
    ddd    number         当年第几天        显示值:02
    dy    abbreviated 当周第几天简写    显示值:星期五,若是英文版,显示fri
    day    spelled out   当周第几天全写    显示值:星期五,若是英文版,显示friday                   
Hour:
    hh    two digits 12小时进制            显示值:01
    hh24 two digits 24小时进制            显示值:13
              
Minute:
    mi    two digits 60进制                显示值:45
              
Second:
    ss    two digits 60进制                显示值:25
              
其它
    Q     digit         季度                  显示值:4
    WW    digit         当年第几周            显示值:44
    W    digit          当月第几周            显示值:1
*/
--to_date()字符串和日期转换函数
select (sysdate-to_date('2019-08-27 12:30:56','yyyy-MM-dd hh24:mi:ss')) from dual 
--add_months(待增加的日期，要增加的月份数)：把增加月份数后的日期返回
select add_months(sysdate,1) from dual
--next_day(指定的日期,星期几)：返回指定日期的下一个的星期几
select next_day(sysdate,'星期五') from dual
--trunc(指定的日期)/*截断时分秒，返回年月日*/
select trunc(sysdate) from dual
--to_char(指定的日期,字母格式):返回指定格式的时间信息
select to_char(sysdate,'ss') from dual
select * from emp where (sysdate-hiredate)/365>38
					--其他函数
--nvl(值1，值2)： 如果值1为空，则返回值2,反之则返回值1
select empno,ename,(sal+nvl(comm,0)) from emp
--decode(值1，if1,then1,if2,then2,else ):判断  给员工涨薪,10部门涨10%,20部门涨20%.....
update emp set sal=sal*decode(deptno,10,1.1,20,1.2,30,1.3,40,1.4,null,1)
select * from emp
                                  --分组以及聚合函数：基于多行返回一个结果
--求所有的员工平均薪资
select avg(sal) 平均工资,max(sal) 最高工资,min(sal) 最低工资,sum(sal) 总工资,count(*) 总人数 from emp
--count求员工总人数:如果参数为单一字段那么如果字段值为null就不算
select count(1) from emp
--分组group by
/*
如果分组那么select后面只能写聚合函数以及组名
*/
--根据部门分组，查询每个部门的平均薪资avg()，最小薪资min()，最大薪资max()，总薪资sum()，部门人数count()
select decode(e.deptno,10,'ACCOUNTING',20,'RESEARCH',30,'SALES',40,'OPERATIONS'),avg(e.sal) 平均工资,max(e.sal) 最高工资,min(e.sal) 最低工资,sum(e.sal) 总工资,count(*) 总人数 from emp e group by e.deptno
--where后面不能跟聚合函数,where只能用来筛选数据,如果想对组进行筛选要用having
select deptno, avg(sal) from emp group by deptno having avg(sal)>2000
--大于平均工资的员工
select * from emp where sal>(select avg(sal) from emp)
--查询10,20部门的员工的平均工资,并且平均工资要大于2000
select deptno,avg(sal) from emp where deptno in(10,20) group by deptno  having avg(sal)>2000 order by avg(sal) desc
--case when练习
--给员工涨薪,10部门涨10%,20部门涨20%....
update emp set sal=sal*(
       --拿deptno进行比较
       case deptno 
            --如果等于10那么返回1.1
            when 10 then 1.1
            when 20 then 1.2
            when 30 then 1.3
            when 40 then 1.4 
            else 1 
       end
)
--统计每个部门每个岗位的人数
select deptno,count(case job when 'CLERK' then 1 else null end) CLERK,
              count(case job when 'SALESMAN' then 1 else null end) SALESMAN,
              count(case job when 'PRESIDENT' then 1 else null end) PRESIDENT,
              count(case job when 'MANAGER' then 1 else null end) MANAGER,
              count(case job when 'ANALYST' then 1 else null end) ANALYST
              from emp group by deptno
              
select distinct job from emp
