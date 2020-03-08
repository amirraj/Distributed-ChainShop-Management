create or replace trigger trigger_log_employee_1
after delete
on employee
for each row

begin
	insert into emp_delete_log
	values(:old.eid, :old.siteno, sysdate);
end;
/


create or replace trigger trigger_log_employee_2
after insert
on employee
for each row

begin
	insert into emp_insert_log
	values(:new.eid, :new.siteno, sysdate);
end;
/