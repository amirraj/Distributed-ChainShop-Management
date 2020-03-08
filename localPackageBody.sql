create or replace package body localPackage as 

	 procedure sell_product
	( v_pid in number,
	  v_cid in number,
	  v_cname in varchar2,
	  v_amount in number,
	  buy_date in varchar2,
	  v_eid in number)
	  IS

cur_pid number;
cur_pname varchar2(30);
cur_avail number;
cur_price number;
total_price number := 0;

new_amount number;

cur_cid number;
cur_cname varchar2(30);

cur_date date;
cur_percentage number;

cursor product_cur is 
	select * from product where pid = v_pid ;


cursor customer_cur is 
	select * from customer where cid = v_cid ;
	
cursor discount_cur is 
	select * from discount where discount_date = '9-oct-2019';
	
begin 
	open customer_cur;
	
	fetch customer_cur into cur_cid,cur_cname;
	if customer_cur%notfound then
	insert into customer values (v_cid,v_cname);
		commit;
	end if;
	
	close customer_cur;
	
	
	
	open product_cur ;
	
	fetch product_cur into cur_pid,cur_pname,cur_avail,cur_price ;
	
	
	
	if cur_avail >= v_amount then
		
		new_amount := cur_avail - v_amount;
		
		update product set unit_available = (cur_avail - v_amount) where pid = v_pid ;
		
		total_price := v_amount * cur_price;
		
		open discount_cur;
			fetch discount_cur into cur_date, cur_percentage;
			if customer_cur%found then
			  DBMS_OUTPUT.PUT_LINE('Sorry not enough product available !');
			  total_price := total_price - total_price * cur_percentage/100;
			end if;
			
		close discount_cur;
		
		insert into records(cid, pid, amount, price, purchase_date,eid) values (v_cid,v_pid,v_amount,total_price,buy_date,v_eid); 
		
	elsif cur_avail < v_amount then
		DBMS_OUTPUT.PUT_LINE('Sorry not enough product available !');
		
	end if;
	
	if new_amount = 0 then
	   DBMS_OUTPUT.PUT_LINE('Product ' || cur_pname|| ' has just been sold out !');
	end if;
	
	commit;	
	close product_cur ;

exception
		
	when no_data_found then
      dbms_output.put_line('Not found');
	

end sell_product;



 procedure update_product
	( v_pid in number,
	v_amount in number) 
	IS
	

cur_avail number;

	
	
 cursor update_cur is 
	select unit_available from product where pid = v_pid ;

	
begin 
	open update_cur;
	
	fetch update_cur into cur_avail;
	
	update product
	set unit_available = (v_amount + cur_avail)
	where pid = v_pid;
	commit;	
	
	close update_cur ;

end update_product; 



function get_top_grossing_product(X in number) 
	return varchar2 
	is 


	cur_pid number;
	
	v_pname varchar2(30);
	
	cursor records_cur is
	select pid from records group by pid order by count(pid) desc ;
	
	cursor pro_cur(id number) is
	select pname from product where pid = id;
	
	
begin 
	
	open records_cur;
	fetch records_cur into cur_pid;
	close records_cur;
	
	open pro_cur(cur_pid);
	
	fetch pro_cur into  v_pname;	
	
	close pro_cur;
	
	
	return v_pname;
end; 

end localPackage; 
/