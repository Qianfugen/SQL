--rownum��rowid
  /*
    rownum(�ǲ�ѯ��ʱ��̬���ɵ�):��ʹ��sql�����в�ѯ��ɵ�ʱ��,oracle���Զ��ĸ�ÿһ�����ݰ��ս������˳����
    �����Ϊ����ȡ������ʱ��,Ĭ�ϱ������1 
    ���������������rownumϵͳ���ÿ�м�rownumȻ��������(�����Լ��������г���)
  */
  select ee.* from (select e.*,rownum r from emp e where deptno=30) ee where r>3 and r<=6
  
  select e.*,rownum from emp e where rownum<=3 order by sal 
  
  select * from (select * from emp order by sal) where rownum<=3
  /*
  ����rowid��Ҫ10���ֽڻ�����80��λ������λ����80��������λ�ֱ��ǣ�
      1. ���ݶ����ţ������������������ݿ����ı�ţ�ÿ�����ݶ��������ݿ⽨����ʱ�򶼱�Ψһ����һ����ţ����Ҵ˱��Ψһ�����ݶ�����ռ�ô�Լ32λ��
      2. ��Ӧ�ļ���ţ��������������ļ��ı�ţ���ռ��ÿһ���ļ���Ŷ���Ψһ�ġ��ļ������ռ�õ�λ����10λ��
      3. ���ţ��������������ļ��Ŀ��λ�ÿ�����Ҫ22λ��
      4. �б�ţ�������������Ŀ¼�еľ���λ���б����Ҫ16λ��  
  Oracle��������չROWID��18λ��ÿλ����64λ���룬�ֱ���A~Z��a~z��0~9��+��/��64���ַ���ʾ��
  A��ʾ0��B��ʾ1������Z��ʾ25��a��ʾ26������z��ʾ51��0��ʾ52��������9��ʾ61��+��ʾ62��/��ʾ63��
  rowid:�����ǲ������ݵ�ʱ��oracle��������ݵ�������������һ��18λ��64λ������ַ�����ΪΨһ��ʶ,
  �ǲ��ᷢ���ı��
  */
  select e.*,rowid from emp e
  select min(rowid) from emp 
                               --����������������������
 /*
 ���������;ۺϺ�����������Ƿ��������᷵�ض�������
 */                              
--rank() over():���ڲ��е���� ���ᷢ����Ծ
--dense_rank() over():���ڲ��е���� �����ᷢ����Ծ
--row_number() over():�����ڲ��е���� �����ᷢ����Ծ
--�ڷ���������ʹ��partition by����sql����е�group by
select e.empno,e.ename,e.sal,e.deptno,
       rank()over(partition by deptno order by sal) ro,
       dense_rank()over(partition by deptno order by sal) do,
       row_number()over(partition by deptno order by sal) rno
from emp e
select * from (select e.*,row_number()over(partition by deptno order by sal desc)ro from emp e ) where ro=1
--��ѯ����5-8��Ա����¼
select * from emp
--��ʽһ:һҳ��ʾ3������
select * from(
       select e.*,rownum rn from(
              select * from emp where deptno=30 order by sal) e) where rn>3 and rn<=6  
--��ʽ����
select * from(
       select e.*,row_number()over(order by sal) ro from emp e where deptno=30) where ro>3 and ro<=6
--ɾ���ظ�����
delete from emp where 
       --ɾ��ȫ���ظ�����
       (empno,ename)in(select empno,ename from emp group by empno,ename having count(*)>1)
       and 
       --������rowid��С����һ��
       rowid not in (select min(rowid) from emp group by empno,ename having count(*)>1)
       




