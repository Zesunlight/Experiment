use stud_2014060103026;

create table dep(depid varchar(8) primary key, depname varchar(20) not null);

create table teacher(tid varchar(8) primary key, tname varchar(8) not null, 
					 title varchar(10), depid varchar(20) );
					 
create table student(sid varchar(11) primary key, sname varchar(8) not null, sex char(2) not null, 
					 depid varchar(20), birthd date, semail varchar(20), homeaddr varchar(40));
					 
create table course(cid varchar(8) primary key, cname varchar(30) not null, 
					cid_pre varchar(8), credits numeric(3) not null);
					
create table sc(sid varchar(8), cid varchar(8), primary key(sid,cid ), tid varchar(8), score integer not null);
