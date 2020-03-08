create or replace function get_top_grossing_product(X in number) 
	return varchar2 
	is 


	cur_pid number;
	
	v_pname varchar2(30);
	
	cursor records_cur is
	select pid from records@site_link group by pid order by count(pid) desc ;
	
	cursor pro_cur(id number) is
	select pname from product@site_link where pid = id;
	
	
begin 
	
	open records_cur;
	fetch records_cur into cur_pid;
	close records_cur;
	
	open pro_cur(cur_pid);
	
	fetch pro_cur into  v_pname;	
	
	close pro_cur;
	
	
	return v_pname;
end; 
/