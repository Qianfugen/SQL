--创建表空间
create tablespace pipixia
datafile 'C:\Users\28754\Desktop\tablespace\pipixia.dbf'
size 100M
autoextend on next 100M maxsize unlimited


--丢弃表空间test1及数据文件
drop tablespace test1 including contents and datafiles;

--alter用于表空间，用户，表，触发器，序列。。。
--设置表空间只读
alter tablespace pipixia read only;

--设置表空间可读可写
alter tablespace pipixia read write;

--创建pipixia用户,设置密码和表空间
create user pipixia identified by 123456 default tablespace pipixia;

--grant赋予权限
/*
系统权限：关于用户以及表结构的操作,比如:登录,建表,建过程函数....
对象权限:访问其他用户里面表的时候,该用户对其他用户表的增删查改操作....
*/

--创建会话权限
grant create session to pipixia;
--撤销会话权限
revoke create session from pipixia;

/*
每个角色的权限是独立:需要把CONNECT和RESOURCE两个最基本的权限给一个用户
       CONNECT角色：是授予最终用户的典型权利，最基本的权力，能够连接到ORACLE数据库中，
       并在对其他用户的表有访问权限时，做SELECT、UPDATE、INSERTT,DELETE等操作。
       RESOURCE角色：是授予开发人员的，能在自己的方案中创建 表、序列、视图等。
       DBA：数据库管理员角色，拥有管理数据库的最高权限 
*/
--赋予connect权限
grant connect to pipixia;
--赋予resource权限
grant resource to pipixia;
--赋予dba权限
grant dba to pipixia;

--撤销dba权限
revoke dba from pipixia;

--修改用户密码
alter user pipixia identified by 111111;

--------------------------------------------------------------------------------

--复制scott的emp,dept表到本用户
create table emp as select * from scott.emp;
create table dept as select * from scott.dept;
--只复制scott的bonus表结构到本用户
create table bonus as select * from scott.bonus where 1=2;

--查询表
--查询表所有信息
select * from emp;
select * from bonus;

--删除bonus表
drop table bonus;

/*
常用数据类型:
      字符类型:
          char:固定长度的字符串
          varchar2:可变长度的字符串(4000字节)
          long:可变长字符串，最大长度2GB
       数字类型:
          number:number(2)表示两位整数,number(5,2)有效位数最多5位包括两位小数
       日期:
          DATE:常用日期类型
          TIMESTAMP:时间戳
          
       length:返回字符个数
       lengthb:返回字节个数
*/
--返回字符个数 2
select length('汉字') from dual;
--返回字节个数 4
select lengthb('汉字') from dual;

--创建student表，id,sid,name,age,birdate，设id为主键
create table student(
       id number(4) primary key,
       sid number(4),
       name varchar2(20),
       age number(3),
       birdate date
)
select * from student;

--增加自增序列
create sequence seq_student
       minvalue 1
       maxvalue 9999
       increment by 1;

--创建行级触发器，每添加一列自动添加主键id
create or replace trigger tri_student_primary
before insert on student
for each row
begin
    select seq_student.nextval into :new.id from dual;
end;

--insert 插入数据
insert into student(sid,name,age,birdate) values(1,'ABCDE',22,sysdate);
insert into student(sid,name,age,birdate) values(2,'ABCDF',23,to_date('1997-01-01','yyyy-mm-dd'));

--delete 删除数据
delete from student where sid=1; 

--update 修改数据
update student set name='pipixia' where sid=1;

--select 查询数据
select * from student;

--自动插入100条记录
declare 
       v_i number(3):=1;
begin
       loop
           v_i := v_i+1;
           insert into student(sid,name,age) values(dbms_random.value(1,500),dbms_random.string('u',6),dbms_random.value(10,30));
           exit when v_i>100;
       end loop;
end;

--给表添加注释
comment on table student is '学生表';
--给表字段添加注释
comment on column student.sid is '学号';
comment on column student.name is '姓名';
comment on column student.age is '年龄';
comment on column student.birdate is '生日';
--给表添加字段
alter table student add(sex number);
alter table student add(hobby varchar2(20));
/*
字段名称,类型,长度要在建表的时候确定下来
*/
--修改sex数据长度
alter table student modify(sex number(1));

--修改列名
select * from student where 1=2;
alter table student rename column birdate to birthday;

------------------------------------------------------------------------------
/*
数据定义语言（DDL）:CREATE,ALERT,DROP,TRUNCATE
数据操纵语言（DML）:INSERT,UPDATE,DELETE,SELECT
事务控制语言（TCL）:COMMIT,SAVEPOINT,ROLLBACK
数据控制语言（DCL）:GRANT,REVOKE
*/

/*
主键生成的两种策略:
      序列:让主键自增
      随机:随机生成32位字符串
*/
--随机:随机生成32位字符串
select sys_guid() from dual;

/*
约束:
       主键约束Primary Key:唯一并且不为空,主要为了确保该条数据在表中有一个唯一的标识
       唯一unique:要求该列唯一，允许为空
       检查约束check:用来确保数据符合要求
       外键约束foreign key:用来关联其他表
       非空约束not null:不能为空
*/
/*
主键约束:一般情况下每张表都有会一个id字段用来标识主键,那么id这个字段对于表的数据来说是没有其他作用的
       只是用来标识这行数据唯一的
主键可以作用于一个字段,也可多个字段作为联合主键
*/

               --给emp表添加id字段，并填充数据,使用sys_guid()
--修改id字段               
alter table emp modify(id varchar2(32));
--查询emp表    
select * from emp;

--添加Id字段
alter table emp add(id number(5));
--使用游标填充数据
declare 
      --自定义动态游标类型
      type emp_cur_type is ref cursor return emp%rowtype;
      --定义游标变量
      emp_cur emp_cur_type;
      --定义行变量
      emp_row emp%rowtype;
begin
      open emp_cur for select * from emp;
      loop
           fetch emp_cur into emp_row;
           exit when emp_cur%notfound;
           update emp set id=sys_guid();
           dbms_output.put_line('员工姓名：'||emp_row.ename||',      薪资：'||emp_row.sal);
      end loop;
end;


--主键约束
alter table emp add constraint pk_emp_id primary key(id);

--先解除主键约束
alter table emp drop constraint pk_emp_id;
--联合约束
alter table emp add constraint pk_emp_id primary key(id,empno);

--唯一约束:可以为空但是不能重复
alter table emp add constraint uniq_emp_name unique(ename);
update emp set ename='ALLEN' where empno=7369;

--检查约束:
alter table emp add constraint ch_emp_sal check(sal>100 and sal <10000);
update emp set sal=12000 where empno=7369;

-----------------------------------------------------------------------------------------
                                   --简单查询                                                                                    
--查询所有员工信息
select * from emp;
--查询出员工编号，姓名，薪资
select empno,ename,sal from emp;
--查询出员工编号，姓名，薪资 以中文显示列名
select empno 编号,ename 姓名,sal 薪资 from emp;
--查询出员工编号，姓名，薪资 拼接在一个列显示:员工编号:8329,姓名:dsa,工资:3453
select '员工编号:'||empno||'，姓名：'||ename||'，工资：'||sal 详情 from emp;
--查询30号部门的所有员工
select * from emp where deptno=30;
--查询出30号部门下面员工在那些工作岗位:distinct去重复
select distinct(job) from emp where deptno=30;
--所有字段都重复才算是重复
select distinct * from emp where deptno=30;
--只有工资和岗位都重复的时候才算是重复,并且结果只会显示工资和岗位
select distinct sal,job from emp where deptno=30;
--查询出30号部门,岗位为SALESMAN的员工
select * from emp where deptno=30 and job='SALESMAN';
--查询出不等于30号部门下面的员工
select * from emp where deptno!=30;
select * from emp where deptno<>30;
--查询员工薪资 >=2000 and <=3000 的员工
select ename,sal from emp where sal between  2000 and 3000;
select ename,sal from emp where sal>=2000 and sal<=3000;
--查询出20,30部门下面的员工信息
select * from emp where deptno in (20,30);
select * from emp where deptno=20 or deptno=30;
--查询出没有上级的员工信息
select * from emp where mgr is null;
--查询有上级的员工信息
select * from emp where mgr is not null;

                               --高级查询
/*
       模糊匹配：like
        %:表示匹配任意个字符
        _:表示匹配一个字符
*/
--查询员工姓名包含‘S'的员工
select ename from emp where ename like '%S%';
--查询员工姓名第两个字符为’C'的员工
select ename from emp where ename like '_C%';
--根据员工的工资进行排序:desc倒叙,asc正序
select ename,sal from emp order by sal;
select ename,sal from emp order by sal desc;
--对30部门的员工按工资进行排序
select ename,sal,deptno from emp where deptno=30 order by sal desc;
/*
子查询:sql语句的嵌套,里面的sql语句叫子句,外面的叫主句,一条sql语句查询出来的结果可以作为一张虚拟表,
        另外一条sql语句可以从这张虚拟表中再次查询出数据
        单行子查询:子句只返回一个结果
        多行子查询:子句返回多个结果
相关子查询:子句在查询的过程中会拿到主句的某个字段作为条件,主句每执行一条记录,子句就会执行一遍
非相关子查询:子句只执行一次,执行结果交给主句使用
*/
--查询出‘SALES’部门(dept)下面的员工信息(emp):在where条件里面使用子查询
select * from emp where deptno=(select deptno from dept where dname='SALES');
--列出薪金比“SMITH”多的所有员工
select ename,sal from emp where sal>(select sal from emp where ename='SMITH');
--查询出和员工‘SCOTT’在同一个部门的员工
select ename,deptno from emp where deptno=(select deptno from emp where ename='SCOTT') and ename !='SCOTT';
--相关子查询并且在select中使用子查询:查询出员工编号，姓名，job，薪资，以及所在部门名称
select e.empno 员工编号,e.ename 姓名,e.job 职位,e.sal 薪资,(select d.dname from dept d where d.deptno=e.deptno) 部门名称 from emp e;
--相关子查询:列出所有员工的姓名及其直接上级的姓名
--e1 员工表,e2 上司表
select e1.ename 员工,(select e2.ename from emp e2 where e2.empno=e1.mgr) 上司 from emp e1;
--exists :判断后面的子句有没有查询出结果,如果查询出结果返回true否则返回false
--查询存在员工的部门信息
select d.* from dept d where exists (select e.ename from emp e where e.deptno=d.deptno);
--查询不存在员工的部门信息
--not exists:相反
select d.* from dept d where not exists (select e.ename from emp e where e.deptno=d.deptno);

                 
                                   --多表连接查询
/*
多表连接查询;我们想要的结果里面包含多张表的数据
*/
--笛卡尔积:那一张表里面的每一条记录和第二张表的每一条记录连接
select * from emp,dept;
--等值连接：连接条件用“=”进行关联,主外键的等值连接
--查询出所有的员工信息以及所在部门信息
select e.*,d.dname,d.loc from emp e,dept d where e.deptno=d.deptno; 
--左连接:以左边表为主,会显示左边表所有信息,如果和右边有有关联,那么显示右面表数据,如果没有关联那么显示空值
select * from emp e left join dept d on e.deptno=d.deptno;
--右连接
select * from emp e right join dept d on e.deptno=d.deptno;
--使用+号的左右连接
--+号写在右面表示左连接,+号写在左边表示右连接
--左连接
select * from emp e,dept d where e.deptno=d.deptno(+);
--右连接
select * from emp e,dept d where e.deptno(+)=d.deptno;

create table emp1 as select * from emp;
delete from emp where ename='SMITH';
insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno,id) values(1234,'QIAN','BOSS',null,to_date('1999-01-01','yyyy-mm-dd'),1000,null,10,sys_guid());
-- union all  ：把两个查询结果联合在一起查询显示，会有重复记录
select * from emp union all select * from emp1;
--union  ：把两个查询结果联合在一起查询显示，不会有重复记录
select * from emp union select * from emp1; 
--intersect :交集：把两个查询结果完全相同的记录查询显示
select * from emp intersect select * from emp1;
--minus ：补集：减去后面的查询结果，并且减去相交的结果
select * from emp minus select * from emp1;

---------------------------------------------------------------------------------------

--常用的函数                              
                                --字符函数 
--lower(待转换的字符串):将参数里面的字符串，转换成小写
select lower('ABCED') from dual;
--upper(待转换的字符串):将参数里面的字符串，转换成大写
select upper('abcde') from dual;
--initCap (待转换的字符串)：将字符串首字母转换成大写，其余的转换成小写
select initCap('i love you') from dual;
--concat(字符串1，字符串2):只能拼接两个字符串,将字符串1和字符串2连接起来获得一个新的字符串
select concat('hello ','world') from dual;
--instr(字符串，查找字符):返回该字符在字符串中的第一个出现位置,下标从1开始
select instr('abcdefg','e') from dual;
--substr(字符串，开始位置，数量):截取字符串,包括开始的位置,从开始位置开始截取指定位数的字符
select substr('abcdefg',3,4) from dual;
--32432423@sina.com截取sina
select substr('32432423@sina.com',instr('32432423@sina.com','@')+1,instr('32432423@sina.com','.')-instr('32432423@sina.com','@')-1) from dual;
--lpad(补齐字符串，整体补齐的位数，不够位数就用指定的字符)：左补齐
select lpad('32',4,'##') from dual;
--rpad(补齐字符串，整体补齐的位数，不够位数就用指定的字符)：右补齐
select rpad('32',4,'##') from dual;
--length： 返回字符串的长度(字符) 2
select length('汉字') from dual;
--lengthb:字节      
select lengthb('汉字') from dual;

                              --数字函数
--ceil(待向上取整的值):天花板 2
select ceil(1.01) from dual;
--floor(待向下取整的值):地板 1
select floor(1.99) from dual;
--mod (值1，值2):% 取余 1
select mod(10,3) from dual;
--round(待四舍五入的值，保留小数点的位数):
select round(3.1415926,2) from dual;
--trunc(待截断的值，保留小数位) 2.5 
select trunc(2.59,1) from dual;

                          --日期函数
--to_date()字符串和日期转换函数
select to_date('2019-09-09 20:00','yyyy-mm-dd hh24:mi:ss') from dual;
--add_months(待增加的日期，要增加的月份数)：把增加月份数后的日期返回
select add_months(to_date('2019-7-5','yyyy-mm-dd'),5) from dual;
--next_day(指定的日期,星期几)：返回指定日期的下一个的星期几
select next_day(sysdate,'星期五') from dual;
--trunc(指定的日期)/*截断时分秒，返回年月日*/
select trunc(sysdate) from dual;
--to_char(指定的日期,字母格式):返回指定格式的时间信息
select to_char(sysdate,'yyyy-mm-dd') from dual;
                         
                          --其他函数
--nvl(值1，值2)： 如果值1为空，则返回值2,反之则返回值1
select empno 编号,ename 姓名,sal+nvl(comm,0) 收入 from emp;
--decode(值1，if1,then1,if2,then2,else ):判断  给员工涨薪,10部门涨10%,20部门涨20%.....
update emp set sal=sal*decode(deptno,10,1.1,20,1.2,1.3);
select * from emp;
                         --分组以及聚合函数：基于多行返回一个结果
--求所有的员工平均薪资,最高工资,最低工资，总工资，总人数
select avg(sal) 平均薪资,max(sal) 最高工,min(sal) 最低工资,sum(sal) 总工资,count(1) 总人数 from emp;
--count求有奖金人数:如果参数为单一字段那么如果字段值为null就不算
select count(comm) from emp;
--分组group by
/*
如果分组那么select后面只能写聚合函数以及组名
*/
--根据部门分组，查询每个部门的平均薪资avg()，最小薪资min()，最大薪资max()，总薪资sum()，部门人数count()
select round(avg(sal),2) 平均薪资,min(sal) 最小薪资,max(sal) 最大薪资,sum(sal) 总薪资,count(1) 部门人数 from emp group by deptno;
--where后面不能跟聚合函数,where只能用来筛选数据,如果想对组进行筛选要用having
--平均工资大于2000的部门
select deptno 部门,avg(sal) 平均工资 from emp group by deptno having avg(sal)>2000;
--大于平均工资的员工
select ename 姓名,sal 工资,e.* from emp,(select avg(sal) 平均工资 from emp) e where sal>(select avg(sal) from emp);
--查询10,20部门的员工的平均工资,并且平均工资要大于2000
select deptno 部门,avg(sal) 平均工资 from emp where deptno in (10,20) group by deptno having avg(sal)>2000 order by avg(sal) desc;
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
);
select * from emp;
--统计每个部门每个岗位的人数
select distinct job from emp
select deptno,
       count(case job when 'CLERK' then 1 else null end) CLERK,
       count(case job when 'SALESMAN' then 1 else null end) SALESMAN,
       count(case job when 'PRESIDENT' then 1 else null end) PRESIDENT,
       count(case job when 'MANAGER' then 1 else null end) MANAGER,
       count(case job when 'ANALYST' then 1 else null end) ANALYST
from emp group by deptno;


------------------------------------------------------------------------------------------

--rownum和rowid
  /*
    rownum(是查询的时候动态生成的):当使用sql语句进行查询完成的时候,oracle会自动的给每一行数据按照结果集的顺序编号
    如果作为条件取排名的时候,默认必须包含1 
    如果即有排序又有rownum系统会给每行加rownum然后在排序(主键以及有索引列除外)
  */
--取前3行
select * from emp where rownum<=3;
--按工资排序取前三行
select * from (select * from emp order by sal desc) where rownum<=3;
--按工资排序取第三行
select e3.* from(
select e2.*,rownum r from 
(select e1.* from emp e1 order by sal desc)e2
)e3 where r=3;

  /*
  保存rowid需要10个字节或者是80个位二进制位。这80个二进制位分别是：
      1. 数据对象编号，表明此行所属的数据库对象的编号，每个数据对象在数据库建立的时候都被唯一分配一个编号，并且此编号唯一。数据对象编号占用大约32位。
      2. 对应文件编号，表明该行所在文件的编号，表空间的每一个文件标号都是唯一的。文件编号所占用的位置是10位。
      3. 块编号，表明改行所在文件的块的位置块编号需要22位。
      4. 行编号，表明该行在行目录中的具体位置行编号需要16位。  
  Oracle的物理扩展ROWID有18位，每位采用64位编码，分别用A~Z、a~z、0~9、+、/共64个字符表示。
  A表示0，B表示1，……Z表示25，a表示26，……z表示51，0表示52，……，9表示61，+表示62，/表示63。
  rowid:在我们插入数据的时候oracle会根据数据的物理特征生成一个18位以64位编码的字符串作为唯一标识,
  是不会发生改变的
  */
--显示rowid
select e.*,rowid from emp e;
--取第一行数据
select e.* from emp e where rowid=(select min(rowid) from emp);

                                          --分析函数：用来计算排名
 /*
 分析函数和聚合函数的区别就是：分析函数会返回多行数据
 */                              
--rank() over():存在并列的情况 ，会发生跳跃 11345
--dense_rank() over():存在并列的情况 ，不会发生跳跃 11234
--row_number() over():不存在并列的情况 ，不会发生跳跃 12345
--在分析函数中使用partition by代表sql语句中的group by
--rank() over() 11345
select empno,ename,sal,deptno,rank() over(partition by deptno order by sal desc) 排名 from emp;
--dense_rank() over() 11234
select empno,ename,sal,deptno,dense_rank() over(partition by deptno order by sal desc) 排名 from emp;
--row_number() over() 12345
select empno,ename,sal,deptno,row_number() over(partition by deptno order by sal desc) 排名 from emp;
--综合
select empno,ename,sal,deptno,
rank() over(partition by deptno order by sal desc) ro,
dense_rank() over(partition by deptno order by sal desc) dro,
row_number() over(partition by deptno order by sal desc) rno
from emp;

--查询出第5-8个员工记录,按工资从高往低排序 7698,7782,7499,7844
--一、使用rownum
select e3.* from(
select e2.*,rownum r from 
(select e1.* from emp e1 order by sal desc) e2) e3
where r between 5 and 8; 

--二、使用row_number() over()
select e2.* from (select e.*,row_number() over(order by sal desc) rno from emp e) e2 where rno between 5 and 8;


----------------------------------------------------------------------------------------

--plsql:过程化sql语句
declare
       i number(5) := 3000;
begin
       select sal into i from emp where ename='KING'; 
       dbms_output.put_line('i的值：'||i);
end;

--定义行类型变量
select * from emp where ename='SCOTT';
declare
       emp_row emp%rowtype;
begin
       select * into emp_row from emp where ename='SCOTT'; 
       dbms_output.put_line('编号：'||emp_row.empno||'姓名：'||emp_row.ename||'，工资：'||emp_row.sal);
end;

--loop循环
declare
       i number(3):=0;
begin
       loop
         dbms_output.put_line(i);
         i:=i+1;
         exit when i>100;
       end loop;
end;


--for循环
declare 
begin
  for v_i in 1..9 loop
      for v_y in 1..v_i loop
          dbms_output.put(v_y||'*'||v_i||'='||(v_y*v_i)||'   ');
      end loop;  
           dbms_output.new_line();
  end loop;
end;


--while循环
declare
       i number(3):=0;
begin
       while i<100 loop
         dbms_output.put_line(i);
         i:=i+1;
       end loop;
end;

--异常处理
declare
       v_sal emp.sal%type; 
begin
       select sal into v_sal from emp where deptno=30;
       exception
              when TOO_MANY_ROWS then
                   dbms_output.put_line('返回多个值');
       dbms_output.put_line('----------------------');             
end;
         
--自定义异常名称,绑定异常编码
alter table dept add constraint pk_dept_deptno primary key(deptno);
alter table emp add constraint fk_emp_dept foreign key(deptno) references dept(deptno);

declare
       no_deptno_id exception;
       pragma exception_init(no_deptno_id,-02291);
begin
       update emp set deptno=60  where empno=1234;
       exception 
              when no_deptno_id then
                   dbms_output.put_line('没有该部门编号');
end;



                                  --游标
/*
   隐式游标:当我们执行DML语句的时候系统会自动的给该语句生成隐式游标,隐式游标的名称固定为sql
   显式游标:
       静态游标:我们在定义游标的时候就已经把数据放到游标里面了
       动态游标(自定义游标+系统游标):
*/

--静态游标
declare
     cursor cs_emp is select * from emp;
     emp_row emp%rowtype;
begin
      open cs_emp;
      loop
           fetch cs_emp into emp_row;
           exit when cs_emp%notfound;
           dbms_output.put_line('loop员工编号:'||emp_row.empno||',员工姓名:'||emp_row.ename||',薪资:'||emp_row.sal);
      end loop;
      close cs_emp;
end;

--自定义动态游标
declare
      type cs_emp_type is ref cursor return emp%rowtype;
      cs_emp cs_emp_type;
      emp_row emp%rowtype;
begin
      open cs_emp for select * from emp;
      loop
           fetch cs_emp into emp_row;
           exit when cs_emp%notfound;
           dbms_output.put_line('loop员工编号:'||emp_row.empno||',员工姓名:'||emp_row.ename||',薪资:'||emp_row.sal);
      end loop;
      close cs_emp;
end;

--系统动态游标
declare 
      cs_emp sys_refcursor;
      emp_row emp%rowtype;
begin
      open cs_emp for select * from emp;
      loop
           fetch cs_emp into emp_row;
           exit when cs_emp%notfound;
           dbms_output.put_line('loop员工编号:'||emp_row.empno||',员工姓名:'||emp_row.ename||',薪资:'||emp_row.sal);
      end loop;
      close cs_emp;
end;


