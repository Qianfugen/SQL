select * from studentinfo
delete from studentinfo where stuid=6
delete from studentinfo where stuid=2
update studentinfo set stunumber='002' where stuid=3
update studentinfo set stunumber='003' where stuid=4
update studentinfo set stunumber='004' where stuid=5


select * from teacherinfo
select * from studentexam
select * from classinfo
--������ѯ
--1����ѯ����ѧԱ��Ϣ
select * from studentinfo
--2����ѯ����ѧԱ�����������䣨Ҫ��������������ʾ��
select stuname "����",stuage "����" from studentinfo
--3.��ѯѧԱ�����乲���ļ���ֵ��Ҫ�󲻼����ظ��
select distinct stuage "����" from studentinfo
--4.��ѯ����Ů��ѧԱ����Ϣ
select * from studentinfo where stusex='Ů'
--5.��ѯѧ��ǰ����ѧԱ����Ϣ��Ҫ��ʹ��rownum��

--6.��ѯѧԱ��Ϣ��Ҫ����ʾЧ�����£�
select '����:'||stuname||',����:'||stuage||',��ס:'||stuaddress "ѧԱ��Ϣ" from studentinfo
--7����ѯ����С��20�꣬��ס��ɳ������ѧԱ��Ϣ
select * from studentinfo where stuage<20 and stuaddress like '��ɳ%'
--8.��ѯ������16-18��(����16,18��)��ѧԱ��Ϣ
select * from studentinfo where stuage between 16 and 18
--9����ѯ���֤�а����С�1989���ַ���ѧԱ��Ϣ
select * from studentinfo where stucard like '%1989%'
--10����ѯ��2007-3-5������ѧ��ѧԱ��Ϣ
select * from studentinfo where stujointime>date'2007-3-5'
--11����ѯ�����ַΪyahoo�İ�������Ϣ
select * from teacherinfo
select * from teacherinfo where teacheremail like '%@yahoo%'
--12����ѯ�ֻ��ԡ�139����ͷ�İ�������Ϣ
select * from teacherinfo where teachertel like '139%'
--13����ѯ���䲻Ϊ������ѧԱ��ѧ�ţ�������סַ
select stunumber,stuname,stuaddress from studentinfo where stuage is not null
--14����ѯѧ���ǡ�001��,��003��,��004����ѧԱ��������ѧʱ��
select stuname "����",stujointime "��ѧʱ��" from studentinfo where stunumber in ('001','003','004')
--15����ѯ����ѧԱ��Ϣ���������併������
select * from studentinfo order by stuage desc
--16����ѯ���гɼ��������Է����������򣬷�����ͬ�ģ���ѧԱ�����������
select * from studentexam order by examresult desc,examid
 

--�߼���ѯ
select * from studentinfo
select * from studentexam
select * from teacherinfo
select * from classinfo

update studentexam set estuid=3 where examid=5

--�������
alter table studentexam add constraint fk_studentexam_studentinfo foreign key(estuid) references studentinfo(stuid) on delete cascade

--1����ѯ�ɼ�����80�ֵ�ѧԱ�����Ϳ��Կ�Ŀ
select examsubject "��Ŀ",(select stuname from studentinfo where stuid=estuid) "����" from studentexam where examresult>80
--2����ѯ����ѧԱ��Ϣ��Ҫ����ʾ������ѧ�ţ����Կ�Ŀ�����Գɼ��������տ��Գɼ������ѧ����������
select si.stuname,si.stunumber,se.examsubject,se.examresult from studentinfo si,studentexam se where si.stuid=se.estuid order by se.examresult desc,si.stunumber
--3����ѯÿ��������Ӧ�İ��������ƣ�Ҫ����ʾ�༶���ƺͰ���������
select ci.classnumber,ti.teachername from classinfo ci,teacherinfo ti where ci.cteacherid=ti.teacherid
--4����ѯÿ������������ѧԱ��Ϣ��Ҫ����ʾ����������������������ϵ�绰���༶���ƣ�ѧԱ������ѧԱѧ�š�(3������)
select * from classinfo
select * from studentinfo
select * from studentexam
select ti.teachername ����������,ti.teachertel �����ε绰,ci.classnumber �༶����,si.stuname ѧԱ����,si.stunumber ѧԱѧ�� from studentinfo si,classinfo ci,teacherinfo ti where ti.teacherid=ci.cteacherid and ci.classid=si.sclassid
--5����ѯ����ѧԱ��Ϣ�������ڰ༶���飬Ҫ����ʾ�༶��ţ��͸ð༶����ƽ����,����ƽ���ֵĽ������򡣣�3�����ӣ�
select ci.classnumber,avg(se.examresult) from studentexam se,studentinfo si,classinfo ci where ci.classid=si.sclassid and si.stuid=se.estuid group by ci.classnumber order by avg(se.examresult) desc
--6����ѯ��ѧԱ������а������ͬһ���ѧԱ��Ϣ
select * from studentinfo where sclassid=(
select si.sclassid from studentinfo si where si.stuname='����а��')
and stuname !='����а��'
--7����ѯJava���Լ���>=60�֣���ѧԱ��ϸ��Ϣ
select * from studentinfo where stuid in (
select estuid from studentexam where examsubject='Java' and examresult>60)
--8����ѯ��ѧԱ������ա�����ͬһ����������ͬ��ѧԱ��Ϣ
select * from studentinfo where (sclassid,stuage) in(
select sclassid,stuage from studentinfo where stuname='�����')
and stuname!='�����'
--9����ѯ������С����λѧԱ�������ͼ�ͥסַ
select * from (
select stuname,stuaddress,stuage from studentinfo order by stuage) where rownum<=3
--10����ѯ���Գɼ���SQL�γ̵�ǰ�����ĳɼ���Ϣ
select * from(
select * from studentexam where examsubject='SQL' order by examresult desc) where rownum<=3
--11����ѯ���Գɼ���Java�γ̵ĵڶ����ĳɼ���Ϣ
select * from(
select e.*,rownum r from (
select * from studentexam where examsubject='Java' order by examresult desc) e) where r=2
--12����ѯѧԱ��Ϣ��ɸѡ����3-4����¼
select * from(
select si.*,rownum r from studentinfo si) where r between 3 and 4
