SELECT sname '姓名',datediff(YY,birthd,getdate()) '年龄' 
FROM student
WHERE datediff(YY,birthd,getdate())<any(
	SELECT datediff(YY,birthd,getdate())
	FROM student,dep
	WHERE student.depid=dep.depid and depname='Information'
	);
	
SELECT sname '姓名',depname '院系',semail '邮件地址'
FROM student,Dep
WHERE student.depid=dep.depid and NOT EXISTS (
  SELECT *
  FROM sc 
  WHERE sc.sid=student.sid);

SELECT sname '姓名'
FROM student 
WHERE NOT EXISTS (
	SELECT *
	FROM course
	WHERE cid NOT IN (
		SELECT cid
		FROM sc
		WHERE sc.sid=student.sid));
		
SELECT sname '姓名'
FROM student,sc
WHERE student.sid=sc.sid and cid='1'
INTERSECT
SELECT sname '姓名'
FROM student,SC
WHERE student.sid=sc.sid and cid='2'
