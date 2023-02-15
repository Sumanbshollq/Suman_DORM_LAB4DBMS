-- 1)You are required to create tables for supplier,customer,category,product,supplier_pricing,order,rating to store the data for the E-commerce with the schema definition given below.
create database order_directory;

drop table customer;
create table if not exists supplier(
SUPP_ID int primary key,
SUPP_NAME varchar(50) not null,
SUPP_CITY varchar(50) not null,
SUPP_PHONE varchar(50) not null );

create table if not exists customer(
CUS_ID int primary key,
CUS_NAME varchar(20) not null,
CUS_PHONE varchar(10) not null,
CUS_CITY varchar(30) not null,
CUS_GENDER char);

create table if not exists category (
CAT_ID int primary key,
CAT_NAME VARCHAR(20) not NULL);

create table if not exists PRODUCT (
PRO_ID int primary key,
PRO_NAME VARCHAR(20) not null default 'Dummy',
PRO_DESC VARCHAR(60),
CAT_ID int not null,
foreign key(CAT_ID) references category(CAT_ID));

create table `order`(
ORD_ID int primary key,
ORD_AMOUNT int not null,
ORD_DATE DATE not null,
CUS_ID int ,
PRICING_ID int,
foreign key (CUS_ID)references customer(CUS_ID),
foreign key (PRICING_ID) references PRODUCT(PRO_ID));


create table if not exists rating(
RAT_ID int primary key,
ORD_ID int,
RAT_RATSTARS int NOT null,
foreign key (ORD_ID) references `order`(ORD_ID)); 

-- 2)Insert the following data in the table created above

INSERT INTO SUPPLIER (SUPP_ID,SUPP_NAME,SUPP_CITY,SUPP_PHONE) values (1,'RajeshRetails','Delhi',1234567890);
INSERT INTO SUPPLIER (SUPP_ID,SUPP_NAME,SUPP_CITY,SUPP_PHONE) values (2,'Appario Ltd.','Mumbai',2589631470);
INSERT INTO SUPPLIER (SUPP_ID,SUPP_NAME,SUPP_CITY,SUPP_PHONE) values (3,'Knome products','Banglore',9785462315);
INSERT INTO SUPPLIER (SUPP_ID,SUPP_NAME,SUPP_CITY,SUPP_PHONE) values (4,'Bansal Retails','Kochi',8975463285);
INSERT INTO SUPPLIER (SUPP_ID,SUPP_NAME,SUPP_CITY,SUPP_PHONE) values (5,'Mittal Ltd.','Lucknow',7898456532);



INSERT INTO CUSTOMER values (1,'AAKASH',9999999999,'DELHI','M');
INSERT INTO CUSTOMER values (2,'AMAN',9785463215,'NOIDA','M');
INSERT INTO CUSTOMER values (3,'NEHA',9999999999,'MUMBAI','F');
INSERT INTO CUSTOMER values (4,'MEGHA',9994562399,'KOLKATA','F');
INSERT INTO CUSTOMER values (5,'PULKIT',7895999999,'LUCKNOW','M');

INSERT INTO Category values (1,'BOOKS');
INSERT INTO Category values (2,'GAMES');
INSERT INTO Category values (3,'GROCERIES');
INSERT INTO Category values (4,'ELECTRONICS');
INSERT INTO Category values (5,'CLOTHES');

INSERT INTO Product values (1,'GTA V','Windows 7 and above with i5 processor and 8GB RAM',2);
INSERT INTO Product values (2,'TSHIRT','SIZE-L with Black, Blue and White variations',5);
INSERT INTO Product values (3,'ROG LAPTOP','Windows 10 with 15inch screen, i7 processor, 1TB SSD',4);
INSERT INTO Product values (4,'OATS','Highly Nutritious from Nestle',3);
INSERT INTO Product values (5,'HARRY POTTER','Best Collection of all time by J.K Rowling',1);
INSERT INTO Product values (6,'MILK','1L Toned MIlk',3);
INSERT INTO Product values (7,'Boat Earphones','1.5Meter long Dolby Atmos',4);
INSERT INTO Product values (8,'Jeans','Stretchable Denim Jeans with various sizes and color',5);
INSERT INTO Product values (9,'Project IGI','compatible with windows 7 and above',2);
INSERT INTO Product values (10,'Hoodie','Black GUCCI for 13 yrs and above',5);
INSERT INTO Product values (11,'Rich Dad Poor Dad','Written by RObert Kiyosaki',1);
INSERT INTO Product values (12,'Train Your Brain','By Shireen Stephen',1);


insert into Supplier_pricing values (1,1,2,1500);
insert into Supplier_pricing values (2,3,5,30000);
insert into Supplier_pricing values (3,5,1,3000);
insert into Supplier_pricing values (4,2,3,2500);
insert into Supplier_pricing values (5,4,1,1000);


insert into `order` values(101,1500,'2021/10/06',2,1);
insert into `order` values(102,1000,'2021/10/12',3,5);
insert into `order` values(103,30000,'2021/09/16',5,2);
insert into `order` values(104,1500,'2021/10/05',1,1);
insert into `order` values(105,3000,'2021/08/16',4,3);
insert into `order` values(106,1450,'2021/08/18',1,9);
insert into `order` values(107,789,'2021/09/01',3,7);
insert into `order` values(108,780,'2021/09/07',5,6);
insert into `order` values(110,2500,'2021/09/10',2,4);
insert into `order` values(111,1000,'2021/09/15',4,5);
insert into `order` values(112,789,'2021/09/16',4,7);
insert into `order` values(113,31000,'2021/09/16',1,8);
insert into `order` values(114,1000,'2021/09/16',3,5);
insert into `order` values(115,3000,'2021/09/16',5,3);

insert into rating values (1,101,4);
insert into rating values (2,102,3);
insert into rating values (3,103,1);
insert into rating values (4,104,2);
insert into rating values (5,105,4);
insert into rating values (6,106,3);
insert into rating values (7,107,4);
insert into rating values (8,108,4);
insert into rating values (9,109,3);
insert into rating values (10,110,5);
insert into rating values (11,111,3);
insert into rating values (12,112,4);
insert into rating values (13,113,2);
insert into rating values (14,114,1);
insert into rating values (15,115,1);
insert into rating values (16,116,0);



-- 4)	Display all the `order` along with product name ordered by a customer having Customer_Id=2
SELECT * 
FROM (SELECT product.PRO_NAME, product.PRO_ID, supplier_pricing.PRICING_ID 
	  FROM supplier_pricing 
      INNER JOIN product 
	  ON supplier_pricing.PRO_ID = product.PRO_ID) AS Supp_Pro 
INNER JOIN `order` AS O 
ON O.PRICING_ID = Supp_Pro.PRICING_ID AND O.CUS_ID = "2";

-- 5)	Display the Supplier details who can supply more than one product.
SELECT S.SUPP_NAME, S.SUPP_ID, COUNT(S.SUPP_ID), SP.PRO_ID 
FROM supplier AS S 
INNER JOIN supplier_pricing AS SP 
ON S.SUPP_ID = SP.SUPP_ID 
GROUP BY S.SUPP_ID HAVING COUNT(S.SUPP_ID) > 1;

-- 6)	Find the least expensive product from each category and print the table with category id, name, product name and price of the product
SELECT C.CAT_NAME, sup_pro.minSP, sup_pro.PRO_ID, sup_pro.PRO_NAME, sup_pro.CAT_ID 
FROM (SELECT MIN(SP.SUPP_PRICE) AS minSP, P.PRO_ID, P.PRO_NAME, P.CAT_ID 
	  FROM supplier_pricing AS SP 
      INNER JOIN product AS P 
      ON SP.PRO_ID = P.PRO_ID 
      GROUP BY P.CAT_ID) AS sup_pro
INNER JOIN category AS C 
ON C.CAT_ID = sup_pro.CAT_ID;

-- 7)	Display the Id and Name of the Product ordered after “2021-10-05”.
SELECT Supp_Pro.PRO_ID, Supp_Pro.PRO_NAME, O.ORD_DATE, O.ORD_ID  
FROM (SELECT product.PRO_NAME, product.PRO_ID, supplier_pricing.PRICING_ID 
	  FROM supplier_pricing 
      INNER JOIN product 
      ON supplier_pricing.PRO_ID = product.PRO_ID) AS Supp_Pro 
INNER JOIN `order` AS O 
ON O.PRICING_ID = Supp_Pro.PRICING_ID AND O.ORD_DATE > "2021-10-05";

-- 8)	Display customer name and gender whose names start or end with character 'A'.
SELECT C.CUS_NAME, C.CUS_GENDER 
FROM customer AS C 
WHERE C.CUS_NAME LIKE 'A%' OR C.CUS_NAME LIKE '%A';

-- 9)	Create a stored procedure to display supplier id, name, rating and Type_of_Service. For Type_of_Service, If rating =5, print “Excellent Service”,If rating >4 print “Good Service”, If rating >2 print “Average Service” else print “Poor Service”.
CALL ServiceRating();
Footer

