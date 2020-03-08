DROP TABLE product CASCADE CONSTRAINTS;
DROP TABLE employee CASCADE CONSTRAINTS;
DROP TABLE customer CASCADE CONSTRAINTS;
DROP TABLE records CASCADE CONSTRAINTS;

CREATE TABLE product (
	pid number, 
	pname varchar2(30), 
	unit_available number, 
	unit_price number, 
        PRIMARY KEY(pid)); 
		

CREATE TABLE employee (
	eid number, 
	ename varchar2(30), 
	siteno number,
        PRIMARY KEY(eid)); 


CREATE TABLE customer (
	cid number, 
	cname varchar2(30), 
        PRIMARY KEY(cid));


CREATE TABLE records (
	cid number, 
	pid number, 
	amount number, 
	price number,
	purchase_date date,
	eid  number,
    FOREIGN KEY(pid) REFERENCES product(pid),
	FOREIGN KEY(cid) REFERENCES customer(cid)); 		
	
	
	
insert into product values(1,'Chips',7,10);
insert into product values(2,'Juice',48,25); 
insert into product values(3,'Bread',20,15); 
insert into product values(4,'Perfume',10,200);
insert into product values(5,'Chocolate',92,20); 
insert into product values(6,'Soap',60,35); 
insert into product values(7,'Cheese',20,200); 
insert into product values(8,'Oil',10,100); 
insert into product values(9,'Light Bulb',20,50); 
insert into product values(10,'T Shirt',100,150); 


insert into employee values(3,'John',2; 
insert into employee values(4,'Mark',2);


insert into customer values(1, 'Sajid');
insert into customer values(2, 'Jamal');
insert into customer values(3, 'Sami');
insert into customer values(4, 'John');
insert into customer values(5, 'Kamal');


insert into records values(1,2,2,50,'20-SEP-19',3);
insert into records values(1,3,3,45,'20-JAN-18',3);
insert into records values(2,3,5,75,'20-JAN-11',3);
insert into records values(3,5,2,40,'16-JAN-18',4);
insert into records values(2,5,3,60,'19-JAN-18',3);
insert into records values(1,5,1,20,'22-SEP-19',3);
insert into records values(1,1,2,20,'22-SEP-19',3);
insert into records values(2,5,1,20,'22-SEP-19',3);
insert into records values(4,5,1,20,'23-SEP-19',3);
insert into records values(1,1,1,10,'24-SEP-19',3);
insert into records values(5,3,2,30,'24-SEP-19',4);




 



 

 
