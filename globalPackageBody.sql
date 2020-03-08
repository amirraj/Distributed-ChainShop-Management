create or replace package body globalPackage as 
		
	procedure transfer_employee
	(site_no in number, v_eid in number, v_ename in varchar2)
	IS
	

	begin
		if site_no = 1 then 
			delete employee@site3 where eid = v_eid ;
			delete employee where eid = v_eid ;
			insert into employee@site1 values(v_eid,v_ename,1);
			commit ;

		elsif site_no = 2 then 
			delete employee@site3 where eid = v_eid ;
			delete employee@site1 where eid = v_eid ;
			insert into employee values(v_eid,v_ename,2);
			commit ;
			
		elsif site_no = 3 then 
			delete employee@site1 where eid = v_eid ;
			delete employee where eid = v_eid ;
			insert into employee@site3 values(v_eid,v_ename,3);
			commit ;
			
		end if;
	end transfer_employee;
	
	
	function get_total_sell_of_a_date(input_date in date)
	return number
	IS
	
	total number := 0;
	total_sell number;
	
	cursor sell_cur1 is
	select sum(price) from records@site1 where purchase_date = input_date;
	
	cursor sell_cur2 is
	select sum(price) from records where purchase_date = input_date;
	
	cursor sell_cur3 is
	select sum(price) from records@site3 where purchase_date = input_date;
	
	begin 
	
	open sell_cur1;
	     fetch sell_cur1 into total_sell ;
	close sell_cur1;
	total := total + total_sell ;
	
	open sell_cur2;
	     fetch sell_cur2 into total_sell ;
	close sell_cur2;
	total := total + total_sell ;
	
	open sell_cur3;
	     fetch sell_cur3 into total_sell ;
	close sell_cur3;
	
	total := total + total_sell ;
    return total ; 
	end get_total_sell_of_a_date;


	procedure give_discount
	(site_no in number, day_no in number, parcentage in number)
	IS
	
	todays_date date := sysdate;
	begin
		if site_no = 1 then
			delete discount@site1 ;
			for i in 1 .. day_no
			loop
				insert into discount@site1 values(todays_date, parcentage);
				todays_date := to_date(todays_date) + 1;
				commit;
			end loop;
		elsif site_no = 2 then

				delete discount ;
				for i in 1 .. day_no
			loop
				insert into discount values(todays_date, parcentage);
				todays_date := to_date(todays_date) + 1;
				commit;
			end loop;
			
		elsif site_no = 3 then
				delete discount@site3 ;
				for i in 1 .. day_no
			loop
				insert into discount values(todays_date, parcentage);
				todays_date := to_date(todays_date) + 1;
				commit;
			end loop;
		end if;
		commit ;
	end give_discount;
	
	procedure add_product
	( id in product.pid%TYPE,
	  name in product.pname%TYPE,
	  avail in product.unit_available%TYPE,
	  price in product.unit_price%TYPE,
	  siteno in number) 
	IS
 
	
begin 
	 if siteno = 1 then
	insert into product@site1 (pid, pname, unit_available, unit_price) values (id, name, avail, price);
	commit;	
	elsif siteno = 2 then
	insert into product (pid, pname, unit_available, unit_price) values (id, name, avail, price);
	commit;
	elsif siteno = 3 then
	insert into product@site3 (pid, pname, unit_available, unit_price) values (id, name, avail, price);
	commit;
	
	end if;
	
end add_product;

end globalPackage; 
/