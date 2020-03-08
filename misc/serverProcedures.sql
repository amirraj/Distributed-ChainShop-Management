create or replace procedure addEmp
	(id in number,name in varchar2)
	IS
	
begin

	insert into Employee@site_link values(id,name) ;
	commit ;
	dbms_output.put_line('Insert successful');

end addEmp;
/


create or replace procedure removeEmp
	(did in number)
	IS

begin

	delete Employee@site_link where eid = did ;
	commit ;
	dbms_output.put_line('Delete successful');

end removeEmp;
/











