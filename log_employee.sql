drop table emp_delete_log;
create table emp_delete_log
(empid number, siteold number, log_date date);

drop table emp_insert_log;
create table emp_insert_log
(empid number, sitenew number, log_date date);