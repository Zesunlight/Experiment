UPDATE Dep
SET depname='Information'
WHERE depname='��Ϣ��ȫ'

DELETE FROM sc
WHERE cid='2' AND sid IN(
	SELECT sid 
	FROM dep,student 
	WHERE student.depid=dep.depid AND depname='�������ѧ�빤��'
)

DELETE FROM sc
WHERE cid='1' AND sid IN(
	SELECT sid 
	FROM Dep,Student 
	WHERE Student.depid=Dep.depid AND depname='�������'
)

UPDATE sc SET score='99' WHERE sid='2406010101' and cid='1';
UPDATE sc SET score='88' WHERE sid='2406010102' and cid='1';
UPDATE sc SET score='77' WHERE sid='2406010103' and cid='1';
UPDATE sc SET score='66' WHERE sid='2406020101' and cid='1';
UPDATE sc SET score='55' WHERE sid='2406020102' and cid='1';
UPDATE sc SET score='97' WHERE sid='2406030101' and cid='1';
UPDATE sc SET score='87' WHERE sid='2406010101' and cid='2';
UPDATE sc SET score='78' WHERE sid='2406010102' and cid='2';
UPDATE sc SET score='69' WHERE sid='2406010103' and cid='2';
UPDATE sc SET score='54' WHERE sid='2406020101' and cid='2';
UPDATE sc SET score='96' WHERE sid='2406020102' and cid='2';
UPDATE sc SET score='86' WHERE sid='2406030101' and cid='2';
UPDATE sc SET score='76' WHERE sid='2406010101' and cid='3';
UPDATE sc SET score='69' WHERE sid='2406010102' and cid='3';
UPDATE sc SET score='59' WHERE sid='2406010103' and cid='3';
UPDATE sc SET score='92' WHERE sid='2406020101' and cid='3';
UPDATE sc SET score='82' WHERE sid='2406020102' and cid='3';
UPDATE sc SET score='70' WHERE sid='2406030101' and cid='3';

INSERT INTO student VALUES(2406030102,'����','Ů',603,'1983/2/2',null,null);
UPDATE sc
SET sid='2406030102'
WHERE sid='2406010103';
DELETE FROM student
WHERE sid='2406010103';
