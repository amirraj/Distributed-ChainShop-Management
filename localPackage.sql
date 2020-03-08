create or replace package localPackage as 
	  
	   procedure sell_product
	( v_pid in number,
	  v_cid in number,
	  v_cname in varchar2,
	  v_amount in number,
	  buy_date in varchar2,
	  v_eid in number) ;
	  
	  procedure update_product
	  ( v_pid in number,
		v_amount in number);
		
	function get_top_grossing_product(X in number) 
	return varchar2 ;
	  
end localPackage; 
/