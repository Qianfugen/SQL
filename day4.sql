create table emp1 as select * from emp where empno in(7369,7499,7788)
select * from emp1
--������union  
-- union all  ����������ѯ���������һ���ѯ��ʾ�������ظ���¼
select * from emp
union all
select * from emp1
--union  ����������ѯ���������һ���ѯ��ʾ���������ظ���¼
select * from emp
union
select * from emp1
--intersect :��������������ѯ�����ȫ��ͬ�ļ�¼��ѯ��ʾ
select * from emp
intersect
select * from emp1
--minus ����������ȥ����Ĳ�ѯ��������Ҽ�ȥ�ཻ�Ľ��
select * from emp
minus
select * from emp1                                 
                                   --������Ӳ�ѯ
/*
������Ӳ�ѯ;������Ҫ�Ľ������������ű������
*/
--�ѿ�����:��һ�ű������ÿһ����¼�͵ڶ��ű��ÿһ����¼����
select * from emp,dept  
--��ֵ���ӣ����������á�=�����й���,������ĵ�ֵ����
--��ѯ�����е�Ա����Ϣ�Լ����ڲ�����Ϣ
select e.empno,e.ename,e.sal,d.dname from emp e,dept d where e.deptno=d.deptno
--������:����߱�Ϊ��,����ʾ��߱�������Ϣ,������ұ����й���,��ô��ʾ���������,���û�й�����ô��ʾ��ֵ
select * from emp e left join dept d on e.deptno=d.deptno
--������
select * from emp e right join dept d on e.deptno=d.deptno
select e1.ename,e2.ename from emp e1 ,emp e2 where e1.mgr=e2.empno
--ʹ��+�ŵ���������
select * from emp e,dept d where e.deptno=d.deptno(+)
--+��д�������ʾ������,+��д����߱�ʾ������
                                  --���õĺ���                              
        --�ַ����� 
--lower(��ת�����ַ���):������������ַ�����ת����Сд
select lower('HJHGDSJGDJ') from dual;
--upper(��ת�����ַ���):������������ַ�����ת���ɴ�д
select upper('sdfdsf') from dual;
--initCap (��ת�����ַ���)�����ַ�������ĸת���ɴ�д�������ת����Сд
select initCap('lnit select') from dual;
--concat(�ַ���1���ַ���2):ֻ��ƴ�������ַ���,���ַ���1���ַ���2�����������һ���µ��ַ���
select concat('hello',concat('my','oracle')) from dual;
--instr(�ַ����������ַ�):���ظ��ַ����ַ����еĵ�һ������λ��,�±��1��ʼ
select instr('sfdsaf23dsfdsf','2') from dual
--substr(�ַ�������ʼλ�ã�����):��ȡ�ַ���,������ʼ��λ��,�ӿ�ʼλ�ÿ�ʼ��ȡָ��λ�����ַ�
select substr('sfdsaf23dsfdsf',3) from dual
--32432423@sina.com 14-9  5
select substr('32432423@qq.com',instr('32432423@qq.com','@')+1,instr('32432423@qq.com','.')-(instr('32432423@qq.com','@')+1)) from dual;
--lpad(�����ַ��������岹���λ��������λ������ָ�����ַ�)������   0080
select lpad(32,4,'0') from dual;
--rpad(�����ַ��������岹���λ��������λ������ָ�����ַ�)���Ҳ���
select rpad(32,4,'0') from dual;
--length�� �����ַ����ĳ���(�ַ�)
--lengthb:�ֽ�
          --���ֺ���
--ceil(������ȡ����ֵ):�컨��
select ceil(1.00009) from dual
--floor(������ȡ����ֵ):�ذ�
select floor(1.99999) from dual
--mod (ֵ1��ֵ2):% ȡ��
select mod(10,3) from dual
--round(�����������ֵ������С�����λ��):
select round(2.555,0) from dual;
--trunc(���ضϵ�ֵ������С��λ)
select trunc(2.455,2) from dual
					--���ں���
/*
Year:      
    yy  ��λ��                ��ʾֵ:07
    yyy  ��λ��                ��ʾֵ:007
    yyyy  ��λ��                ��ʾֵ:2007
            
Month:      
    mm    number     ��λ��              ��ʾֵ:11
    mon    abbreviated �ַ�����ʾ          ��ʾֵ:11��,����Ӣ�İ�,��ʾnov     
    month spelled out �ַ�����ʾ          ��ʾֵ:11��,����Ӣ�İ�,��ʾnovember 
          
Day:      
    dd    number         ���µڼ���        ��ʾֵ:02
    ddd    number         ����ڼ���        ��ʾֵ:02
    dy    abbreviated ���ܵڼ����д    ��ʾֵ:������,����Ӣ�İ�,��ʾfri
    day    spelled out   ���ܵڼ���ȫд    ��ʾֵ:������,����Ӣ�İ�,��ʾfriday                   
Hour:
    hh    two digits 12Сʱ����            ��ʾֵ:01
    hh24 two digits 24Сʱ����            ��ʾֵ:13
              
Minute:
    mi    two digits 60����                ��ʾֵ:45
              
Second:
    ss    two digits 60����                ��ʾֵ:25
              
����
    Q     digit         ����                  ��ʾֵ:4
    WW    digit         ����ڼ���            ��ʾֵ:44
    W    digit          ���µڼ���            ��ʾֵ:1
*/
--to_date()�ַ���������ת������
select (sysdate-to_date('2019-08-27 12:30:56','yyyy-MM-dd hh24:mi:ss')) from dual 
--add_months(�����ӵ����ڣ�Ҫ���ӵ��·���)���������·���������ڷ���
select add_months(sysdate,1) from dual
--next_day(ָ��������,���ڼ�)������ָ�����ڵ���һ�������ڼ�
select next_day(sysdate,'������') from dual
--trunc(ָ��������)/*�ض�ʱ���룬����������*/
select trunc(sysdate) from dual
--to_char(ָ��������,��ĸ��ʽ):����ָ����ʽ��ʱ����Ϣ
select to_char(sysdate,'ss') from dual
select * from emp where (sysdate-hiredate)/365>38
					--��������
--nvl(ֵ1��ֵ2)�� ���ֵ1Ϊ�գ��򷵻�ֵ2,��֮�򷵻�ֵ1
select empno,ename,(sal+nvl(comm,0)) from emp
--decode(ֵ1��if1,then1,if2,then2,else ):�ж�  ��Ա����н,10������10%,20������20%.....
update emp set sal=sal*decode(deptno,10,1.1,20,1.2,30,1.3,40,1.4,null,1)
select * from emp
                                  --�����Լ��ۺϺ��������ڶ��з���һ�����
--�����е�Ա��ƽ��н��
select avg(sal) ƽ������,max(sal) ��߹���,min(sal) ��͹���,sum(sal) �ܹ���,count(*) ������ from emp
--count��Ա��������:�������Ϊ��һ�ֶ���ô����ֶ�ֵΪnull�Ͳ���
select count(1) from emp
--����group by
/*
���������ôselect����ֻ��д�ۺϺ����Լ�����
*/
--���ݲ��ŷ��飬��ѯÿ�����ŵ�ƽ��н��avg()����Сн��min()�����н��max()����н��sum()����������count()
select decode(e.deptno,10,'ACCOUNTING',20,'RESEARCH',30,'SALES',40,'OPERATIONS'),avg(e.sal) ƽ������,max(e.sal) ��߹���,min(e.sal) ��͹���,sum(e.sal) �ܹ���,count(*) ������ from emp e group by e.deptno
--where���治�ܸ��ۺϺ���,whereֻ������ɸѡ����,�����������ɸѡҪ��having
select deptno, avg(sal) from emp group by deptno having avg(sal)>2000
--����ƽ�����ʵ�Ա��
select * from emp where sal>(select avg(sal) from emp)
--��ѯ10,20���ŵ�Ա����ƽ������,����ƽ������Ҫ����2000
select deptno,avg(sal) from emp where deptno in(10,20) group by deptno  having avg(sal)>2000 order by avg(sal) desc
--case when��ϰ
--��Ա����н,10������10%,20������20%....
update emp set sal=sal*(
       --��deptno���бȽ�
       case deptno 
            --�������10��ô����1.1
            when 10 then 1.1
            when 20 then 1.2
            when 30 then 1.3
            when 40 then 1.4 
            else 1 
       end
)
--ͳ��ÿ������ÿ����λ������
select deptno,count(case job when 'CLERK' then 1 else null end) CLERK,
              count(case job when 'SALESMAN' then 1 else null end) SALESMAN,
              count(case job when 'PRESIDENT' then 1 else null end) PRESIDENT,
              count(case job when 'MANAGER' then 1 else null end) MANAGER,
              count(case job when 'ANALYST' then 1 else null end) ANALYST
              from emp group by deptno
              
select distinct job from emp
