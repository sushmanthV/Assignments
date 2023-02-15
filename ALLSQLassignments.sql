create database assignment

create table customer_master(
customer_number int primary key,
firstname varchar(10) null ,
middlename varchar(10) null ,
lastname varchar(10)null,
city varchar(10) null,
contactno varchar(10)null,
occupation varchar(10) null, dob date null)


insert into customer_master  values('101','Naga','sushmanth','vallepalli','hyd','6281866760','student','2001-06-24')
insert into customer_master values('102','jayasurya','null','pulaparthi','chennai','7787654432','service','2001-09-09')
insert into customer_master values('103','srikar','chandra','gandhi','banglore','8887654433','student','2000-09-25')
insert into customer_master values('104','null','kalyan','manchirya','chennai','6587654432','service','2001-04-02')
insert into customer_master values('105','anand','durga','null','hyd','7887654435','student','2001-06-09')
insert into customer_master values('106','ramesh','null','dutta','chennai','8787654532','service','2000-09-09')
insert into customer_master values('107','raki','null','null','banglore','6287654467','student','2004-05-20')
insert into customer_master values('108','vamsi','null','null','null','9098765432','service','2005-05-02')
insert into customer_master values('109','vara','lakshmi','mynam','hyd','null','null','2001-11-18')

select * from customer_master

--Display No.of customers belongs Each City --

select city,count(*) from customer_master group by city


--Display all city Names from Customer tables without any duplicate value  --

select distinct(city) from customer_master

--Display No.of customers from different Occupation --

select occupation,count(*) from customer_master group by occupation

--Display Customer Details with the Ascending Order based on FirstName --

select * from customer_master order by firstname asc

--Display the data in descending order based on Occupation and the display the FirstName in Ascending of each Occupation --

select * from customer_master order by occupation desc,firstname  asc

--Display Cusomters who has middlename as null --

select * from customer_master where middlename='null'


--table creation
create table loan_details(
loan_amount int,
customer_no int,
branch_id int,
constraint fk_customerno foreign key (customer_no)references customer_master(customer_number)
)
go


create table branch_master(
branch_id int primary key ,
branch_name varchar(20),
branch_city varchar(20))
go


create table account_master(
account_number int primary key,
customer_num int,
opening_bal int,
account_opening_date date,
account_type varchar(20),
account_status varchar(20),
account_id int,
constraint fk_id foreign key(account_id) references branch_master(branch_id),
constraint fk_custnum foreign key(customer_num) references customer_master(customer_number)
)
go


create table transaction_details(
transaction_num int,
account_num int primary key,
date_of_transaction date,
medium_of_transaction int,
transaction_type varchar(20),
transaction_amount int,

constraint fk_accno foreign key(account_num) references account_master(account_number)
)


---------------------------------------------------------------------------
--day3

---	1.Create a  user defined stored procedure to display “welcome to SQL Server” as message and execute it 
    create procedure spWelcomeMessage
    as
    select 'Welcome to Sql Server'
	exec spWelcomeMessage


--2.	create a stored procedure which takes Gender and Depatid as input paramaeter .
	--Based on input parameter display the Emplyee Name ,Gender Salary from tblEmployee table


create table dept(
id int primary key identity,
deptname varchar(30),
loc varchar(20),
depthead varchar(20))

insert into dept values('it','hyd','sushmanth'),
('cse','pune','kumar'),
('ece','chennai','raju'),
('hr','hyd','pavan')
select * from dept


create table tblemp
(
empid int primary key identity,
name varchar(40),
gender varchar(10),
sal int,
id  int foreign key references dept(id)
)

insert into tblemp values('ramesh','male',5000,1),
('rakesh','male',60000,2),
('dheeraj','male',78000,1),
('kiran','male',50000,2)
select * from tblemp


create procedure  sp
  @Gender varchar(20),
  @DeptID int
as
begin
  select name, gender, sal
from tblemp
  where gender = @Gender AND id = @DeptID
end

exec sp 'male',2


--3.	create a stored procedure which takes Gender and Depatid as input paramaeter  and 
--TotlaEmployeecount as output param. Based on input parameter display the Emplyee Name ,Gender 
--Salary from tblEmployee table  and Total Employee of given Gender and Department Id 
create procedure emp3(@Gender varchar(10),@departmentid int, @empcount int output)
as
begin
select name,gender,sal from tblemp where @gender=Gender and @departmentid=id
select @empcount=@@ROWCOUNT
end
declare @count int;
exec emp3 @gender='male',@departmentid=2,@empcount=@count 
select @count as 'no.of employees'
select * from tblemp

--4.	Display the TotalEmployeeCount by gender using stored procedure? 
create procedure p
as
select count(*) from tblemp where gender='male' 
select count(*) from tblemp where gender='female'
exec p

--5.	create a stored procedure two add thee number and display the sum of three numberas output.
--If user does not pass values for input params give default value sum as output. 
 create procedure AddNumber(@No1 int= 100, @No2 int,@No3 int)
as
begin
  declare @Result int 
  set @Result = @No1 + @No2+@No3
  print 'The SUM of the 3 Numbers is: '+ CAST(@Result as varchar)
end
exec AddNumber @No1=default, @No2=25,@No3=50

--------------------------------------------------------------------------------------
---display  branchid from student tablele ------
create table student
(
id int primary key,
name varchar(50),
gender varchar(10),
branch varchar(20),
branchid int
)


insert into student values(1,'sushmanth','male','ece',101)
insert into student values(2,'varalakshmi','female','ece',102)
insert into student values(3, 'ramesh','male','cse',201)
insert into student values(4,'srikar','male','eee',301)
insert into student values(5,'rupa','female','it',401)

select * from student

 --create function to display student information by branchid

create function getstudentdetails(@id int)
returns table
as
return
(
select * from student where branchid=@id
)
select * from getstudentdetails(102)

--create function to display student information by gender

create function getstudentdetailsby(@gender varchar(10))
returns table
as
return
(
select * from student where gender=@gender
)
select * from getstudentdetailsby('female')



CREATE FUNCTION NetSales1 (@orderID INT)
RETURNS TABLE
AS
RETURN (
   SELECT order_id, SUM(list_price) AS NetSales1
  FROM sales.order_items
   WHERE order_id = @orderID
   GROUP BY order_id
)

 select* from NetSales1(1)







