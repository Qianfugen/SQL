--����Ա�������ͨ��ѯ
--1.�ҳ�EMP���е�������ENAME����������ĸ��A ��Ա��������
select ename from emp where ename like '__A%'
--2.�ҳ�EMP��Ա�������к���A ��N��Ա��������
select ename from emp where ename like '%A%N%' or ename like '%N%A%'
--3.�ҳ�������Ӷ���Ա�����г����������ʡ�Ӷ����ʾ��������ʴ�С����Ӷ��Ӵ�С��
select ename,sal,comm from emp where comm is not null order by sal,comm desc
--4.�г����ű��Ϊ20������ְλ��
select distinct job from emp where deptno=20
--5.�г�������SALES �Ĳ��š�
select dname from dept where dname !='SALES'
--6.��ʾ���ʲ���1000 ��1500 ֮���Ա����Ϣ�����֡����ʣ������ʴӴ�С����
select ename,sal from emp where sal<1000 or sal>1500 order by sal desc
--7.��ʾְλΪMANAGER ��SALESMAN����н��15000 ��20000 ֮���Ա������Ϣ�����֡�ְλ����н��
select ename,job,sal from emp where job='MANAGER' or job='SALESMAN' and sal between 1500 and 2000

--����Ա����ĸ߼���ѯ
--1    �г�н������ڲ���30����������Ա����н���Ա��������н�𡢲������ơ�
select e.ename Ա������,e.sal н��,(select dname from dept d where d.deptno=e.deptno) �������� from emp e where sal>(
select max(sal) from emp where deptno=30)
--2��  �г���ÿ�����Ź�����Ա��������ƽ�����ʺ�ƽ���������ޡ�
select count(2) Ա������,avg(sal) ƽ������,avg((sysdate-to_date(hiredate))/365) ƽ���������� from emp group by deptno
--3��  �г�����Ա�����������������ƺ͹��ʡ�
select e.ename,(select d.dname from dept d where d.deptno=e.deptno),e.sal from emp e
--4��  �г����в��ŵ���ϸ��Ϣ�Ͳ���������
select count(1),(select dname from dept d where d.deptno=e.deptno) from emp e group by e.deptno
--5��  �г����ֹ�������͹��ʼ����´˹����Ĺ�Ա������
select * from emp
select min(sal),job from emp group by job
--6��  �г��������ŵ�MANAGER�����������н���������������ơ�����������
select min(e1.sal) ���н��,(select e2.ename from emp e2 where e2.deptno=e1.deptno and e2.job='MANAGER') ����,
(select d.dname from dept d where d.deptno=e1.deptno) ��������,(select count(1) from emp e3 where e3.deptno=e1.deptno) ��������
from emp e1 where e1.job='MANAGER' group by e1.deptno
--7��  �г�����Ա�����깤�ʣ����ڲ������ƣ�����н�ӵ͵�������
select (e.sal*12+nvl(comm,0)) �깤��,d.dname �������� from dept d,emp e order by (e.sal*12+nvl(comm,0)) 
--8��  ������������У�����S���ַ��Ĳ���Ա���Ĺ��ʺϼơ�����������
select sum(sal) ���ʺϼ�,count(1) �������� from emp where ename in(
select ename from emp where ename like '%S%')
--9��  ����ְ���ڳ���30���Ա��н����нԭ��10��������10%��20��������20%��30������	 ��30%���������ơ�
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
