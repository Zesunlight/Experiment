SELECT COUNT(*) '人数'
FROM sc,course
WHERE sc.cid=course.cid and cname='数据库' and score>60;

SELECT sid '学号',COUNT(cid) '选课门数'
FROM sc
GROUP BY sid;

SELECT sid '学号',SUM(credits) '学分'
FROM sc,course
WHERE sc.cid=course.cid
GROUP BY sid

SELECT sid '学号',SUM(score) '总成绩'
FROM sc
GROUP BY sid

SELECT sname '姓名',score '成绩'
FROM student,sc
WHERE student.sid=sc.sid and score IN(
  SELECT MAX(score) 
  FROM sc,course
  WHERE sc.cid=course.cid and cname='数据库'
  );

SELECT cname '课程名',AVG(score) '平均成绩'
FROM sc,course
WHERE sc.cid=course.cid
GROUP BY cname;

SELECT cname '课程名',COUNT(*) '选修人数'
FROM sc,course
WHERE sc.cid=course.cid
GROUP BY cname;

SELECT sname '姓名',semail '邮件地址'
FROM student,sc
WHERE student.sid=sc.sid and student.sid IN(
	SELECT sid 
	FROM student 
	GROUP BY student.sid
	HAVING COUNT(*)>5 
);
