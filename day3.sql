--���:���������������������
select * from student
select * from cla
/*
�����֮��Ĺ�ϵ
       һ�Զ�:����༶��ѧ���Ĺ�ϵ
         һ��һ���ǰ༶,���һ������ѧ��,�ڶ��һ�����������������һ��һ��
       ��Զ�:...........
*/
--��ѧ�������һ���ֶ�,��Ϊ�����༶������
alter table student add (claid number(5))
--�����༶��
create table cla(
       id number(5) primary key,
       claid number(5) not null,
       name varchar2(50) not null
)
--��student��claid������,��������cla�����������id
alter table student add constraint for_student_cla foreign key(claid) references cla(id)
insert into cla(id,claid,name)values(1,31,'31��');
insert into cla(id,claid,name)values(2,35,'35��');
insert into cla(id,claid,name)values(3,38,'38��');
commit;
insert into student(id,name,age,birdate,claid) values (seq_student.nextval,'cc',33,sysdate,2)
insert into student(id,name,age,birdate,claid) values (seq_student.nextval,'dd',12,sysdate,3)
--ɾ���༶35��:Ĭ��ɾ�����ɹ�
delete from cla where id=2
/*
�����������:������ɾ��һ��һ�����ݿ��ʱ��,���һ������ֶ���δ���
       no action:ɾ�������б������е�����ʱ������ӱ���������а�����ֵ�����ֹ�ò���ִ��
       set null:ɾ�������б������е�����ʱ�����ӱ�����Ӧ�����е�ֵ����ΪNULLֵ
       cascade:ɾ�������б������е�����ʱ������ɾ���ӱ�����Ӧ��������
*/
alter table student drop constraint  for_student_cla;
--������Լ��,ʹ�� set null��������
alter table student add constraint for_student_cla foreign key(claid) references cla(id) on delete cascade
                                   --�򵥲�ѯ  
grant all on scott.dept to java38   
create table dept as select * from scott.dept                                                                                     
--��ѯ����Ա����Ϣ
select * from emp
--��ѯ��Ա����ţ�������н��
--�����ݿ�����ؼ����Լ��ֶ������ǲ����ִ�Сд��,�����ֶε�ֵ���ִ�Сд
select empno,ename,sal from emp
--��ѯ��Ա����ţ�������н�� ��������ʾ����
select e.empno "Ա�����",e.ename "����",e.sal "н��" from emp e
--��ѯ��Ա����ţ�������н�� ƴ����һ������ʾ:Ա�����:8329,����:dsa,����:3453
--��oracle�����ƴ�ӷ�Ϊ:||,��java����Ϊ+
select  'Ա�����:'||empno||',����:'||ename||',����:'||sal "����" from emp
--��ѯ30�Ų��ŵ�����Ա��
select * from emp where deptno=30
--��ѯ��30�Ų�������Ա������Щ������λ:distinctȥ�ظ�
select distinct(job) from emp where deptno=30
--�����ֶζ��ظ��������ظ�
select distinct * from emp where deptno=30
--ֻ�й��ʺ͸�λ���ظ���ʱ��������ظ�,���ҽ��ֻ����ʾ���ʺ͸�λ
select distinct sal,job from emp where deptno=30
--��ѯ��30�Ų���,��λΪSALESMAN��Ա��
select * from emp where deptno=30 and job='SALESMAN'
--��ѯ��������30�Ų��������Ա��
select * from emp where deptno!=30
--��ѯԱ��н�� >=2000 and <=3000 ��Ա��
select * from emp where sal>=2000 and sal<=3000 and deptno=30
select * from emp where sal between 2000 and 3000
--��ѯ��20,30���������Ա����Ϣ
select * from emp where deptno=20 or deptno=30
select * from emp where deptno in(20,30)
--��ѯ��û���ϼ���Ա����Ϣ
--is null:Ϊ��,is not null:��Ϊ��
select * from emp where mgr is null
--��ѯ���ϼ���Ա����Ϣ
select * from emp where mgr is not null
                               --�߼���ѯ
/*
       ģ��ƥ�䣺like
        %:��ʾƥ��������ַ�
        _:��ʾƥ��һ���ַ�
*/
--��ѯԱ������������S'��Ա��
select  * from emp where ename like '%S%'
--��ѯԱ�������������ַ�Ϊ��C'��Ա��
select  * from emp where ename like '_C%'
--����Ա���Ĺ��ʽ�������:desc����,asc����
select * from emp order by sal desc,comm
--��30���ŵ�Ա�������ʽ�������
select * from emp where deptno=30 order by sal desc
/*
�Ӳ�ѯ:sql����Ƕ��,�����sql�����Ӿ�,����Ľ�����,һ��sql����ѯ�����Ľ��������Ϊһ�������,
        ����һ��sql�����Դ�������������ٴβ�ѯ������
        �����Ӳ�ѯ:�Ӿ�ֻ����һ�����
        �����Ӳ�ѯ:�Ӿ�ֻ���ض�����
����Ӳ�ѯ:�Ӿ��ڲ�ѯ�Ĺ����л��õ������ĳ���ֶ���Ϊ����,����ÿִ��һ����¼,�Ӿ�ͻ�ִ��һ��
������Ӳ�ѯ:�Ӿ�ִֻ��һ��,ִ�н����������ʹ��
*/
--��ѯ����SALES������(dept)�����Ա����Ϣ(emp):��where��������ʹ���Ӳ�ѯ
        --���ݲ������Ʋ�ѯ���ű��
        select deptno from dept where dname='SALES'
        --���ݲ��ű�Ų�ѯԱ����Ϣ
        select * from emp where deptno=30
select * from emp where deptno=(select deptno from dept where dname='SALES')
--�г�н��ȡ�SMITH���������Ա��
select * from emp where sal>(select sal from emp where ename='SMITH')
--��ѯ����Ա����SCOTT����ͬһ�����ŵ�Ա��
select * from emp where deptno in (select deptno from emp where ename='SCOTT') and ename!='SCOTT'
--����Ӳ�ѯ������select��ʹ���Ӳ�ѯ:��ѯ��Ա����ţ�������job��н�ʣ��Լ����ڲ�������
select e.empno "���",e.ename "����",e.job "��λ",e.sal "����",(select d.dname from dept d where d.deptno=e.deptno) "����" from emp e
--����Ӳ�ѯ:�г�����Ա������������ֱ���ϼ�������
--e1 Ա����,e2 ��˾��
select e1.ename "Ա������",(select e2.ename from emp e2 where e2.empno=e1.mgr) "ֱ����˾" from emp e1
--exists :�жϺ�����Ӿ���û�в�ѯ�����,�����ѯ���������true���򷵻�false
select d.* from dept d  where not exists (select e.ename from emp e where e.deptno=d.deptno)
--not exists:�෴
--��ѯ����Ա���Ĳ�����Ϣ
