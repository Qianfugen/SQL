--to_date()�ַ���������ת������
select (sysdate-to_date('2019-8-29 11:00:32','yyyy-MM-dd hh:mi:ss')) from dual;
--add_months(�����ӵ����ڣ�Ҫ���ӵ��·���)���������·���������ڷ���
select add_months(sysdate,2) from dual;
--next_day(ָ��������,���ڼ�)������ָ�����ڵ���һ�������ڼ�
select next_day(sysdate,'������') from dual;
--trunc(ָ��������)/*�ض�ʱ���룬����������*/
select trunc(sysdate) from dual;
--to_char(ָ��������,��ĸ��ʽ):����ָ����ʽ��ʱ����Ϣ
select to_char(sysdate,'hh:mi:ss') from dual;
select * from emp where (sysdate-hiredate)/365>38
          --��������
--nvl(ֵ1��ֵ2)�� ���ֵ1Ϊ�գ��򷵻�ֵ2,��֮�򷵻�ֵ1
select * from emp;
select empno,ename,sal+nvl(comm,0) from emp;
select empno,ename,(sal+nvl(comm,0)) from emp
--decode(ֵ1��if1,then1,if2,then2,else ):�ж�  ��Ա����н,10������10%,20������20%.....
update emp set sal=sal*decode(deptno,10,1.1,20,1.2,30,1.3,40,1.4,null,1)
select * from emp
                                  --�����Լ��ۺϺ��������ڶ��з���һ�����
--�����е�Ա��ƽ��н��
select avg(sal) ƽ�����ʣ�min(sal) ��͹��ʣ�max(sal) ��߹��ʣ�count(*) ���� from emp
--count��Ա��������:�������Ϊ��һ�ֶ���ô����ֶ�ֵΪnull�Ͳ���
insert into emp(empno) values(7999);
delete from emp where empno=7999;
select count(1) from emp
--����group by
/*
���������ôselect����ֻ��д�ۺϺ����Լ�����
*/
--���ݲ��ŷ��飬��ѯÿ�����ŵ�ƽ��н��avg()����Сн��min()�����н��max()����н��sum()����������count()
select * from dept;
select decode(e.deptno,10,'ACCOUNTING',20,'RESEARCH',30,'SALES',40,'OPERATIONS') ����,avg(sal) ƽ������,max(sal) ���н��,min(sal) ��Сн��,sum(sal) ��н��,count(1) ��������  from emp e group by e.deptno
--where���治�ܸ��ۺϺ���,whereֻ������ɸѡ����,�����������ɸѡҪ��having
select deptno,avg(sal) from emp group by deptno having avg(sal)>2000
--����ƽ�����ʵ�Ա��
select * from emp where sal>(select avg(sal) from emp)
--��ѯ10,20���ŵ�Ա����ƽ������,����ƽ������Ҫ����2000
select deptno ����,avg(sal) ƽ������ from emp where deptno in(10,20) group by deptno having avg(sal)>2000 order by avg(sal) desc
--case when��ϰ
--��Ա����н,10������10%,20������20%....
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
--ͳ��ÿ������ÿ����λ������
select distinct job from emp;
select deptno,count(case job when 'CLERK' then 1 else null end) CLERK ,
count(case job when 'SALESMAN' then 1 else null end) SALESMAN,
count(case job when 'PRESIDENT' then 1 else null end) PRESIDENT ,
count(case job when 'MANAGER' then 1 else null end) MANAGER,
count(case job when 'ANALYST' then 1 else null end) ANALYST
from emp group by deptno
             
