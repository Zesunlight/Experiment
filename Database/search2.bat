SELECT sname '����',datediff(YY,birthd,getdate()) '����' 
FROM student
WHERE datediff(YY,birthd,getdate())<any(
	SELECT datediff(YY,birthd,getdate())
	FROM student,dep
	WHERE student.depid=dep.depid and depname='Information'
	);
	
SELECT sname '����',depname 'Ժϵ',semail '�ʼ���ַ'
FROM student,Dep
WHERE student.depid=dep.depid and NOT EXISTS (
  SELECT *
  FROM sc 
  WHERE sc.sid=student.sid);

SELECT sname '����'
FROM student 
WHERE NOT EXISTS (
	SELECT *
	FROM course
	WHERE cid NOT IN (
		SELECT cid
		FROM sc
		WHERE sc.sid=student.sid));
		
SELECT sname '����'
FROM student,sc
WHERE student.sid=sc.sid and cid='1'
INTERSECT
SELECT sname '����'
FROM student,SC
WHERE student.sid=sc.sid and cid='2'
