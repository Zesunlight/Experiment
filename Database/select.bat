SELECT sname '����',depname 'Ժϵ',datediff(YY,birthd,getdate()) '����'
FROM student,Dep
WHERE student.depid=dep.depid and datediff(YY,birthd,getdate())>=20 and datediff(YY,birthd,getdate())<=20;

SELECT sid 'ѧ��',sname '����',semail '�ʼ���ַ'
FROM student
WHERE sname like '��%';

SELECT sid 'ѧ��',cid '�γ̺�'
FROM sc
WHERE score is not null;

SELECT student.sid 'ѧ��',sname '����',semail '�ʼ���ַ',tname '��ʦ����',cid '�γ̺�',score '�ɼ�'
FROM student, sc, teacher
WHERE student.sid=sc.sid and sc.tid=teacher.tid and sc.cid='2' and score<60;

SELECT first.sid 'ѧ��'
FROM sc first, sc second
WHERE (first.cid='1' and second.cid='2')and (first.sid=second.sid) ;
