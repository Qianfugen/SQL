/*
  ��ռ䣺�����洢���û��浽���ݿ�������ݣ�������ʱ��ʹ��system��¼
*/
create tablespace pipixia
datafile 'C:\Users\28754\Desktop\tablespace\pipixia.dbf'
size 10M
autoextend on next 10M maxsize unlimited

--drop����ɾ����ռ䣬�û����������������С�����
drop tablespace oracletest
--ɾ����ռ��Լ������ļ�
drop tablespace test1 including contents and datafiles

--alter��ռ䣬�û����������������С�����
--ֻ��
alter tablespace pipixia read only

--�ɶ���д
alter tablespace pipixia read write

--select��ѯ������
select * from pipixia

--�����û�
create user pipixia identified by 123456 default tablespace pipixia

/*
ϵͳȨ�ޣ������û��Լ���ṹ�Ĳ����������¼�����������̺���������
����Ȩ�ޣ����������û��ı��ʱ�򣬸��û��������û������ɾ�Ĳ����
*/
--grant����Ȩ��
grant create session to pipixia

--����Ȩ�޻��ɫ
revoke create session from pipixia

/*
ÿ����ɫ��Ȩ���Ƕ����ģ���Ҫ��CONNECT��RESOURCE�����������Ȩ�޸�һ���û�
CONNECTȨ�ޣ����������û����������Ȩ�����ܹ����ӵ�ORACLE���ݿ���
RESOURCEȨ�ޣ����迪����Ա�ģ��� SELECT,UPDATE,INSERT,DELETE�Ȳ���
DBA:���ݿ����Ա��ɫ��ӵ�й������ݿ�����Ȩ��
*/

grant CONNECT to pipixia

--�޸��û�����
alter user pipixia identified by 654321
revoke CONNECT from pipixia





