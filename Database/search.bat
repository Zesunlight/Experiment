SELECT COUNT(*) '����'
FROM sc,course
WHERE sc.cid=course.cid and cname='���ݿ�' and score>60;

SELECT sid 'ѧ��',COUNT(cid) 'ѡ������'
FROM sc
GROUP BY sid;

SELECT sid 'ѧ��',SUM(credits) 'ѧ��'
FROM sc,course
WHERE sc.cid=course.cid
GROUP BY sid

SELECT sid 'ѧ��',SUM(score) '�ܳɼ�'
FROM sc
GROUP BY sid

SELECT sname '����',score '�ɼ�'
FROM student,sc
WHERE student.sid=sc.sid and score IN(
  SELECT MAX(score) 
  FROM sc,course
  WHERE sc.cid=course.cid and cname='���ݿ�'
  );

SELECT cname '�γ���',AVG(score) 'ƽ���ɼ�'
FROM sc,course
WHERE sc.cid=course.cid
GROUP BY cname;

SELECT cname '�γ���',COUNT(*) 'ѡ������'
FROM sc,course
WHERE sc.cid=course.cid
GROUP BY cname;

SELECT sname '����',semail '�ʼ���ַ'
FROM student,sc
WHERE student.sid=sc.sid and student.sid IN(
	SELECT sid 
	FROM student 
	GROUP BY student.sid
	HAVING COUNT(*)>5 
);
