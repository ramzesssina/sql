create database office default character set = 'utf8';
show create database office;
use office;

create table department (
	id int auto_increment key,
	`name` varchar(200) not null unique)
;

create table employee (
	id int auto_increment key,
	`name` varchar(100),
	salary int)
;

alter table employee
	add column department_id int default null,
	add foreign key (department_id) references department(id),
	add column chief_id int default null,
	add foreign key (chief_id) references employee(id)
;

insert into department(`name`) values
	("Отдел продаж"),
	("Отдел технической поддержки"),
	("Бухгалтерия"),
	("Отдел маркетинга"),
	("Отдел кадров"),
    ("Отдел рекламы")
;

insert into employee(department_id, chief_id, `name`, salary) values
	(1, null, "Белов Владимир Александрович", 150000),
	(1, 1,"Федорова Полина Дмитриевна", 130000),
	(1, 1,"Комаров Андрей Егорович", 134567),
    
	(2, null, "Степанов Владимир Павлович", 201123),
	(2, 4, "Ермолаев Тимофей Романович", 156040),
    
	(3, null, "Козырев Кирилл Станиславович", 175938),
	(3, 6, "Анохин Арсений Николаевич", 208400),
	(3, 6, "Фролова Анастасия Руслановна", 172300),
	(3, 6, "Ковалева Вера Романовна", 104500),
	(3, 6, "Коновалова Диана Артёмовна", 91870),
    
	(4, null, "Герасимова Александра Александровна", 200156),
	(4, 11, "Филатова Татьяна Никитична", 131430),
    
	(5, null, "Федосеева Анастасия Алексеевна", 120432),
	(5, 13, "Фадеева Алиса Евгеньевна", 130433),
	(5, 13, "Карпов Марк Маркович", 87940),
    
    (6, 11, "Зайцев Андрей Романович", 175907),
	(6, 11, "Дегтярева Анна Дамировна", 95026),
	(6, 11, "Орлова Мария Фёдоровна", 93112)
;

select * from employee;

#Задание 1
select e.`name`, e.salary 
from employee e, employee em
where em.id = e.chief_id and e.salary > em.salary;

#Zadanie 2
select e.`name`, e.salary, d.`name`
from employee e join department d on e.department_id = d.id
where e.salary = ( select MAX(salary) from employee em where em.department_id = e.department_id )
;

#Zadanie 3
select department_id, COUNT(id) 
from employee 
group by department_id having count(id) <= 3
;

#Zadanie 4
select e.name as 'имя сотрудника', e.salary as 'Зарплата', d.name as 'название отдела', chief.name as 'имя шефа', chief_dep.name as 'название отдела' 
from employee e
join department d on e.department_id = d.id
join employee chief on e.chief_id = chief.id
join department chief_dep on chief.department_id = chief_dep.id
where e.department_id != chief.department_id;# Руководитель в другом отделе

select * from employee;

#Zadanie 5
select department_id, sum(salary) salary
from employee group by department_id having 
sum(salary) = (select sum(salary) from employee group by department_id order by sum(salary) desc limit 1);