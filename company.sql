create database company default character set = 'utf8';
show create database company;
use company;

create table employees (
  ID int not null,
  `name` varchar(100) not null,
  `status` int not null,
  PRIMARY KEY (ID))
;

create table `client` (
  ID int not null,
  `name` varchar(100) not null,
  primary key (ID))
;

create table contracts (
  ID int not null,
  clientID int not null,
  `date` date,
  enddate date,
  primary key (ID),
  INDEX `fk_contracts_client1_idx` (clientID ASC) VISIBLE,
  CONSTRAINT `fk_contracts_client1`
    FOREIGN KEY (clientID)
    REFERENCES `client` (ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE TABLE orders (
  ID INT NOT NULL,
  contractsID INT NOT NULL,
  employeesID INT NOT NULL,
  `date` DATE NOT NULL,
  enddate DATE NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (ID),
  INDEX `fk_orders_contracts1_idx` (contractsID ASC) VISIBLE,
  INDEX `fk_orders_employees1_idx` (employeesID ASC) VISIBLE,
  CONSTRAINT `fk_orders_contracts1`
    FOREIGN KEY (contractsID)
    REFERENCES contracts (ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_employees1`
    FOREIGN KEY (employeesID)
    REFERENCES employees (ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE TABLE transport_company (
  ID INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (ID),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
;

CREATE TABLE transport (
  ID INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  companyID INT NOT NULL,
  PRIMARY KEY (ID, companyID),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  INDEX `fk_transport_transport_company_idx` (companyID ASC) VISIBLE,
  CONSTRAINT `fk_transport_transport_company`
    FOREIGN KEY (companyID)
    REFERENCES transport_company (ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE TABLE deliveries (
  ID INT NOT NULL,
  transportID INT NOT NULL,
  companyID INT NOT NULL,
  price INT NOT NULL,
  PRIMARY KEY (ID, transportID, companyID),
  INDEX `fk_deliveries_transport1_idx` (transportID ASC, companyID ASC) VISIBLE,
  CONSTRAINT `fk_deliveries_transport1`
    FOREIGN KEY (transportID , companyID)
    REFERENCES transport (ID , companyID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE TABLE suppliers (
  ID INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (ID))
;

CREATE TABLE products (
  ID INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  price INT NOT NULL,
  suppliersID INT NOT NULL,
  countc int not null,
  type_of_cargo varchar(100) not null,
  `date` date not null,
  PRIMARY KEY (ID),
  INDEX `fk_products_suppliers1_idx` (suppliersID ASC) VISIBLE,
  CONSTRAINT `fk_products_suppliers1`
    FOREIGN KEY (suppliersID)
    REFERENCES suppliers (ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE TABLE type_of_application (
  ID INT NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (ID))
;

CREATE TABLE orders_has_products (
  ID INT NOT NULL,
  ordersID int not null,
  deliveriesID INT NULL,
  transportID INT NULL,
  companyID INT NULL,
  productsID INT NOT NULL,
  type_of_applicationID INT NULL,
  productprice INT NOT NULL,
  amount VARCHAR(45) NOT NULL,
  delivery_price decimal(10,2) null,
  PRIMARY KEY (ID, productsID),
  index `fk_orders_has_products_orders1_idx` (ordersID asc) visible,
  INDEX `fk_orders_has_products_deliveries1_idx` (deliveriesID ASC, transportID ASC, companyID ASC) VISIBLE,
  INDEX `fk_orders_has_products_products1_idx` (productsID ASC) VISIBLE,
  INDEX `fk_orders_has_products_type_of_application1_idx` (type_of_applicationID ASC) VISIBLE,
  constraint `fk_orders_has_products_orders1_idx`
	foreign key (ordersID)
    references orders (ID)
    on delete no action
    on update no action,
  CONSTRAINT `fk_orders_has_products_orders1`
    FOREIGN KEY (ID)
    REFERENCES orders (ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_has_products_deliveries1`
    FOREIGN KEY (deliveriesID , transportID , companyID)
    REFERENCES deliveries (ID , transportID , companyID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_has_products_products1`
    FOREIGN KEY (productsID)
    REFERENCES products (ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_has_products_type_of_application1`
    FOREIGN KEY (type_of_applicationID)
    REFERENCES type_of_application (ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

START TRANSACTION;
INSERT INTO employees (ID, `name`, `status`) VALUES (1, 'Беспалов Роман Иванович', 5);
INSERT INTO employees (ID, `name`, `status`) VALUES (2, 'Леонтьева Анастасия Тимофеевна', 2);
INSERT INTO employees (ID, `name`, `status`) VALUES (3, 'Кольцова Виктория Робертовна', 1);
INSERT INTO employees (ID, `name`, `status`) VALUES (4, 'Зимина Ольга Савельевна', 7);
INSERT INTO employees (ID, `name`, `status`) VALUES (5, 'Князева Ульяна Егоровна', 6);
INSERT INTO employees (ID, `name`, `status`) VALUES (6, 'Балашова Екатерина Ибрагимовна', 1);
INSERT INTO employees (ID, `name`, `status`) VALUES (7, 'Сычев Максим Даниилович', 1);
INSERT INTO employees (ID, `name`, `status`) VALUES (8, 'Кириллов Илья Артёмович', 1);
INSERT INTO employees (ID, `name`, `status`) VALUES (9, 'Сорокин Антон Андреевич', 1);
INSERT INTO employees (ID, `name`, `status`) VALUES (10, 'Березина Алёна Марковна', 1);

COMMIT;

START TRANSACTION;
INSERT INTO `client` (ID, `name`) VALUES (1, 'Streetbeat');
INSERT INTO `client` (ID, `name`) VALUES (2, 'Zara');
INSERT INTO `client` (ID, `name`) VALUES (3, 'Lacost');
INSERT INTO `client` (ID, `name`) VALUES (4, 'MAG');
INSERT INTO `client` (ID, `name`) VALUES (5, 'Золушка');

COMMIT;

START TRANSACTION;
INSERT INTO contracts (ID, `clientID`, `date`, enddate) VALUES (1, 1, '2024-09-01', '2025-12-31');
INSERT INTO contracts (ID, `clientID`, `date`, enddate) VALUES (2, 2, '2024-09-06', '2025-12-31');
INSERT INTO contracts (ID, `clientID`, `date`, enddate) VALUES (3, 3, '2024-07-01', '2025-12-31');
INSERT INTO contracts (ID, `clientID`, `date`, enddate) VALUES (4, 4, '2025-01-25', '2025-12-31');
INSERT INTO contracts (ID, `clientID`, `date`, enddate) VALUES (5, 5, '2024-10-23', '2025-12-31');
INSERT INTO contracts (ID, `clientID`, `date`, enddate) VALUES (6, 1, '2025-04-23', '2025-12-31');
INSERT INTO contracts (ID, `clientID`, `date`, enddate) VALUES (7, 2, '2024-09-14', '2025-12-31');

ALTER TABLE contracts ADD COLUMN duration_days INT DEFAULT 0;

COMMIT;

START TRANSACTION;
INSERT INTO orders (ID, contractsID, employeesID, `date`, enddate, `status`) VALUES (1, 1, 1, '2025-03-04', '2025-04-04', 'Отменен');
INSERT INTO orders (ID, contractsID, employeesID, `date`, enddate, `status`) VALUES (2, 1, 1, '2024-08-01', '2024-09-01', 'Доставлен');
INSERT INTO orders (ID, contractsID, employeesID, `date`, enddate, `status`) VALUES (3, 2, 1, '2025-01-26', '2025-02-26', 'Доставлен');
INSERT INTO orders (ID, contractsID, employeesID, `date`, enddate, `status`) VALUES (4, 2, 2, '2025-02-03', '2025-03-28', 'Доставлен');
INSERT INTO orders (ID, contractsID, employeesID, `date`, enddate, `status`) VALUES (5, 2, 2, '2024-12-11', '2025-01-11', 'Доставлен');
INSERT INTO orders (ID, contractsID, employeesID, `date`, enddate, `status`) VALUES (6, 2, 2, '2024-11-29', '2025-01-29', 'Доставлен');
INSERT INTO orders (ID, contractsID, employeesID, `date`, enddate, `status`) VALUES (7, 2, 2, '2024-11-09', '2025-01-09', 'Доставлен');
INSERT INTO orders (ID, contractsID, employeesID, `date`, enddate, `status`) VALUES (8, 2, 3, '2024-10-27', '2024-11-27', 'Передан доставщику');
INSERT INTO orders (ID, contractsID, employeesID, `date`, enddate, `status`) VALUES (9, 3, 3, '2025-02-15', '2025-04-15', 'Передан доставщику');
INSERT INTO orders (ID, contractsID, employeesID, `date`, enddate, `status`) VALUES (10, 3, 3, '2024-11-29', '2024-12-29', 'Доставлен');
INSERT INTO orders (ID, contractsID, employeesID, `date`, enddate, `status`) VALUES (11, 4, 4, '2025-02-04', '2025-03-20', 'Передан доставщику');
INSERT INTO orders (ID, contractsID, employeesID, `date`, enddate, `status`) VALUES (12, 4, 4, '2025-01-30', '2025-02-21', 'Передан доставщику');
INSERT INTO orders (ID, contractsID, employeesID, `date`, enddate, `status`) VALUES (13, 4, 4, '2025-01-28', '2025-02-28', 'Передан доставщику');
INSERT INTO orders (ID, contractsID, employeesID, `date`, enddate, `status`) VALUES (14, 4, 5, '2024-11-20', '2024-12-20', 'Передан доставщику');
INSERT INTO orders (ID, contractsID, employeesID, `date`, enddate, `status`) VALUES (15, 4, 5, '2025-02-14', '2025-03-14', 'В пункте самовывоза');
INSERT INTO orders (ID, contractsID, employeesID, `date`, enddate, `status`) VALUES (16, 4, 5, '2024-12-02', '2025-01-08', 'В пункте самовывоза');
INSERT INTO orders (ID, contractsID, employeesID, `date`, enddate, `status`) VALUES (17, 5, 6, '2024-06-21', '2024-07-21', 'Ждёт обработки');
INSERT INTO orders (ID, contractsID, employeesID, `date`, enddate, `status`) VALUES (18, 5, 7, '2024-07-11', '2024-08-11', 'Доставлен');
INSERT INTO orders (ID, contractsID, employeesID, `date`, enddate, `status`) VALUES (19, 5, 8, '2025-01-27', '2025-02-27', 'Доставлен');
INSERT INTO orders (ID, contractsID, employeesID, `date`, enddate, `status`) VALUES (20, 5, 9, '2025-02-06', '2025-03-06', 'Доставлен');
INSERT INTO orders (ID, contractsID, employeesID, `date`, enddate, `status`) VALUES (21, 5, 10, '2024-12-01', '2025-01-15', 'Доставлен');
INSERT INTO orders (ID, contractsID, employeesID, `date`, enddate, `status`) VALUES (22, 1, 1, '2024-06-21', '2024-07-21', 'Доставлен');
INSERT INTO orders (ID, contractsID, employeesID, `date`, enddate, `status`) VALUES (23, 2, 2, '2024-06-21', '2024-07-21', 'Доставлен');
INSERT INTO orders (ID, contractsID, employeesID, `date`, enddate, `status`) VALUES (24, 3, 3, '2024-06-21', '2024-07-21', 'Доставлен');
COMMIT;

ALTER TABLE orders ADD COLUMN orders_total INT DEFAULT 0;
ALTER TABLE orders ADD COLUMN discount INT DEFAULT 0;
ALTER TABLE orders ADD COLUMN employee_payment INT DEFAULT 0;

START TRANSACTION;
INSERT INTO transport_company (ID, `name`) VALUES (1, 'Транзит 27');
INSERT INTO transport_company (ID, `name`) VALUES (2, 'ПЭК');
INSERT INTO transport_company (ID, `name`) VALUES (3, 'Байкал Сервис');
INSERT INTO transport_company (ID, `name`) VALUES (4, 'Привоз');
INSERT INTO transport_company (ID, `name`) VALUES (5, 'Перевозчик');

COMMIT;

START TRANSACTION;
INSERT INTO transport (ID, `name`, companyID) VALUES (1, 'Тягач DAF', 1);
INSERT INTO transport (ID, `name`, companyID) VALUES (2, 'Тягач Freightliner', 1);
INSERT INTO transport (ID, `name`, companyID) VALUES (3, 'Самолет Basler BT-67', 2);
INSERT INTO transport (ID, `name`, companyID) VALUES (4, 'Самолет Canadair CL-44', 3);
INSERT INTO transport (ID, `name`, companyID) VALUES (5, 'Корабль Сухогруз', 3);
INSERT INTO transport (ID, `name`, companyID) VALUES (6, 'Грузовик ГАЗель', 4);
INSERT INTO transport (ID, `name`, companyID) VALUES (7, 'Грузовик Demio', 4);
INSERT INTO transport (ID, `name`, companyID) VALUES (8, 'Грузовик Renault Master', 5);

COMMIT;

START TRANSACTION;
INSERT INTO deliveries (ID, transportID, companyID, price) VALUES (1, 1, 1, 21200); # Минимальная стоимость доставки у доставщиков
INSERT INTO deliveries (ID, transportID, companyID, price) VALUES (2, 2, 1, 31000);
INSERT INTO deliveries (ID, transportID, companyID, price) VALUES (3, 3, 2, 36000);
INSERT INTO deliveries (ID, transportID, companyID, price) VALUES (4, 4, 3, 122350);
INSERT INTO deliveries (ID, transportID, companyID, price) VALUES (5, 5, 3, 92800);
INSERT INTO deliveries (ID, transportID, companyID, price) VALUES (6, 6, 4, 11300);
INSERT INTO deliveries (ID, transportID, companyID, price) VALUES (7, 7, 4, 13730);
INSERT INTO deliveries (ID, transportID, companyID, price) VALUES (8, 8, 5, 9000);

COMMIT;

START TRANSACTION;
INSERT INTO suppliers (ID, `name`) VALUES (1, 'ОптЛист');
INSERT INTO suppliers (ID, `name`) VALUES (2, 'МТФОРС');
INSERT INTO suppliers (ID, `name`) VALUES (3, 'SAIRUS');
INSERT INTO suppliers (ID, `name`) VALUES (4, 'ТРИ КОТА Ж');
INSERT INTO suppliers (ID, `name`) VALUES (5, 'Малика');

COMMIT;

START TRANSACTION;

INSERT INTO products (ID, `name`, price, suppliersID, countc, type_of_cargo, `date`) VALUES (1, 'Белая футболка', 200, 4, 0, "Обычный товар", '2025-01-15');
INSERT INTO products (ID, `name`, price, suppliersID, countc, type_of_cargo, `date`) VALUES (2, 'Синии шорты', 180, 4, 0, "Обычный товар", '2025-02-10');
INSERT INTO products (ID, `name`, price, suppliersID, countc, type_of_cargo, `date`) VALUES (3, 'Серебряный браслет', 340, 3, 0, "Обычный товар", '2024-12-20');
INSERT INTO products (ID, `name`, price, suppliersID, countc, type_of_cargo, `date`) VALUES (4, 'Серебряный перстень', 270, 3, 0, "Обычный товар", '2024-12-22');
INSERT INTO products (ID, `name`, price, suppliersID, countc, type_of_cargo, `date`) VALUES (5, 'Розовая кепка', 100, 1, 0, "Обычный товар", '2025-01-05');
INSERT INTO products (ID, `name`, price, suppliersID, countc, type_of_cargo, `date`) VALUES (6, 'Белая майка', 130, 2, 1000, "Обычный товар", '2025-03-01');
INSERT INTO products (ID, `name`, price, suppliersID, countc, type_of_cargo, `date`) VALUES (7, 'Синие джинсы', 230, 5, 0, "Обычный товар", '2025-04-18');
INSERT INTO products (ID, `name`, price, suppliersID, countc, type_of_cargo, `date`) VALUES (8, 'Красные шорты', 180, 2, 0, "Обычный товар", '2025-02-25');
INSERT INTO products (ID, `name`, price, suppliersID, countc, type_of_cargo, `date`) VALUES (9, 'Серые кроссовки', 410, 5, 0, "Обычный товар", '2025-03-10');
INSERT INTO products (ID, `name`, price, suppliersID, countc, type_of_cargo, `date`) VALUES (10, 'Розовые туфли', 360, 1, 100, "Обычный товар", '2025-05-01');

COMMIT;

START TRANSACTION;
INSERT INTO type_of_application (ID, `type`, `name`) VALUES (1, 'Гравировка', 'Слово \"мама\"');
INSERT INTO type_of_application (ID, `type`, `name`) VALUES (2, 'Шелкография', 'Красня надпись\"РОНАЛДО ЛУЧШИЙ\"');
INSERT INTO type_of_application (ID, `type`, `name`) VALUES (3, 'Термотрансфер', 'Белая эмблема \"TOYOTA\"');
INSERT INTO type_of_application (ID, `type`, `name`) VALUES (4, 'Прямая печать', 'Зеленой рисунок \"АМ НЯМА\"');
INSERT INTO type_of_application (ID, `type`, `name`) VALUES (5, 'DTF печать', 'Синия печать \"Кафедрта ИТС - ЛУЧШАЯ!\"');

COMMIT;

START TRANSACTION;
INSERT INTO orders_has_products (ID, ordersID, deliveriesID, transportID, companyID, productsID, type_of_applicationID, productprice, amount) VALUES (1, 1, 1, 1, 1, 1, 5, 1300, '1300');
INSERT INTO orders_has_products (ID, ordersID, deliveriesID, transportID, companyID, productsID, type_of_applicationID, productprice, amount) VALUES (2, 2, 2, 2, 1, 1, 5, 1300, '1500');
INSERT INTO orders_has_products (ID, ordersID, deliveriesID, transportID, companyID, productsID, type_of_applicationID, productprice, amount) VALUES (3, 3, 2, 2, 1, 1, 5, 1300, '300');
INSERT INTO orders_has_products (ID, ordersID, deliveriesID, transportID, companyID, productsID, type_of_applicationID, productprice, amount) VALUES (4, 4, 3, 3, 2, 1, 5, 1300, '260');
INSERT INTO orders_has_products (ID, ordersID, deliveriesID, transportID, companyID, productsID, type_of_applicationID, productprice, amount) VALUES (5, 5, NULL, NULL, NULL, 2, NULL, 1000, '320');
INSERT INTO orders_has_products (ID, ordersID, deliveriesID, transportID, companyID, productsID, type_of_applicationID, productprice, amount) VALUES (6, 6, 8, 8, 5, 2, 3, 1200, '150');
INSERT INTO orders_has_products (ID, ordersID, deliveriesID, transportID, companyID, productsID, type_of_applicationID, productprice, amount) VALUES (7, 7, NULL, NULL, NULL, 3, 1, 3000, '6000');
INSERT INTO orders_has_products (ID, ordersID, deliveriesID, transportID, companyID, productsID, type_of_applicationID, productprice, amount) VALUES (8, 8, 7, 7, 4, 4, NULL, 2500, '70');
INSERT INTO orders_has_products (ID, ordersID, deliveriesID, transportID, companyID, productsID, type_of_applicationID, productprice, amount) VALUES (9, 9, 3, 3, 2, 5, 2, 900, '200');
INSERT INTO orders_has_products (ID, ordersID, deliveriesID, transportID, companyID, productsID, type_of_applicationID, productprice, amount) VALUES (10, 10, 4, 4, 3, 5, 2, 900, '340');
INSERT INTO orders_has_products (ID, ordersID, deliveriesID, transportID, companyID, productsID, type_of_applicationID, productprice, amount) VALUES (11, 11, 4, 4, 3, 6, 4, 850, '1600');
INSERT INTO orders_has_products (ID, ordersID, deliveriesID, transportID, companyID, productsID, type_of_applicationID, productprice, amount) VALUES (12, 12, 4, 4, 3, 6, 4, 850, '730');
INSERT INTO orders_has_products (ID, ordersID, deliveriesID, transportID, companyID, productsID, type_of_applicationID, productprice, amount) VALUES (13, 13, 4, 4, 3, 6, 4, 850, '630');
INSERT INTO orders_has_products (ID, ordersID, deliveriesID, transportID, companyID, productsID, type_of_applicationID, productprice, amount) VALUES (14, 14, 6, 6, 4, 6, 2, 850, '700');
INSERT INTO orders_has_products (ID, ordersID, deliveriesID, transportID, companyID, productsID, type_of_applicationID, productprice, amount) VALUES (15, 15, 6, 6, 4, 7, NULL, 2300, '250');
INSERT INTO orders_has_products (ID, ordersID, deliveriesID, transportID, companyID, productsID, type_of_applicationID, productprice, amount) VALUES (16, 16, NULL, NULL, NULL, 7, NULL, 2300, '310');
INSERT INTO orders_has_products (ID, ordersID, deliveriesID, transportID, companyID, productsID, type_of_applicationID, productprice, amount) VALUES (17, 17, 7, 7, 4, 8, 2, 700, '500');
INSERT INTO orders_has_products (ID, ordersID, deliveriesID, transportID, companyID, productsID, type_of_applicationID, productprice, amount) VALUES (18, 18, 8, 8, 5, 8, 2, 700, '500');
INSERT INTO orders_has_products (ID, ordersID, deliveriesID, transportID, companyID, productsID, type_of_applicationID, productprice, amount) VALUES (19, 19, 1, 1, 1, 8, 2, 700, '500');
INSERT INTO orders_has_products (ID, ordersID, deliveriesID, transportID, companyID, productsID, type_of_applicationID, productprice, amount) VALUES (20, 20, 2, 2, 1, 9, NULL, 3500, '140');
INSERT INTO orders_has_products (ID, ordersID, deliveriesID, transportID, companyID, productsID, type_of_applicationID, productprice, amount) VALUES (21, 21, 3, 3, 2, 10, NULL, 5600, '150');
INSERT INTO orders_has_products (ID, ordersID, deliveriesID, transportID, companyID, productsID, type_of_applicationID, productprice, amount) VALUES (22, 5, 3, 3, 2, 3, 5, 2000, '70');
INSERT INTO orders_has_products (ID, ordersID, deliveriesID, transportID, companyID, productsID, type_of_applicationID, productprice, amount) VALUES (23, 10, NULL, NULL, NULL, 4, NULL, 2500, '100');
INSERT INTO orders_has_products (ID, ordersID, deliveriesID, transportID, companyID, productsID, type_of_applicationID, productprice, amount) VALUES (24, 10, NULL, NULL, NULL, 6, 2, 1000, '200');
COMMIT;

ALTER TABLE orders_has_products
DROP FOREIGN KEY fk_orders_has_products_orders1;

#--------------------------lab2------------------------------
#Zadanie3
select c.`name` from `client` c join contracts con on c.id = con.clientID
join orders o on con.ID = o.contractsID
where con.`date` >= date_sub(now(), interval 6 month)
group by c.`name`
having count(o.id) >= 3;

#ZADANIE 4
SELECT AVG(order_count)
FROM (
    SELECT c.ID AS contract_id, COUNT(o.ID) AS order_count
    FROM contracts c
    LEFT JOIN orders o ON c.ID = o.contractsID
    GROUP BY c.ID
) AS sub;

#ZADANIE 5
select `date`, `enddate`, `status` from orders
where enddate <= curdate() and `status` = 'Доставлен';

#ZADANIE 6 end
select `date`, enddate, `status` from orders
where `status` = 'Отменен';

#ZADANIE 7
SELECT distinct o.ordersID
FROM orders_has_products o
WHERE o.ordersID NOT IN (
    SELECT ordersID 
    FROM orders_has_products 
    WHERE deliveriesID IS NOT NULL
);

#ZADANIE 8
(SELECT p.`name`, SUM(ohp.amount) AS cont
FROM orders_has_products ohp
JOIN products p ON ohp.productsID = p.ID
GROUP BY ohp.productsID
HAVING SUM(ohp.amount) >= 150)

UNION ALL

(SELECT toa.`type`, COUNT(*) AS count
FROM orders_has_products ohp
JOIN type_of_application toa ON ohp.type_of_applicationID = toa.ID
GROUP BY ohp.type_of_applicationID
HAVING COUNT(*) = (
    SELECT MAX(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM orders_has_products
        GROUP BY type_of_applicationID
    ) AS sub
));

#ZADANIE 9
select
    e.ID,
    e.`name`,
    COUNT(o.ID) as total_orders,
    sum(ohp.productprice * ohp.amount) as total
from employees e
join orders o on e.ID = o.employeesID
left join orders_has_products ohp on o.ID = ohp.ordersID
group by e.ID, e.`name`
order by total_orders desc
limit 5;
#------------------------------lab3(4)------------------------------
#ZADANIE 1.1
DELIMITER $$
create definer=root@localhost procedure AddProceducts(
in ID int, 
in name_in varchar(100), 
in price int,
in suppliersID int,
in countc int,
in type_of_cargo varchar(100),
in `date` date)

begin
	if exists(
		SELECT `name` FROM products WHERE `name` = name_in
		) then
			signal sqlstate "45000"
			set message_text = "Товар с таким названием уже добавлен";
	else
		insert into products (ID, `name`, price, suppliersID, countc, type_of_cargo, `date`)
		values (ID, name_in, price, suppliersID, countc, type_of_cargo, `date`);
	end if;
END$$
DELIMITER ;
call AddProceducts(13, "Шапка-бини Красная", 900, 2, 0, "Обычный товар",'2025-05-09');
select * from products;

#ZADANIE 1.2
DELIMITER $$
create definer = root@localhost procedure AddOrders_contracts(
ID INT,
p_contractsID INT,
employeesID INT,
`date` DATE,
enddate DATE,
`status` VARCHAR(45) )

begin
	if exists(
		select * from contracts c where c.ID = p_contractsID
	) then
		insert into orders(ID, contractsID, employeesID, `date`, enddate, `status`)
		values (ID, p_contractsID, employeesID, `date`, enddate, `status`);
	else 
		signal sqlstate "45000"
		set message_text = "Такого контракта не существует";
	end if;
end$$
DELIMITER ;

select * from orders;

#ZADANIE 1.3
DELIMITER $$

CREATE PROCEDURE AddContractAndOrder (
	in p_order_id int,
    IN p_clientID INT,
    IN p_employeeID INT,
    IN p_order_date DATE,
    IN p_order_enddate DATE,
    IN p_order_status VARCHAR(50)
)
BEGIN
DECLARE new_contract_id INT;

	if exists( 
		select * from orders o where o.ID != p_order_id
    )then
		
		select MAX(ID) + 1 INTO new_contract_id FROM contracts;

		INSERT INTO contracts (ID, clientID, `date`)
		VALUES (new_contract_id, p_clientID, p_order_date);

		INSERT INTO orders (ID, contractsID, employeesID, `date`, enddate, status)
		VALUES (p_order_id, new_contract_id, p_employeeID, p_order_date, p_order_enddate, p_order_status);
	else
		signal sqlstate "45000"
		set message_text = "Такой заказ уже существует";
	end if;
END$$
DELIMITER ;

select * from contracts;
select * from orders;


#ZADANIE 2.1
DELIMITER $$
create procedure CalculSumOrder(in custom_name varchar(100))

begin
(select o.ID, cl.`name`, sum(ohp.productprice*ohp.amount) as total_sum
from orders o
join contracts c on o.contractsID = c.ID
join `client` cl on c.`clientID` = cl.ID
join orders_has_products ohp on o.id = ohp.ordersID
join products p on ohp.productsID = p.ID
where cl.`name` = custom_name
group by o.id
order by total_sum desc)
union
select "", "name", "Итог"
union
(select "", cl.`name`, sum(ohp.productprice*ohp.amount) as total_sum
from orders o
join contracts c on o.contractsID = c.ID
join `client` cl on c.`clientID` = cl.ID
join orders_has_products ohp on o.id = ohp.ordersID
join products p on ohp.productsID = p.ID
where cl.`name` = custom_name
GROUP BY cl.`name`
);
end$$
DELIMITER ;

call CalculSumOrder('Zara');# Добавить общий итог всех заказов

#ZADANIE 2.2
DELIMITER $$
create procedure UncomOrders(in targetdate date)

begin

select * from orders 
where `date` <= targetdate and `status` != 'Доставлен';
end$$
DELIMITER ;

call UncomOrders ('2025-04-04'); # Когда компания не уложилась в сроки Не доставлен еще товар !!!
#ZADANIE 2.3
DELIMITER $$
create procedure CalculSize(in product_name varchar(100))

begin
select p.`name`, sum(ohp.amount)
from orders_has_products ohp
join products p on p.ID = ohp.productsID
join orders o on ohp.ordersID = o.ID
where p.`name` = product_name and o.`status` != 'Отменен'
group by `name`;
end$$
DELIMITER ;

call CalculSize('Белая футболка');
#ZADANIE 2.4
DELIMITER $$
create procedure CalculSum(in contracts_id int)

begin
select sum((ohp.productprice*ohp.amount)+d.price)
from orders_has_products ohp
join deliveries d on ohp.deliveriesID = d.ID
join orders o on ohp.ordersID = o.ID
join contracts c on c.ID = o.contractsID
where c.ID = contracts_id;
end$$
DELIMITER ;

call CalculSum(3);
#ZADANIE 2.5
DELIMITER $$
create procedure CalculDeliver(in date_dev date)

begin
select o.ID, o.`date`, o.enddate, o.`status`, trc.`name`, p.`name`, d.price 
from orders o
join orders_has_products ohp on ohp.ordersID = o.ID
join deliveries d on ohp.deliveriesID = d.ID
join transport_company trc on ohp.companyID = trc.ID
join products p on ohp.productsID = p.ID
where o.`status` = 'Передан доставщику' and o.enddate = date_dev;
end$$
DELIMITER ;

call CalculDeliver('2024-11-27');
#------------------------------lab4(5)------------------------------
#ZADANIE 1
DELIMITER $$
create trigger update_total_price after update on orders_has_products for each row
begin
declare total int;
select sum( productprice*amount ) into total from orders_has_products where ordersID = new.ordersID;
update orders set orders_total = total where id=new.ordersID;
end$$
DELIMITER ;

#ZADANIE 2
DELIMITER $$
create trigger set_contract_end_date before insert on contracts for each row
begin
set new.enddate = date_add(new.`date`, interval new.duration_days day);
end$$
DELIMITER ;

INSERT INTO contracts (ID, `clientID`, `date`, duration_days)
VALUES (10, 5,'2025-04-29', 23);
select * from contracts;

#ZADANIE 3
DELIMITER $$
create trigger decrease_product_stock after insert on orders_has_products for each row
begin
	update products
	set countc = countc - new.amount
	where ID = new.productsID;
if (select countc from products where ID = new.productsID) < new.amount then
	signal sqlstate "45000"
	set message_text = "Нет столько товара на складе";
end if;
end$$
DELIMITER ;

INSERT INTO orders_has_products (ID, ordersID, deliveriesID, transportID, companyID, productsID, type_of_applicationID, productprice, amount)
VALUES (27, 10, 4, 4, 3, 6, 4, 850, '73');
select * from products;

ALTER TABLE orders ADD COLUMN price_from_discount INT DEFAULT 0;

#ZADANIE 4
DELIMITER $$
create trigger set_order_discount before update on orders for each row
begin
	if new.orders_total >= 500 and new.orders_total < 1000 then
		set new.discount = 5;
	elseif new.orders_total >= 1000 and new.orders_total < 5000 then
		set new.discount = 10;
	elseif new.orders_total >= 5000 then
		set new.discount = 15;
	else
		set new.discount = 0;
	end if;
set new.price_from_discount = new.orders_total - (new.orders_total * (new.discount/100));    
end$$
DELIMITER ;
update orders set orders_total = 11000 where (ID = 1);
select * from orders;

#ZADANIE 5
DELIMITER $$
create trigger set_delivery_price before update on orders_has_products for each row
begin
	DECLARE sice_factory decimal(5,2);
    DECLARE transport_type decimal(5,2);
    declare delivery_price decimal(5,2);
	declare total_amount int;
    
    select
		case type_of_cargo
			when "Обычный товар" then 1.0
            when "Хрупкий товар" then 1.5
            when "Крупногабаритный товар" then 2.0
		end
    into sice_factory from products
    where ID = new.productsID;
    
    select
		case
			when `name` like "%Грузовик%" then 1.2
            when `name` like "%Тягач%" then 1.9
            when `name` like "%Самолет%" then 2.5
            when `name` like "%Корабль%" then 3.0
            else 0.0
		end
	into transport_type from transport
    where ID = new.transportID;
    
    select sum(amount) into total_amount from orders_has_products
    where ordersID = new.ordersID; #
    
    if total_amount < 1000 then
		set new.delivery_price = sice_factory * transport_type * 500;
	elseif total_amount >= 1000 and total_amount <= 5000 then
		set new.delivery_price = sice_factory * transport_type * 1000;
	else
		set new.delivery_price = sice_factory * transport_type * 2000;
	end if;
end$$
DELIMITER ;
update orders_has_products set deliveriesID = 1, transportID = 1, companyID = 1 where (ID = 24);
select * from orders_has_products;

#ZADANIE 6
DELIMITER $$
CREATE TRIGGER calculate_employee_payment 
before UPDATE ON orders 
FOR EACH ROW
BEGIN
    IF new.`status` = 'Отменен' THEN
        SET new.employee_payment = 0, 
			new.orders_total = 0, 
			new.discount = 0, 
            new.price_from_discount = 0;
    ELSE
        SET new.employee_payment = new.price_from_discount * 0.10;
	end if;
END$$
DELIMITER ;
update orders_has_products set amount = '15', productprice = 1300 where (ID = 2);
select * from orders_has_products;
select * from orders;

#ZADANIE 7

create table avg_price(
    productNamen varchar(100) not null primary key,
    countc int not null,
    avg_price decimal(10,2) not null
);

DELIMITER $$
CREATE TRIGGER calculate_avg_price 
AFTER insert ON products
FOR EACH ROW
begin
DECLARE total_sum DECIMAL(10,2);
    DECLARE total_count INT;
    DECLARE average DECIMAL(10,2);

    SELECT SUM(price), COUNT(*) 
    INTO total_sum, total_count 
    FROM products 
    WHERE `name` = NEW.`name`;

    SET average = total_sum / total_count;
 
    INSERT INTO avg_price (productNamen, countc, avg_price)
    VALUES (NEW.name, total_count, average)
    ON DUPLICATE KEY UPDATE
        countc = total_count,
        avg_price = average;
end$$
DELIMITER ;

insert into products(ID, `name`, price, suppliersID, countc, type_of_cargo, `date`) values(12, 'Розовые туфли', 960, 1, 100, "Обычный товар", '2025-06-09');
insert into products(ID, `name`, price, suppliersID, countc, type_of_cargo, `date`) values(14, 'Розовые туфли', 560, 2, 2500, "Обычный товар", '2025-06-10');
select productNamen as 'Наименование продукта', countc as 'Количество вариаций товара', avg_price as 'Средняя цена' from avg_price;
#добавить атрибут с датами

#ZADANIE 8
create table avg_price_orders(
	ordersID int not null primary key,
    avg_price decimal(10,2) not null
);

DELIMITER $$

CREATE TRIGGER calculate_avg_price_orders
AFTER INSERT ON orders_has_products
FOR EACH ROW
BEGIN
    DECLARE total_sum DECIMAL(10,2);
    DECLARE total_count INT;
    DECLARE average_price DECIMAL(10,2);
    
    SELECT 
        SUM(ohp.productprice * ohp.amount),
        SUM(ohp.amount)
    INTO total_sum, total_count
    FROM orders_has_products ohp
    JOIN orders o ON ohp.ordersID = o.ID
    WHERE o.`status` != 'Отменен' AND ohp.productprice IS NOT NULL;

    IF total_count > 0 THEN
        SET average_price = total_sum / total_count;

        INSERT INTO avg_price_orders (ordersID, avg_price)
        VALUES (1, average_price)
        ON DUPLICATE KEY UPDATE avg_price = average_price;
    END IF;
END$$
DELIMITER ;

INSERT INTO orders_has_products (ID, ordersID, deliveriesID, transportID, companyID, productsID, type_of_applicationID, productprice, amount)
VALUES (31, 10, 4, 4, 3, 6, 4, 850, '73');

select avg_price as 'Средняя цена всех заказов' from avg_price_orders;
#------------------------------lab5(6)------------------------------