SELECT sname '姓名',depname '院系',datediff(YY,birthd,getdate()) '年龄'
FROM student,Dep
WHERE student.depid=dep.depid and datediff(YY,birthd,getdate())>=20 and datediff(YY,birthd,getdate())<=20;

SELECT sid '学号',sname '姓名',semail '邮件地址'
FROM student
WHERE sname like '张%';

SELECT sid '学号',cid '课程号'
FROM sc
WHERE score is not null;

SELECT student.sid '学号',sname '姓名',semail '邮件地址',tname '教师姓名',cid '课程号',score '成绩'
FROM student, sc, teacher
WHERE student.sid=sc.sid and sc.tid=teacher.tid and sc.cid='2' and score<60;

SELECT first.sid '学号'
FROM sc first, sc second
WHERE (first.cid='1' and second.cid='2')and (first.sid=second.sid) ;
