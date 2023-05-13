CREATE DATABASE 30_questions;
USE 30_questions;
/****************************************/
/*   30 Simple SQL Interview Queries    */
/****************************************/

/*1. Delete table Employee, Department and Company.*/
DROP TABLE IF EXISTS EMPLOYEE,DEPARTMENT,COMPANY;

/*
2. Create tables:
i) Employee with attributes (id, name, city, department, salary)
ii) Department with attributes (id, name)
iii) Company with attributes (id, name, revenue)
*/
create 	TABLE 	employee(
`id` int,
`name` varchar(30),
`city` varchar(30),
`department` varchar(30),
`salary` int
);
create table department(
`id` int ,
`name` varchar(30)
);
CREATE TABLE company (
`id` int,
`name` varchar(30),
`revenue` int
);

/*
4. Add rows into Department table
(1, 'IT'),
(2, 'Management'),
(3, 'IT'),
(4, 'Support');
*/
INSERT INTO department (id,name) 
values(1,'IT'),(2,'managment'),(3,'IT'),(4,'Support');

/*
5. Add rows into Company table
(1, 'IBM', 2000000),
(2, 'GOOGLE', 9000000),
(3, 'Apple', 10000000);
*/
INSERT INTO company (id,name,revenue)
values(1, 'IBM', 2000000),
(2, 'GOOGLE', 9000000),
(3, 'Apple', 10000000);

/*
3.Add rows into employee table:
(1, 'David', 'London', 'IT', 80000),
(2, 'Emily', 'London', 'IT', 70000),
(3, 'Peter', 'Paris', 'IT', 60000),
(4, 'Ava', 'Paris', 'IT', 50000),
(5, 'Penny', 'London', 'Management', 110000),
(6, 'Jim', 'London', 'Management', 90000),
(7, 'Amy', 'Rome', 'Support', 30000),
(8, 'Cloe', 'London', 'IT', 110000);
*/
INSERT INTO employee (id,`name`,city,department,salary)
values(1, 'David', 'London', 'IT', 80000),
(2, 'Emily', 'London', 'IT', 70000),
(3, 'Peter', 'Paris', 'IT', 60000),
(4, 'Ava', 'Paris', 'IT', 50000),
(5, 'Penny', 'London', 'Management', 110000),
(6, 'Jim', 'London', 'Management', 90000),
(7, 'Amy', 'Rome', 'Support', 30000),
(8, 'Cloe', 'London', 'IT', 110000);

/*
6. Query all rows from Department table
*/
select * from department;

/*
7. Change the name of department with id =  1 to 'Management'
*/
update department 
set name='Managment'
where id=1;

/*
8. Delete employees with salary greater than 100 000
*/
delete from employee
where salary > 100000;
/*
9. Query the names of companies
*/
select `name` from company;

/*
10. Query the name and city of every employee
*/
select `name`,city from employee;

/*
11. Query all companies with revenue greater than 5 000 000
*/
select `name` from company where revenue > 5000000;
/*
12. Query all companies with revenue smaller than 5 000 000
*/
select `name` from company where revenue < 5000000;

/*
13. Query all companies with revenue smaller than 5 000 000, but you cannot use the '<' operator
*/
select `name` from company order by revenue asc limit 1;
/*version 2*/


/*
14. Query all employees with salary greater than 50 000 and smaller than 70 000
*/
select * from employee where salary between 50000 and 70000;

/*
15. Query all employees with salary greater than 50 000 and smaller than 70 000, but you cannot use BETWEEN
*/
select * from employee where salary >=50000 and salary <=70000;

/*
16. Query all employees with salary equal to 80 000
*/
select * from employee where salary=80000;
/*
17. Query all employees with salary not equal to 80 000
*/
select * from employee where salary <> 80000;

/*
18. Query all names of employees with salary greater than 70 000 
together with employees who work on the 'IT' department.
*/
select  name FROM employee
where salary > 70000
OR department IN (
	SELECT id FROM department
    WHERE name = 'IT'
);

/*
19. Query all employees that work in city that starts with 'L'
*/
select * from employee where city like "L%" ;

/*
20. Query all employees that work in city that starts with 'L' or ends with 's'
*/
select * from employee where city like "L%" or city like "%S";

/*
21. Query all employees that  work in city with 'o' somewhere in the middle
*/
select * from employee where city like "%o%";

/*
22. Query all departments (each name only once)
*/
select distinct(`name`) from department;

/*
22. Query names of all employees together with id of department they work in, but you cannot use JOIN
*/
select dp.id, em.name,dp.`name` from department as dp ,employee as em
where dp.id=em.id order by dp.id;

/*
23. Query names of all employees together with id of department they work in, using JOIN
*/
select dp.id,em.`name`,dp.`name`
from employee as em
join department as dp on em.id=dp.id
order by dp.id;

/*
24. Query name of every company together with every department
Personal thoughts: It is kinda weird question, as there is no relationship between company and departement
*/
SELECT com.name,dep.name
FROM company as com, department as dep
ORDER BY com.name;

/*
25. Query name of every company together with departments without the 'Support' department
*/
select com.name,dep.name 
from company as com, department as dep
where dep.name not like "Support" 
order by com.name;

/*
26. Query employee name together with the department name that they are not working in
*/
select emp.name,dep.name
from department as dep ,employee as emp
where dep.id <> emp.id;


/*
27. Query company name together with other companies names
LIKE:
GOOGLE Apple
GOOGLE IBM
Apple IBM
...
*/
select com1.name , com2.name 
from company as com1 , company as com2
where com1.id<>com2.id
order by com1.name,com2.name; 


/*
28. Query employee names with salary smaller than 80 000 without using NOT and <
NOTE: for POSTGRESQL only. Mysql doesn't support except
*/


/*
29.Query names of every company and change the name of column to 'Company'
*/
select `name` as Company from company ;
/*
30. Query all employees that work in same department as Peter
*/
SELECT * FROM employee
WHERE department IN(
	SELECT department FROM employee
    WHERE name LIKE 'Peter'
)
AND `name` NOT LIKE 'Peter';