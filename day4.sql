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
--initCap (待转换的字符串)：将字符串首字母转换成大写，其余的转换成小写

--lower(待转换的字符串):将参数里面的字符串，转换成小写

--upper(待转换的字符串):将参数里面的字符串，转换成大写

--concat(字符串1，字符串2):只能拼接两个字符串,将字符串1和字符串2连接起来获得一个新的字符串

--substr(字符串，开始位置，数量):拆分字符串,包括开始的位置

--lpad(补齐字符串，整体补齐的位数，不够位数就用指定的字符)：左补齐   0080

--rpad(补齐字符串，整体补齐的位数，不够位数就用指定的字符)：右补齐

--instr(字符串，查找字符):返回该字符在字符串中的第一个出现位置

--length： 返回字符串的长度(字符)

--lengthb:字节

          --数字函数
--ceil(待向上取整的值):天花板

--floor(待向下取整的值):地板

--mod (值1，值2):% 取余

--round(待四舍五入的值，保留小数点的位数):

--trunc(待截断的值，保留小数位)

					--日期函数
--to_date()字符串和日期转换函数

--add_months(待增加的日期，要增加的月份数)：把增加月份数后的日期返回

--next_day(指定的日期,星期几)：返回指定日期的下一个的星期几

--trunc(指定的日期)/*截断时分秒，返回年月日*/

--to_char(指定的日期,字母格式):返回指定格式的时间信息

					--其他函数

--nvl(值1，值2)： 如果值1为空，则返回值2,反之则返回值1

--decode(值1，if1,then1,if2,then2,else ):判断

                                  --分组以及聚合函数：基于多行返回一个结果
--求所有的员工平均薪资

--求所有员工工资总和

--求员工总人数:如果参数为单一字段那么如果字段值为null就不算

--分组group by
--根据部门分组，查询每个部门的  
--平均薪资avg()，最小薪资min()，最大薪资max()，总薪资sum()，部门人数count()
--where后面不能跟聚合函数,如果想对组进行筛选要用having

--case when练习
--给员工涨薪,10部门涨10%,20部门涨20%....

--统计每个部门每个岗位的人数

