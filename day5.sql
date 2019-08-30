--rownum和rowid
  /*
    rownum(是查询的时候动态生成的):当使用sql语句进行查询完成的时候,oracle会自动的给每一行数据按照结果集的顺序编号
    如果作为条件取排名的时候,默认必须包含1 
    如果即有排序又有rownum系统会给每行加rownum然后在排序(主键以及有索引列除外)
  */
  select ee.* from (select e.*,rownum r from emp e where deptno=30) ee where r>3 and r<=6
  
  select e.*,rownum from emp e where rownum<=3 order by sal 
  
  select * from (select * from emp order by sal) where rownum<=3
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
  select e.*,rowid from emp e
  select min(rowid) from emp 
                               --分析函数：用来计算排名
 /*
 分析函数和聚合函数的区别就是分析函数会返回多行数据
 */                              
--rank() over():存在并列的情况 ，会发生跳跃
--dense_rank() over():存在并列的情况 ，不会发生跳跃
--row_number() over():不存在并列的情况 ，不会发生跳跃
--在分析函数中使用partition by代表sql语句中的group by
select e.empno,e.ename,e.sal,e.deptno,
       rank()over(partition by deptno order by sal) ro,
       dense_rank()over(partition by deptno order by sal) do,
       row_number()over(partition by deptno order by sal) rno
from emp e
select * from (select e.*,row_number()over(partition by deptno order by sal desc)ro from emp e ) where ro=1
--查询出第5-8个员工记录
select * from emp
--方式一:一页显示3条数据
select * from(
       select e.*,rownum rn from(
              select * from emp where deptno=30 order by sal) e) where rn>3 and rn<=6  
--方式二：
select * from(
       select e.*,row_number()over(order by sal) ro from emp e where deptno=30) where ro>3 and ro<=6
--删除重复数据
delete from emp where 
       --删除全部重复数据
       (empno,ename)in(select empno,ename from emp group by empno,ename having count(*)>1)
       and 
       --不包括rowid最小的那一行
       rowid not in (select min(rowid) from emp group by empno,ename having count(*)>1)
       




