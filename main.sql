
set serveroutput on;
set verify off;

declare
			
			sell number;
begin
	sell := globalPackage.get_total_sell_of_a_date('24-sep-2019');
	dbms_output.put_line(sell);
end;
/