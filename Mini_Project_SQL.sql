/* Module 1 Data Warehouse & Employee Analytics
Task 1 – Employee Data Profiling
The Data Engineering team needs a summary of employee records loaded into the Data Warehouse. 
Display: • Department • Total Employees • Average Salary • Highest Salary • Lowest Salary 
Sort by Average Salary in descending order. */
Create table Employee (EmpID int primary key,EmpName Varchar(15),Salary int,Department varchar(15),Age int);
insert into Employee (EmpID, EmpName, Salary, Department, Age)
values(101, 'Alice', 55000, 'HR',28),(102, 'Bob', 62000, 'IT', 32),(103, 'Charlie', 48000, 'Finance', 26),
(104, 'David', 70000, 'IT', 35),(105, 'Eva', 53000, 'Marketing', 29),(106, 'Frank', 60000, 'Sales', 31),
(107, 'Grace', 75000, 'Finance', 38),(108, 'Henry',   45000, 'HR', 25),(109, 'Ivy', 68000, 'Marketing', 34),
(110, 'Jack', 52000, 'Sales', 27);
-- Answer : 
Select department, Count(empID), avg(Salary), max(Salary), Min (salary) from employee group by department order by salary desc;

/* Task 2 – Department Salary Analysis 
Find departments whose total salary is greater than the company average department salary. 
Display: • Department • Total Salary */
Create table Employee (EmpID int primary key,EmpName Varchar(15),Salary int,Department varchar(15),Age int);
insert into Employee (EmpID, EmpName, Salary, Department, Age)
values(101, 'Alice', 55000, 'HR',28),(102, 'Bob', 62000, 'IT', 32),(103, 'Charlie', 48000, 'Finance', 26),
(104, 'David', 70000, 'IT', 35),(105, 'Eva', 53000, 'Marketing', 29),(106, 'Frank', 60000, 'Sales', 31),
(107, 'Grace', 75000, 'Finance', 38),(108, 'Henry', 45000, 'HR', 25),(109, 'Ivy', 68000, 'Marketing', 34),
(110, 'Jack', 52000, 'Sales', 27);
-- Answer : 
with department_Salary as (select department, Sum(salary) as totalsalary from employee group by department)
select department, totalsalary from department_Salary where totalsalary > (select avg(salary ) from department);

/* Task 3 – Salary Validation 
Identify employees whose salary is higher than the average salary of their department. 
Display: • Employee Name • Department • Salary • Department Average */
Create table Employee (EmpID int primary key,EmpName Varchar(15),Salary int,Department varchar(15),Age int);
insert into Employee (EmpID, EmpName, Salary, Department, Age)
values(101, 'Alice', 55000, 'HR',28),(102, 'Bob', 62000, 'IT', 32),(103, 'Charlie', 48000, 'Finance', 26),
(104, 'David', 70000, 'IT', 35),(105, 'Eva', 53000, 'Marketing', 29),(106, 'Frank', 60000, 'Sales', 31),
(107, 'Grace', 75000, 'Finance', 38),(108, 'Henry', 45000, 'HR', 25),(109, 'Ivy', 68000, 'Marketing', 34),
(110, 'Jack', 52000, 'Sales', 27);
-- Answer : 
Select empName, Department, Salary from employee where salary > (select avg(Salary) from employee) group by department;

/* Task 4 – Department Ranking 
Rank departments based on total salary expenditure. 
Display: • Department • Total Salary • Rank */
Create table Employee (EmpID int primary key,EmpName Varchar(15),Salary int,Department varchar(15),Age int);
insert into Employee (EmpID, EmpName, Salary, Department, Age)
values(101, 'Alice', 55000, 'HR',28),(102, 'Bob', 62000, 'IT', 32),(103, 'Charlie', 48000, 'Finance', 26),
(104, 'David', 70000, 'IT', 35),(105, 'Eva', 53000, 'Marketing', 29),(106, 'Frank', 60000, 'Sales', 31),
(107, 'Grace', 75000, 'Finance', 38),(108, 'Henry', 45000, 'HR', 25),(109, 'Ivy', 68000, 'Marketing', 34),
(110, 'Jack', 52000, 'Sales', 27);
-- Answer : 
Select department, sum(Salary), rank() over(order by sum(salary)) from employee group by depaetment;

/* Task 5 – Duplicate Employee Detection 
Find duplicate Employee IDs generated during ETL loading. */
Create table Employee (EmpID int,EmpName Varchar(15),Salary int,Department varchar(15),Age int);
insert into Employee (EmpID, EmpName, Salary, Department, Age)
values(101, 'Alice', 55000, 'HR',28),(102, 'Bob', 62000, 'IT', 32),(103, 'Charlie', 48000, 'Finance', 26),
(104, 'David', 70000, 'IT', 35),(105, 'Eva', 53000, 'Marketing', 29),(106, 'Frank', 60000, 'Sales', 31),
(107, 'Grace', 75000, 'Finance', 38),(108, 'Henry', 45000, 'HR', 25),(109, 'Ivy', 68000, 'Marketing', 34),
(110, 'Jack', 52000, 'Sales', 27);
-- Answer : 
Select Count(EmpID) from employee group by EmpID limit 1;

/* Task 6 – Missing Department Mapping 
Display employees whose Department_ID has no matching record in the Department table. */
Create table Employee (EmpID int primary key,EmpName Varchar(15),Salary int,Age int, departmentID int);
insert into Employee (EmpID, EmpName, Salary, Age)
values(101, 'Alice', 55000,28, 1),(102, 'Bob', 62000, 32,2),(103, 'Charlie', 48000, 26,3),
(104, 'David', 70000, 35,2),(105, 'Eva', 53000, 29,4),(106, 'Frank', 60000, 31,5),
(107, 'Grace', 75000, 38,3),(108, 'Henry', 45000, 25,1),(109, 'Ivy', 68000, 34,4),
(110, 'Jack', 52000,27,7);
Create table department (DepartmentID int, DepartmentName varchar(15));
insert into department(departmentID,departmentname)
values (1,'HR'),(2, 'IT'),(3,'Finance'),(4,'Marketing'),(5,'sales');
-- Answer:
Select E.Empname, D.departmentID from employee.E left join departnment on E.departmentID = D.departmentID

/* Task 7 – Latest Employee Record 
Each employee may have multiple records due to historical loads. 
Display only the latest record for every employee. */
Create table Employee (EmpID int primary key,EmpName Varchar(15),Salary int,Department varchar(15),Age int, Loaddate date);
insert into Employee (EmpID, EmpName, Salary, Department, Age, Loaddate)
values(101, 'Alice', 55000, 'HR',28,7-7-2025),(102, 'Bob', 62000, 'IT', 32,12-10-2019),(103, 'Charlie', 48000, 'Finance', 26,8-10-2026),
(104, 'David', 70000, 'IT', 35, 06-10-2024),(105, 'Eva', 53000, 'Marketing', 29,04-03-2022),(106, 'Frank', 60000, 'Sales', 31,01-03-2021),
(107, 'Grace', 75000, 'Finance', 38,08-2-2018),(108, 'Henry', 45000, 'HR', 2022,02-12-2018),(109, 'Ivy', 68000, 'Marketing', 34,11-3-2023),
(110, 'Jack', 52000, 'Sales', 27, 07-05-2025);
-- Answer :
Select Loaddate from employee where Max(loaddate);

/* Task 8 – Employee Growth Analysis 
Calculate the running total of employees hired month-wise. */
Create table Employee (EmpID int primary key,EmpName Varchar(15),Salary int,Department varchar(15),Age int, joineddate date);
insert into Employee (EmpID, EmpName, Salary, Department, Age, Loaddate)
values(101, 'Alice', 55000, 'HR',28,7-7-2025),(102, 'Bob', 62000, 'IT', 32,12-10-2019),(103, 'Charlie', 48000, 'Finance', 26,8-10-2026),
(104, 'David', 70000, 'IT', 35, 06-10-2024),(105, 'Eva', 53000, 'Marketing', 29,04-03-2022),(106, 'Frank', 60000, 'Sales', 31,01-03-2021),
(107, 'Grace', 75000, 'Finance', 38,08-2-2018),(108, 'Henry', 45000, 'HR', 2022,02-12-2018),(109, 'Ivy', 68000, 'Marketing', 34,11-3-2023),
(110, 'Jack', 52000, 'Sales', 27, 07-05-2025);
-- Answer :
Select month(joineddate), Year(joineddate) from employee order by joineddate;

/* Task 9 – Department-wise Top 3 Salaries 
Display the top three highest-paid employees in every department. */
Create table Employee (EmpID int primary key,EmpName Varchar(15),Salary int,Department varchar(15),Age int);
insert into Employee (EmpID, EmpName, Salary, Department, Age)
values(101, 'Alice', 55000, 'HR',28),(102, 'Bob', 62000, 'IT', 32),(103, 'Charlie', 48000, 'Finance', 26),
(104, 'David', 70000, 'IT', 35),(105, 'Eva', 53000, 'Marketing', 29),(106, 'Frank', 60000, 'Sales', 31),
(107, 'Grace', 75000, 'Finance', 38),(108, 'Henry',   45000, 'HR', 25),(109, 'Ivy', 68000, 'Marketing', 34),
(110, 'Jack', 52000, 'Sales', 27);
-- Answer : 
Select * from employee Where Salary > (select Max(Salary) from employee) order by salary Limit 3;

/*Task 10 – Employee Summary View 
Create a View that displays active employee details along with department information. */
create table Employee (EmpID int ,departmentID int primary key,EmpName varchar(50) ,Salary decimal(10,2),HireDate date,
Statu varchar(20));
insert into Employee values(101,1, 'Smith', 'IT', 65000.00, '2021-03-15', 'Active'),(102,2, 'Johnson', 'HR', 55000.00, '2020-07-10', 'Active'),
(103,3, 'Brown', 'Finance', 60000.00, '2019-11-25', 'Inactive'),(104, 4,'Williams', 'Marketing', 52000.00, '2022-01-05', 'Active'),
(105,1, 'David', 'IT', 72000.00, '2018-06-20', 'Active'),(106,3, 'Taylor', 'Finance', 58000.00, '2021-09-12', 'Active'),
(107, 5,'Robert', 'Operations', 50000.00, '2023-02-18', 'Active'),(108,2, 'Olivia', 'HR', 62000.00, '2019-04-30', 'Inactive'),
(109, 4,'Daniel', 'Marketing', 57000.00, '2020-12-15', 'Active'),(110,1, 'Sophia', 'IT', 68000.00, '2022-08-22', 'Active'),
(111,5, 'James', 'Operations', 53000.00, '2021-05-11', 'Inactive'),(112,3, 'Emma', 'Finance', 61000.00, '2023-06-01', 'Active');
Create table department (DepartmentID int, Departmentname varchar(50));
insert into Employee values(1,'IT'),(2,'HR'),(3,'Finance'),(4,'Marketing'),(5,'Operations');
-- Answer : 
Create view Employeeactive as select E.EmpID,E.Employeename,D.departmentname,E.Salary,E.Hiredate,E.Statu from employee.E inner join 
D.department on E.EmployeeID = E.departmentID Where Statu = 'Active';

/* Module 2 – Sales Data Warehouse (Tasks 11 to 20) 
Task 11 
Generate month-wise sales revenue. */
Create table Sales(SaleID int primary Key,CustomerID int,ProductID int,SaleDate date,Quantity int,TotalAmount decimal(12,2));
insert into Sales(SaleID, CustomerID, ProductID, SaleDate, Quantity, TotalAmount) 
values(1001, 201, 301, '2024-01-05', 2, 1200.00),(1002, 202, 302, '2024-01-10', 1, 750.00),(1003, 203, 303, '2024-01-15', 5, 2500.00),
(1004, 204, 304, '2024-02-01', 3, 1800.00),(1005, 205, 305, '2024-02-08', 4, 3200.00),(1006, 206, 306, '2024-02-15', 2, 1400.00),
(1007, 207, 307, '2024-03-01', 6, 4200.00),(1008, 208, 308, '2024-03-10', 1, 950.00),(1009, 209, 309, '2024-03-18', 7, 5600.00),
(1010, 210, 310, '2024-03-25', 3, 2100.00);
-- Answer : 
select monthname(salesdate), sum(totalamount) from sales where year(saledate) = '2024' 
group by month(saledate),monthname(salesdate)
order by month(saledate);

/* Task 12 
Find products contributing to 80% of total revenue. */
Create table Product (ProductID int primary key,ProductName varchar(150),CategoryID int,UnitPrice decimal(10,2));
insert into Product (ProductID, ProductName, CategoryID, UnitPrice) values
(301, 'Laptop', 1, 55000.00),(302, 'Desktop Computer', 1, 48000.00),(303, 'Wireless Mouse', 2, 850.00),
(304, 'Mechanical Keyboard', 2, 2200.00),(305, 'LED Monitor 24 Inch', 3, 9500.00),(306, 'USB Flash Drive 64GB', 4, 700.00),
(307, 'External Hard Drive 1TB', 4, 4200.00),(308, 'Laser Printer', 5, 13500.00),(309, 'Webcam HD', 6, 1800.00),
(310, 'Bluetooth Speaker', 7, 3200.00),(311, 'Wireless Headphones', 7, 4500.00),(312, 'Smartphone', 8, 28000.00);
Create table Sales(SaleID int primary Key,CustomerID int,ProductID int,SaleDate date,Quantity int,TotalAmount decimal(12,2));
insert into Sales(SaleID, CustomerID, ProductID, SaleDate, Quantity, TotalAmount) 
values(1001, 201, 301, '2024-01-05', 2, 1200.00),(1002, 202, 302, '2024-01-10', 1, 750.00),(1003, 203, 303, '2024-01-15', 5, 2500.00),
(1004, 204, 304, '2024-02-01', 3, 1800.00),(1005, 205, 305, '2024-02-08', 4, 3200.00),(1006, 206, 306, '2024-02-15', 2, 1400.00),
(1007, 207, 307, '2024-03-01', 6, 4200.00),(1008, 208, 308, '2024-03-10', 1, 950.00),(1009, 209, 309, '2024-03-18', 7, 5600.00),
(1010, 210, 310, '2024-03-25', 3, 2100.00);
-- Answer : 
Select P.productname,sum(s.totalamount) as revenue,sum(s.totalamount) over(order by sum(s.totalamount) desc) as running_revenue,
round(Sum(s.totalamount) over (order by sum(s.totalamount) desc) )* 100 from product P join sales S on 
P.productID = S.ProductID group by P.productID,P.productName
order by revenue desc;

/*Task 13 
Display products that have never been sold. */
Create table Product (ProductID int primary key,ProductName varchar(150),CategoryID int,UnitPrice decimal(10,2));
insert into Product (ProductID, ProductName, CategoryID, UnitPrice) values
(301, 'Laptop', 1, 55000.00),(302, 'Desktop Computer', 1, 48000.00),(303, 'Wireless Mouse', 2, 850.00),
(304, 'Mechanical Keyboard', 2, 2200.00),(305, 'LED Monitor 24 Inch', 3, 9500.00),(306, 'USB Flash Drive 64GB', 4, 700.00),
(307, 'External Hard Drive 1TB', 4, 4200.00),(308, 'Laser Printer', 5, 13500.00),(309, 'Webcam HD', 6, 1800.00),
(310, 'Bluetooth Speaker', 7, 3200.00),(311, 'Wireless Headphones', 7, 4500.00),(312, 'Smartphone', 8, 28000.00);
Create table Sales(SaleID int primary Key,CustomerID int,ProductID int,SaleDate date,Quantity int,TotalAmount decimal(12,2));
insert into Sales(SaleID, CustomerID, ProductID, SaleDate, Quantity, TotalAmount) 
values(1001, 201, 301, '2024-01-05', 2, 1200.00),(1002, 202, 302, '2024-01-10', 1, 750.00),(1003, 203, 303, '2024-01-15', 5, 2500.00),
(1004, 204, 304, '2024-02-01', 3, 1800.00),(1005, 205, 305, '2024-02-08', 4, 3200.00),(1006, 206, 306, '2024-02-15', 2, 1400.00),
(1007, 207, 307, '2024-03-01', 6, 4200.00),(1008, 208, 308, '2024-03-10', 1, 950.00),(1009, 209, 309, '2024-03-18', 7, 5600.00),
(1010, 210, 310, '2024-03-25', 3, 2100.00);
Create table Category (CategoryID int primary key,CategoryName varchar(100));
insert into Category (CategoryID, CategoryName) values
(1, 'Computers'),(2, 'Computer Accessories'),(3, 'Monitors'),(4, 'Storage Devices'),(5, 'Printers'),(6, 'Cameras'),(7, 'Audio Devices'),
(8, 'Mobile Phones'),(9, 'Networking'),(10, 'Gaming'),(11, 'Office Equipment'),(12, 'Smart Home');
-- Answer : 
Select P.productID,P.productname,C.CategoryName from product P inner join Category on 
P.CategoryID = C.CategoryID
Left join Sales S on P.productID = S.productID
where S.productID is null;

/* Task 14 
Identify customers purchasing from multiple categories. */
create table Customer (CustomerID int primary key,CustomerName varchar(100),Gender varchar(20),City varchar(100),
Region varchar(50),JoinDate date);
insert into Customer (CustomerID, CustomerName, Gender, City, Region, JoinDate) values
(201, 'Smith', 'Male', 'New York', 'North', '2022-01-15'),(202, 'Johnson', 'Female', 'Los Angeles', 'West', '2022-03-20'),
(203, 'Michael', 'Male', 'Chicago', 'North', '2022-05-10'),(204, 'Williams', 'Female', 'Houston', 'South', '2022-07-18'),
(205, 'David', 'Male', 'Phoenix', 'West', '2022-09-12'),(206, 'Taylor', 'Female', 'Philadelphia', 'East', '2022-10-25'),
(207, 'Anderson', 'Male', 'San Antonio', 'South', '2023-01-08'),(208, 'Thomas', 'Female', 'San Diego', 'West', '2023-02-14'),
(209, 'Martinez', 'Male', 'Dallas', 'South', '2023-04-30'),(210, 'Davis', 'Female', 'San Jose', 'West', '2023-06-11'),
(211, 'Wilson', 'Male', 'Austin', 'South', '2023-08-19'),(212, 'Emma', 'Female', 'Jacksonville', 'East', '2023-11-05');
Create table Category (CategoryID int primary key,CategoryName varchar(100));
insert into Category (CategoryID, CategoryName) values
(1, 'Computers'),(2, 'Computer Accessories'),(3, 'Monitors'),(4, 'Storage Devices'),(5, 'Printers'),(6, 'Cameras'),(7, 'Audio Devices'),
(8, 'Mobile Phones'),(9, 'Networking'),(10, 'Gaming'),(11, 'Office Equipment'),(12, 'Smart Home');
Create table Product (ProductID int primary key,ProductName varchar(150),CategoryID int,UnitPrice decimal(10,2));
insert into Product (ProductID, ProductName, CategoryID, UnitPrice) values
(301, 'Laptop', 1, 55000.00),(302, 'Desktop Computer', 1, 48000.00),(303, 'Wireless Mouse', 2, 850.00),
(304, 'Mechanical Keyboard', 2, 2200.00),(305, 'LED Monitor 24 Inch', 3, 9500.00),(306, 'USB Flash Drive 64GB', 4, 700.00),
(307, 'External Hard Drive 1TB', 4, 4200.00),(308, 'Laser Printer', 5, 13500.00),(309, 'Webcam HD', 6, 1800.00),
(310, 'Bluetooth Speaker', 7, 3200.00),(311, 'Wireless Headphones', 7, 4500.00),(312, 'Smartphone', 8, 28000.00);
Create table Sales(SaleID int primary Key,CustomerID int,ProductID int,SaleDate date,Quantity int,TotalAmount decimal(12,2));
insert into Sales(SaleID, CustomerID, ProductID, SaleDate, Quantity, TotalAmount) 
values(1001, 201, 301, '2024-01-05', 2, 1200.00),(1002, 202, 302, '2024-01-10', 1, 750.00),(1003, 203, 303, '2024-01-15', 5, 2500.00),
(1004, 204, 304, '2024-02-01', 3, 1800.00),(1005, 205, 305, '2024-02-08', 4, 3200.00),(1006, 206, 306, '2024-02-15', 2, 1400.00),
(1007, 207, 307, '2024-03-01', 6, 4200.00),(1008, 208, 308, '2024-03-10', 1, 950.00),(1009, 209, 309, '2024-03-18', 7, 5600.00),
(1010, 210, 310, '2024-03-25', 3, 2100.00);
-- Answer : 
select C.customerName,COUNT(distinct p.CategoryID) as totalCategories_Purchased from Customer c
inner join Sales s on c.CustomerID = s.CustomerID
inner join Product p on s.ProductID = p.ProductID
group by c.CustomerID,c.CustomerName having COUNT(distinct p.CategoryID) > 1;

/*Task 15 
Find the second highest selling product in every category. */
Create table Category (CategoryID int primary key,CategoryName varchar(100));
insert into Category (CategoryID, CategoryName) values
(1, 'Computers'),(2, 'Computer Accessories'),(3, 'Monitors'),(4, 'Storage Devices'),(5, 'Printers'),(6, 'Cameras'),(7, 'Audio Devices'),
(8, 'Mobile Phones'),(9, 'Networking'),(10, 'Gaming'),(11, 'Office Equipment'),(12, 'Smart Home');
Create table Product (ProductID int primary key,ProductName varchar(150),CategoryID int,UnitPrice decimal(10,2));
insert into Product (ProductID, ProductName, CategoryID, UnitPrice) values
(301, 'Laptop', 1, 55000.00),(302, 'Desktop Computer', 1, 48000.00),(303, 'Wireless Mouse', 2, 850.00),
(304, 'Mechanical Keyboard', 2, 2200.00),(305, 'LED Monitor 24 Inch', 3, 9500.00),(306, 'USB Flash Drive 64GB', 4, 700.00),
(307, 'External Hard Drive 1TB', 4, 4200.00),(308, 'Laser Printer', 5, 13500.00),(309, 'Webcam HD', 6, 1800.00),
(310, 'Bluetooth Speaker', 7, 3200.00),(311, 'Wireless Headphones', 7, 4500.00),(312, 'Smartphone', 8, 28000.00);
-- Answer : 
select * from (select C.categoryName,P.productName, sum(S.TotalAmount),
dense_rank() over(partition by C.categoryID order by SUM(s.TotalAmount) desc) as RankNo from Category C
inner join Product P on C.categoryID = P.categoryID inner join Sales S on P.ProductID = S.ProductID
group by C.CategoryID, C.CategoryName, P.ProductID,P.ProductName) as RankedProducts where RankNo = 2;

/* Task 16 
Generate customer lifetime value. */
create table Customer (CustomerID int primary key,CustomerName varchar(100),Gender varchar(20),City varchar(100),
Region varchar(50),JoinDate date);
insert into Customer (CustomerID, CustomerName, Gender, City, Region, JoinDate) values
(201, 'Smith', 'Male', 'New York', 'North', '2022-01-15'),(202, 'Johnson', 'Female', 'Los Angeles', 'West', '2022-03-20'),
(203, 'Michael', 'Male', 'Chicago', 'North', '2022-05-10'),(204, 'Williams', 'Female', 'Houston', 'South', '2022-07-18'),
(205, 'David', 'Male', 'Phoenix', 'West', '2022-09-12'),(206, 'Taylor', 'Female', 'Philadelphia', 'East', '2022-10-25'),
(207, 'Anderson', 'Male', 'San Antonio', 'South', '2023-01-08'),(208, 'Thomas', 'Female', 'San Diego', 'West', '2023-02-14'),
(209, 'Martinez', 'Male', 'Dallas', 'South', '2023-04-30'),(210, 'Davis', 'Female', 'San Jose', 'West', '2023-06-11'),
(211, 'Wilson', 'Male', 'Austin', 'South', '2023-08-19'),(212, 'Emma', 'Female', 'Jacksonville', 'East', '2023-11-05');
Create table Sales(SaleID int primary Key,CustomerID int,ProductID int,SaleDate date,Quantity int,TotalAmount decimal(12,2));
insert into Sales(SaleID, CustomerID, ProductID, SaleDate, Quantity, TotalAmount) 
values(1001, 201, 301, '2024-01-05', 2, 1200.00),(1002, 202, 302, '2024-01-10', 1, 750.00),(1003, 203, 303, '2024-01-15', 5, 2500.00),
(1004, 204, 304, '2024-02-01', 3, 1800.00),(1005, 205, 305, '2024-02-08', 4, 3200.00),(1006, 206, 306, '2024-02-15', 2, 1400.00),
(1007, 207, 307, '2024-03-01', 6, 4200.00),(1008, 208, 308, '2024-03-10', 1, 950.00),(1009, 209, 309, '2024-03-18', 7, 5600.00),
(1010, 210, 310, '2024-03-25', 3, 2100.00);
-- Answer : 
select c.customername,
COUNT(o.orderid) as "Total Orders",SUM(o.orderamount) as "Customer Value" from customers c
inner join orders o on c.customerid = o.customerid
Group by c.customerid, c.customername
order by "Customer Value" desc;

/* Task 17 
Display daily sales with previous day sales and next day sales. */
Create table Sales(SaleID int primary Key,CustomerID int,ProductID int,SaleDate date,Quantity int,TotalAmount decimal(12,2));
insert into Sales(SaleID, CustomerID, ProductID, SaleDate, Quantity, TotalAmount) 
values(1001, 201, 301, '2024-01-05', 2, 1200.00),(1002, 202, 302, '2024-01-10', 1, 750.00),(1003, 203, 303, '2024-01-15', 5, 2500.00),
(1004, 204, 304, '2024-02-01', 3, 1800.00),(1005, 205, 305, '2024-02-08', 4, 3200.00),(1006, 206, 306, '2024-02-15', 2, 1400.00),
(1007, 207, 307, '2024-03-01', 6, 4200.00),(1008, 208, 308, '2024-03-10', 1, 950.00),(1009, 209, 309, '2024-03-18', 7, 5600.00),
(1010, 210, 310, '2024-03-25', 3, 2100.00);
-- Answer : 
with DailySales as(select saledate,SUM(amount) as dailyrevenue from sales group by saledate)
select sale_date, daily_revenue,
    lag(daily_revenue) over (order by sale_date) as "Previous Day Revenue",
    lead(daily_revenue) over (order by sale_date) as "Next Day Revenue" from DailySales
order by saledate;

/* Task 18 
Find the top five customers in each region. */
create table Customer (CustomerID int primary key,CustomerName varchar(100),Gender varchar(20),City varchar(100),
Region varchar(50),JoinDate date);
insert into Customer (CustomerID, CustomerName, Gender, City, Region, JoinDate) values
(201, 'Smith', 'Male', 'New York', 'North', '2022-01-15'),(202, 'Johnson', 'Female', 'Los Angeles', 'West', '2022-03-20'),
(203, 'Michael', 'Male', 'Chicago', 'North', '2022-05-10'),(204, 'Williams', 'Female', 'Houston', 'South', '2022-07-18'),
(205, 'David', 'Male', 'Phoenix', 'West', '2022-09-12'),(206, 'Taylor', 'Female', 'Philadelphia', 'East', '2022-10-25'),
(207, 'Anderson', 'Male', 'San Antonio', 'South', '2023-01-08'),(208, 'Thomas', 'Female', 'San Diego', 'West', '2023-02-14'),
(209, 'Martinez', 'Male', 'Dallas', 'South', '2023-04-30'),(210, 'Davis', 'Female', 'San Jose', 'West', '2023-06-11'),
(211, 'Wilson', 'Male', 'Austin', 'South', '2023-08-19'),(212, 'Emma', 'Female', 'Jacksonville', 'East', '2023-11-05');
Create table Sales(SaleID int primary Key,CustomerID int,ProductID int,SaleDate date,Quantity int,TotalAmount decimal(12,2));
insert into Sales(SaleID, CustomerID, ProductID, SaleDate, Quantity, TotalAmount) 
values(1001, 201, 301, '2024-01-05', 2, 1200.00),(1002, 202, 302, '2024-01-10', 1, 750.00),(1003, 203, 303, '2024-01-15', 5, 2500.00),
(1004, 204, 304, '2024-02-01', 3, 1800.00),(1005, 205, 305, '2024-02-08', 4, 3200.00),(1006, 206, 306, '2024-02-15', 2, 1400.00),
(1007, 207, 307, '2024-03-01', 6, 4200.00),(1008, 208, 308, '2024-03-10', 1, 950.00),(1009, 209, 309, '2024-03-18', 7, 5600.00),
(1010, 210, 310, '2024-03-25', 3, 2100.00);
-- Answer : 
with CustomerRevenue as (
select c.region,c.customername,SUM(o.order_amount) AS totalrevenue from customers c
inner join orders o on c.customer_id = o.customer_id
group by c.region,c.customerid,c.customername),
RankedCustomers as (select region,customername,totalrevenue,
rank() over (partition by region order by total_revenue desc) as customerrank from CustomerRevenue)
select region,customername,totalrevenue,customerrank from RankedCustomers
where customerrank <= 5
order by region, customerrank,totalrevenue desc;

/* Task 19 
Create a View for monthly sales reporting. */
Create table Sales(SaleID int primary Key,CustomerID int,ProductID int,SaleDate date,Quantity int,TotalAmount decimal(12,2));
insert into Sales(SaleID, CustomerID, ProductID, SaleDate, Quantity, TotalAmount) 
values(1001, 201, 301, '2024-01-05', 2, 1200.00),(1002, 202, 302, '2024-01-10', 1, 750.00),(1003, 203, 303, '2024-01-15', 5, 2500.00),
(1004, 204, 304, '2024-02-01', 3, 1800.00),(1005, 205, 305, '2024-02-08', 4, 3200.00),(1006, 206, 306, '2024-02-15', 2, 1400.00),
(1007, 207, 307, '2024-03-01', 6, 4200.00),(1008, 208, 308, '2024-03-10', 1, 950.00),(1009, 209, 309, '2024-03-18', 7, 5600.00),
(1010, 210, 310, '2024-03-25', 3, 2100.00);
-- Answer : 
create view MonthlySales as
select date_format(sale_date, '%Y-%m') as salesmonth, count(sale_id) AS totalorders,
sum(amount) AS totalrevenue,sum(quantity) AS totalsold from sales
group by date_format(sale_date, '%Y-%m');

/* Task 20 
Generate a CTE to simplify regional sales analysis. */
create table Customer (CustomerID int primary key,CustomerName varchar(100),Gender varchar(20),City varchar(100),
Region varchar(50),JoinDate date);
insert into Customer (CustomerID, CustomerName, Gender, City, Region, JoinDate) values
(201, 'Smith', 'Male', 'New York', 'North', '2022-01-15'),(202, 'Johnson', 'Female', 'Los Angeles', 'West', '2022-03-20'),
(203, 'Michael', 'Male', 'Chicago', 'North', '2022-05-10'),(204, 'Williams', 'Female', 'Houston', 'South', '2022-07-18'),
(205, 'David', 'Male', 'Phoenix', 'West', '2022-09-12'),(206, 'Taylor', 'Female', 'Philadelphia', 'East', '2022-10-25'),
(207, 'Anderson', 'Male', 'San Antonio', 'South', '2023-01-08'),(208, 'Thomas', 'Female', 'San Diego', 'West', '2023-02-14'),
(209, 'Martinez', 'Male', 'Dallas', 'South', '2023-04-30'),(210, 'Davis', 'Female', 'San Jose', 'West', '2023-06-11'),
(211, 'Wilson', 'Male', 'Austin', 'South', '2023-08-19'),(212, 'Emma', 'Female', 'Jacksonville', 'East', '2023-11-05');
Create table Sales(SaleID int primary Key,CustomerID int,ProductID int,SaleDate date,Quantity int,TotalAmount decimal(12,2));
insert into Sales(SaleID, CustomerID, ProductID, SaleDate, Quantity, TotalAmount) 
values(1001, 201, 301, '2024-01-05', 2, 1200.00),(1002, 202, 302, '2024-01-10', 1, 750.00),(1003, 203, 303, '2024-01-15', 5, 2500.00),
(1004, 204, 304, '2024-02-01', 3, 1800.00),(1005, 205, 305, '2024-02-08', 4, 3200.00),(1006, 206, 306, '2024-02-15', 2, 1400.00),
(1007, 207, 307, '2024-03-01', 6, 4200.00),(1008, 208, 308, '2024-03-10', 1, 950.00),(1009, 209, 309, '2024-03-18', 7, 5600.00),
(1010, 210, 310, '2024-03-25', 3, 2100.00);
-- Answer : 
with RegionalSales as (select c.region, COUNT(distinct c.customer_id) AS totalcustomers,
count(o.order_id) as totalorders, SUM(o.order_amount) as totalrevenue from customers c
inner join orders o on c.customer_id = o.customer_id group by c.region)
select region,totalcustomers,total_orders,total_revenue,
round(total_revenue / total_customers, 2) from RegionalSales
order by total_revenue desc;

/* Module 3 – Data Lake & Batch Processing (Tasks 21–30) 
Task 21 
Compare today's batch record count with yesterday's batch. */
Create table Batch_Master (Batch_ID int primary key,Batch_Name varchar(100),Batch_Date date,Load_Status varchar(20));
insert into Batch_Master (Batch_ID, Batch_Name, Batch_Date, Load_Status)
values(101, 'Customer Data Load', '2026-08-01', 'Success'),(102, 'Sales Data Load', '2026-08-02', 'Failed'),
(103, 'Product Data Load', '2026-08-03', 'Success'),(104, 'Inventory Data Load', '2026-08-04', 'Partial'),
(105, 'Finance Data Load', '2026-08-05', 'Success');
create table Staging_Customer (Customer_ID int,Customer_Name varchar(100),Email varchar(100),Phone varchar(20),City varchar(100),Batch_ID int,
Validation_Status varchar(20));
insert into Staging_Customer(Customer_ID, Customer_Name, Email, Phone, City, Batch_ID, Validation_Status)
values(1001, 'Smith', 'john.smith@email.com', '9876543210', 'New York', 101, 'Valid'),
(1002, 'Emily Johnson', 'emily.johnson@email.com', '9876543211', 'Los Angeles', 101, 'Valid'),
(1003, 'Michael ', 'michael.brown@email.com', '9876543212', 'Chicago', 102, 'Invalid'),
(1004, 'Davis', 'sophia.davis@email.com', '9876543213', 'Houston', 102, 'Valid'),
(1005, 'William', 'william.wilson@email.com', '9876543214', 'Phoenix', 103, 'Valid'),
(1006, 'Olivia', 'olivia.taylor@email.com', '9876543215', 'Philadelphia', 103, 'Pending'),
(1007, ' Anderson', 'james.anderson@email.com', '9876543216', 'San Antonio', 104, 'Valid'),
(1008, 'Charlotte', 'charlotte.thomas@email.com', '9876543217', 'San Diego', 104, 'Invalid'),
(1009, 'Benjamin', 'benjamin.moore@email.com', '9876543218', 'Dallas', 105, 'Valid'),
(1010, 'Amelia', 'amelia.martin@email.com', '9876543219', 'San Jose', 105, 'Pending'),
(1011, 'Henry', 'henry.jackson@email.com', '9876543220', 'Austin', 101, 'Valid'),
(1012, 'Evelyn', 'evelyn.white@email.com', '9876543221', 'Jacksonville', 102, 'Invalid');
-- Answer : 
select b.Batch_Date, Count(S.Customer_ID),lag(COUNT(S.Customer_ID))
over (order by B.Batch_Date), Count(s.Customer_ID)  - lag(COUNT(S.Customer_ID)) over (order by B.Batch_Date) from Batch_Master B
inner join Staging_Customer S on bm.Batch_ID = s.Batch_ID
group by b.Batch_Date order by b.Batch_Date;

/* Task 22 
Identify duplicate records loaded into the staging table. */
create table Staging_Customer (Customer_ID int,Customer_Name varchar(100),Email varchar(100),Phone varchar(20),City varchar(100),Batch_ID int,
Validation_Status varchar(20));
insert into Staging_Customer(Customer_ID, Customer_Name, Email, Phone, City, Batch_ID, Validation_Status)
values(1001, 'Smith', 'smith@email.com', '9876543210', 'New York', 101, 'Valid'),
(1002, 'Emily', 'emily@email.com', '9876543211', 'Los Angeles', 101, 'Valid'),
(1003, 'Michael ', 'michael@email.com', '9876543212', 'Chicago', 102, 'Invalid'),
(1004, 'Davis', 'davis@email.com', '9876543213', 'Houston', 102, 'Valid'),
(1005, 'William', 'william@email.com', '9876543214', 'Phoenix', 103, 'Valid'),
(1006, 'Olivia', 'olivia@email.com', '9876543215', 'Philadelphia', 103, 'Pending'),
(1007, ' Anderson', 'anderson@email.com', '9876543216', 'San Antonio', 104, 'Valid'),
(1008, 'Charlotte', 'charlotte@email.com', '9876543217', 'San Diego', 104, 'Invalid'),
(1009, 'Benjamin', 'benjamin@email.com', '9876543218', 'Dallas', 105, 'Valid'),
(1010, 'Amelia', 'amelia@email.com', '9876543219', 'San Jose', 105, 'Pending'),
(1011, 'Henry', 'henry@email.com', '9876543220', 'Austin', 101, 'Valid'),
(1012, 'Evelyn', 'evelyn@email.com', '9876543221', 'Jacksonville', 102, 'Invalid');
-- Answer : 
select Customer_ID,COUNT(*)from Staging_Customer
group by Customer_ID having count(*) > 1 order by Customer_ID;

/* Task 23 
Find NULL values in mandatory columns. */
create table Staging_Customer (Customer_ID int,Customer_Name varchar(100),Email varchar(100),Phone varchar(20),City varchar(100),Batch_ID int,
Validation_Status varchar(20));
insert into Staging_Customer(Customer_ID, Customer_Name, Email, Phone, City, Batch_ID, Validation_Status)
values(1001, 'Smith', 'smith@email.com', '9876543210', 'New York', 101, 'Valid'),
(1002, 'Emily', 'emily@email.com', '9876543211', 'Los Angeles', 101, null),
(1003, 'Michael ', 'michael@email.com', '9876543212', 'Chicago', 102, 'Invalid'),
(1004, 'Davis', 'davis@email.com', '9876543213', 'Houston', 102, 'Valid'),
(1005, 'William', 'william@email.com', '9876543214', 'Phoenix', 103, 'Valid'),
(1006, 'Olivia', 'olivia@email.com', '9876543215', 'Philadelphia', null, 'Pending'),
(1007, ' Anderson', 'anderson@email.com', '9876543216', 'San Antonio', 104, 'Valid'),
(1008, 'Charlotte', 'charlotte@email.com', '9876543217', 'San Diego', 104, 'Invalid'),
(1009, 'Benjamin', 'benjamin@email.com', '9876543218', 'Dallas', 105, 'Valid'),
(1010, 'Amelia', 'amelia@email.com', 'null', 'San Jose', 105, 'Pending'),
(1011, 'Henry', 'henry@email.com', '9876543220', 'Austin', 101, 'Valid'),
(1012, 'Evelyn', null, '9876543221', 'Jacksonville', 102, 'Invalid');
-- Answer : 
select Customer_ID, Customer_Name,Email,Phone from Staging_Customer
where Customer_Name is null or Email is null or Phone is null
order by Customer_ID;

/* Task 24 
Generate batch-wise load statistics. */
Create table Batch_Master (Batch_ID int primary key,Batch_Name varchar(100),Batch_Date date,Load_Status varchar(20));
insert into Batch_Master (Batch_ID, Batch_Name, Batch_Date, Load_Status)
values(101, 'Customer Data Load', '2026-08-01', 'Success'),(102, 'Sales Data Load', '2026-08-02', 'Failed'),
(103, 'Product Data Load', '2026-08-03', 'Success'),(104, 'Inventory Data Load', '2026-08-04', 'Partial'),
(105, 'Finance Data Load', '2026-08-05', 'Success');
create table Staging_Customer (Customer_ID int,Customer_Name varchar(100),Email varchar(100),Phone varchar(20),City varchar(100),Batch_ID int,
Validation_Status varchar(20));
insert into Staging_Customer(Customer_ID, Customer_Name, Email, Phone, City, Batch_ID, Validation_Status)
values(1001, 'Smith', 'john.smith@email.com', '9876543210', 'New York', 101, 'Valid'),
(1002, 'Emily Johnson', 'emily.johnson@email.com', '9876543211', 'Los Angeles', 101, 'Valid'),
(1003, 'Michael ', 'michael.brown@email.com', '9876543212', 'Chicago', 102, 'Invalid'),
(1004, 'Davis', 'sophia.davis@email.com', '9876543213', 'Houston', 102, 'Valid'),
(1005, 'William', 'william.wilson@email.com', '9876543214', 'Phoenix', 103, 'Valid'),
(1006, 'Olivia', 'olivia.taylor@email.com', '9876543215', 'Philadelphia', 103, 'Pending'),
(1007, ' Anderson', 'james.anderson@email.com', '9876543216', 'San Antonio', 104, 'Valid'),
(1008, 'Charlotte', 'charlotte.thomas@email.com', '9876543217', 'San Diego', 104, 'Invalid'),
(1009, 'Benjamin', 'benjamin.moore@email.com', '9876543218', 'Dallas', 105, 'Valid'),
(1010, 'Amelia', 'amelia.martin@email.com', '9876543219', 'San Jose', 105, 'Pending'),
(1011, 'Henry', 'henry.jackson@email.com', '9876543220', 'Austin', 101, 'Valid'),
(1012, 'Evelyn', 'evelyn.white@email.com', '9876543221', 'Jacksonville', 102, 'Invalid');
Create table Rejected_Records (Reject_ID int primary key,Customer_ID int,Batch_ID int,Reject_Reason varchar(200));
insert into Rejected_Records (Reject_ID, Customer_ID, Batch_ID, Reject_Reason)
values(1, 1003, 102, 'Duplicate Customer ID'),(2, 1008, 104, 'Invalid Email Address'),(3, 1013, 106, 'Customer Name is NULL'),
(4, 1014, 106, 'Email is NULL'),(5, 1015, 107, 'Phone Number is NULL'),(6, 1016, 107, 'Multiple Mandatory Fields Missing'),
(7, 1017, 108, 'Phone Number is NULL'),(8, 1006, 103, 'Invalid Customer Data');
-- Answer : 
select B.Batch_ID, B.Batch_Date, coalesce(s.Total_Records, 0),
coalesce(s.Successful_Records, 0),coalesce(r.Rejected_Records, 0) from Batch_Master B
left join (select Batch_ID, count(*) AS Total_Records, count(case
when Validation_Status = 'Valid' then 1 end) as Successful_Records from Staging_Customer
group by Batch_ID) s on B.Batch_ID = S.Batch_ID
left join (select Batch_ID, count(*) as Rejected_Records from Rejected_Records
group by Batch_ID) r on B.Batch_ID = R.Batch_ID
order by B.Batch_Date;

/* Task 25 
Find records rejected during ETL processing. */
Create table Rejected_Records (Reject_ID int primary key,Customer_ID int,Batch_ID int,Reject_Reason varchar(200));
insert into Rejected_Records (Reject_ID, Customer_ID, Batch_ID, Reject_Reason)
values(1, 1003, 102, 'Duplicate Customer ID'),(2, 1008, 104, 'Invalid Email Address'),(3, 1013, 106, 'Customer Name is NULL'),
(4, 1014, 106, 'Email is NULL'),(5, 1015, 107, 'Phone Number is NULL'),(6, 1016, 107, 'Multiple Mandatory Fields Missing'),
(7, 1017, 108, 'Phone Number is NULL'),(8, 1006, 103, 'Invalid Customer Data');
-- Answer : 
select Customer_ID,Batch_ID,Reject_Reason AS "Reject Reason"from Rejected_Records
where Reject_Reason is not null
order by Batch_ID, Customer_ID;

/* Task 26 
Create a Temporary Table containing invalid records for further validation. */
create table Staging_Customer (Customer_ID int,Customer_Name varchar(100),Email varchar(100),Phone varchar(20),City varchar(100),Batch_ID int,
Validation_Status varchar(20));
insert into Staging_Customer(Customer_ID, Customer_Name, Email, Phone, City, Batch_ID, Validation_Status)
values(1001, 'Smith', 'smith@email.com', '9876543210', 'New York', 101, 'Valid'),
(1002, 'Emily', 'emily@email.com', '9876543211', 'Los Angeles', 101, 'Valid'),
(1003, 'Michael ', 'michael@email.com', '9876543212', 'Chicago', 102, 'Invalid'),
(1004, 'Davis', 'davis@email.com', '9876543213', 'Houston', 102, 'Valid'),
(1005, 'William', 'william@email.com', '9876543214', 'Phoenix', 103, 'Valid'),
(1006, 'Olivia', 'olivia@email.com', '9876543215', 'Philadelphia', 103, 'Pending'),
(1007, ' Anderson', 'anderson@email.com', '9876543216', 'San Antonio', 104, 'Valid'),
(1008, 'Charlotte', 'charlotte@email.com', '9876543217', 'San Diego', 104, 'Invalid'),
(1009, 'Benjamin', 'benjamin@email.com', '9876543218', 'Dallas', 105, 'Valid'),
(1010, 'Amelia', 'amelia@email.com', '9876543219', 'San Jose', 105, 'Pending'),
(1011, 'Henry', 'henry@email.com', '9876543220', 'Austin', 101, 'Valid'),
(1012, 'Evelyn', 'evelyn@email.com', '9876543221', 'Jacksonville', 102, 'Invalid');
-- Answer : 
create temporary table Temp_Invalid_Customers as
select Customer_ID,Customer_Name,Email,Phone,City,Batch_ID,Validation_Status from Staging_Customer
where Validation_Status = 'Invalid';

/* Task 27 
Find source records that failed to reach the target table. */
create table Source_Customer (Customer_ID int,Customer_Name varchar(100),Email varchar(100),Phone varchar(20),City varchar(100),
Batch_ID int);
insert into Source_Customer(Customer_ID, Customer_Name, Email, Phone, City, Batch_ID)
values(2001, 'Robert', 'robert@email.com', '5551000001', 'New York', 101),(2002, 'Jennifer', 'jennifer@email.com', '5551000002', 'Los Angeles', 101),
(2003, 'David', 'david@email.com', '5551000003', 'Chicago', 101),(2004, 'Linda', 'linda@email.com', '5551000004', 'Houston', 101),
(2005, 'Richard', 'richard@email.com', '5551000005', 'Phoenix', 101);
create table Warehouse_Customer (Customer_ID int,Customer_Name varchar(100),Email varchar(100),Phone varchar(20),City varchar(100),
Batch_ID int,Load_Date date);
insert into Warehouse_Customer (Customer_ID, Customer_Name, Email, Phone, City, Batch_ID, Load_Date)
values (2021, 'Mark', 'mark@email.com', '5551000021', 'Boston', 105, '2026-08-05'),
(2022, 'Betty', 'betty@email.com', '5551000022', 'Nashville', 105, '2026-08-05'),
(2023, 'Steven', 'steven@email.com', '5551000023', 'Detroit', 105, '2026-08-05'),
(2024, 'Helen', 'helen@email.com', '5551000024', 'Portland', 105, '2026-08-05'),
(2025, 'Paul', 'paul@email.com', '5551000025', 'Las Vegas', 105, '2026-08-05');
-- Answer : 
select s.Customer_ID, s.Customer_Name from Source_Customer s
left join Warehouse_Customer w on s.Customer_ID = w.Customer_ID
where w.Customer_ID is null
order by s.Customer_ID;

/* Task 28 
Identify records loaded multiple times into the warehouse. */
create table Warehouse_Customer (Customer_ID int,Customer_Name varchar(100),Email varchar(100),Phone varchar(20),City varchar(100),
Batch_ID int,Load_Date date);
insert into Warehouse_Customer (Customer_ID, Customer_Name, Email, Phone, City, Batch_ID, Load_Date)
values (2021, 'Mark', 'mark@email.com', '5551000021', 'Boston', 105, '2026-08-05'),
(2022, 'Betty', 'betty@email.com', '5551000022', 'Nashville', 105, '2026-08-05'),
(2023, 'Steven', 'steven@email.com', '5551000023', 'Detroit', 105, '2026-08-05'),
(2024, 'Helen', 'helen@email.com', '5551000024', 'Portland', 105, '2026-08-05'),
(2025, 'Paul', 'paul@email.com', '5551000025', 'Las Vegas', 105, '2026-08-05');
-- Answer : 
select Customer_ID,count(*)from Warehouse_Customer
group by Customer_ID having count(*) > 1
order by Customer_ID;

/* Task 29 
Generate source-to-target reconciliation report. */
create table Source_Customer (Customer_ID int,Customer_Name varchar(100),Email varchar(100),Phone varchar(20),City varchar(100),
Batch_ID int);
insert into Source_Customer(Customer_ID, Customer_Name, Email, Phone, City, Batch_ID)
values(2001, 'Robert', 'robert@email.com', '5551000001', 'New York', 101),(2002, 'Jennifer', 'jennifer@email.com', '5551000002', 'Los Angeles', 101),
(2003, 'David', 'david@email.com', '5551000003', 'Chicago', 101),(2004, 'Linda', 'linda@email.com', '5551000004', 'Houston', 101),
(2005, 'Richard', 'richard@email.com', '5551000005', 'Phoenix', 101);
create table Warehouse_Customer (Customer_ID int,Customer_Name varchar(100),Email varchar(100),Phone varchar(20),City varchar(100),
Batch_ID int,Load_Date date);
insert into Warehouse_Customer (Customer_ID, Customer_Name, Email, Phone, City, Batch_ID, Load_Date)
values (2021, 'Mark', 'mark@email.com', '5551000021', 'Boston', 105, '2026-08-05'),
(2022, 'Betty', 'betty@email.com', '5551000022', 'Nashville', 105, '2026-08-05'),
(2023, 'Steven', 'steven@email.com', '5551000023', 'Detroit', 105, '2026-08-05'),
(2024, 'Helen', 'helen@email.com', '5551000024', 'Portland', 105, '2026-08-05'),
(2025, 'Paul', 'paul@email.com', '5551000025', 'Las Vegas', 105, '2026-08-05');
Create table Rejected_Records (Reject_ID int primary key,Customer_ID int,Batch_ID int,Reject_Reason varchar(200));
insert into Rejected_Records (Reject_ID, Customer_ID, Batch_ID, Reject_Reason)
values(1, 1003, 102, 'Duplicate Customer ID'),(2, 1008, 104, 'Invalid Email Address'),(3, 1013, 106, 'Customer Name is NULL'),
(4, 1014, 106, 'Email is NULL'),(5, 1015, 107, 'Phone Number is NULL'),(6, 1016, 107, 'Multiple Mandatory Fields Missing'),
(7, 1017, 108, 'Phone Number is NULL'),(8, 1006, 103, 'Invalid Customer Data');
-- Answer : 
select (select count(*) from Source_Customer) as "Total Source Records",
(select count(*) from Warehouse_Customer) as "Total Warehouse Records",
(select count(*)from Rejected_Records) as "Total Rejected Records",
((select count(*)from Source_Customer)-((select count(*)from Warehouse_Customer)+(select Count(*)from Rejected_Records))) as "Difference";

/* Task 30 
Find tables having the highest daily growth. */
with TableCounts as (select B.Batch_Date,'Source_Customer',count(S.Customer_ID) as Records_Loaded from Batch_Master B
left join Source_Customer S on B.Batch_ID = S.Batch_ID group by bm.Batch_Date union all
select B.Batch_Date, 'Staging_Customer',Count(S.Customer_ID) from Batch_Master B left join Staging_Customer S on B.Batch_ID = S.Batch_ID
group by B.Batch_Date union all
select B.Batch_Date, 'Warehouse_Customer', count(W.Customer_ID)from Batch_Master B
left join Warehouse_Customer W on B.Batch_ID = W.Batch_ID
group by B.Batch_Date union all
select B.Batch_Date,'Rejected_Records',Count(R.Reject_ID) from Batch_Master B
left join Rejected_Records R on B.Batch_ID = R.Batch_ID
group by B.Batch_Date),
Growth as (select Batch_Date,Table_Name, Records_Loaded,Records_Loaded - lag(Records_Loaded) over (partition by Table_Name
order by Batch_Date) as Daily_Growth from TableCounts)
select Batch_Date, Table_Name, Records_Loaded,Daily_Growth from Growth
where Daily_Growth is not null
order by Daily_Growth desc limit 1;

-- Module 4
Create table Branch(Branch_ID int primary key,Branch_Name varchar(100),City varchar(100));
insert into Branch(Branch_ID, Branch_Name, City)
values(1, 'Chennai Branch', 'Chennai'),(2, 'Bangalore Branch', 'Bangalore'),(3, 'Hyderabad Branch', 'Hyderabad'),
(4, 'Mumbai Branch', 'Mumbai'),(5, 'Delhi Branch', 'Delhi');
create table Customer (Customer_ID int primary key,Customer_Name varchar(100),Mobile_Number varchar(15),City varchar(100));
insert into Customer(Customer_ID, Customer_Name, Mobile_Number, City)
values(1001, 'John', '9876543210', 'Chennai'),(1002, 'Emily', '9876543211', 'Bangalore'),(1003, 'Michael', '9876543212', 'Hyderabad'),
(1004, 'Sophia', '9876543213', 'Mumbai'),(1005, 'William', '9876543214', 'Delhi'),(1006, 'Olivia', '9876543215', 'Chennai'),
(1007, 'James', '9876543216', 'Bangalore'),(1008, 'Charlotte', '9876543217', 'Hyderabad'),(1009, 'Benjamin', '9876543218', 'Mumbai'),
(1010, 'Amelia', '9876543219', 'Delhi');
Create table Account (Account_ID int primary key,
Customer_ID int,Branch_ID int,Account_Type varchar(30),Opening_Date date,Balance decimal(12,2),Account_Status varchar(20));
insert into Account(Account_ID, Customer_ID, Branch_ID, Account_Type, Opening_Date, Balance, Account_Status)
values(5001, 1001, 1, 'Savings', '2025-01-15', 25000.00, 'Active'),(5002, 1002, 2, 'Current', '2025-02-20', 45000.00, 'Active'),
(5003, 1003, 3, 'Savings', '2025-03-10', 18000.00, 'Active'),(5004, 1004, 4, 'Current', '2025-04-05', 62000.00, 'Active'),
(5005, 1005, 5, 'Savings', '2025-05-12', 32000.00, 'Active'),(5006, 1006, 1, 'Savings', '2025-06-18', 15000.00, 'Active'),
(5007, 1007, 2, 'Current', '2025-07-22', 55000.00, 'Active'),(5008, 1008, 3, 'Savings', '2025-08-14', 21000.00, 'Inactive'),
(5009, 1009, 4, 'Current', '2025-09-30', 75000.00, 'Active');
Create table Transactions (Transaction_ID int primary key,Account_ID int,Transaction_Date date,Transaction_Type varchar(20),
Transaction_Amount decimal(12,2));
insert into Transactions(Transaction_ID, Account_ID, Transaction_Date, Transaction_Type, Transaction_Amount)
values (9001, 5001, '2025-10-05', 'Deposit', 10000.00),(9002, 5002, 2025-10-10, 'Withdrawal',5000.00),
(9003, 5003, '2025-11-15', 'Deposit', 15000.00),(9004, 5004, '2025-11-20', 'Withdrawal', 8000.00),
(9005, 5005, '2025-12-05', 'Deposit', 12000.00),(9006, 5006, '2025-12-10','Withdrawal', 3000.00);
create table Transaction_Audit (Audit_ID int primary key auto_increment,Transaction_ID int,Account_ID int,Transaction_Amount decimal(12,2),
Deleted_Date datetime);
Delimiter //
create trigger trg_transaction_delete after delete on Transactions for each row
begin insert into Transaction_Audit (Transaction_ID, Account_ID, Transaction_Amount, Deleted_Date) values
(old.Transaction_ID,old.Account_ID,old.Transaction_Amount,Now());
end //
Delimiter ;

/* Task 31 
Generate branch-wise total deposits. */
-- Answer : 
select b.Branch_Name , sum(t.Transaction_Amount) as "Total Deposit Amount" from Branch b
inner join a on b.Branch_ID = a.Branch_ID inner join Transactions t on a.Account_ID = t.Account_ID
where t.Transaction_Type = 'Deposit'
group by b.Branch_ID, b.Branch_Name
order by sum(t.Transaction_Amount) desc;

/* Task 32 
Identify customers with multiple active accounts. */
-- Answer : 
select c.Customer_Name, count(a.Account_ID) as "Number of Active Accounts" from Customer c
inner join Account a on Customer_ID = a.Customer_ID
where a.Account_Status = 'Active'
Group by c.Customer_ID, c.Customer_Name
having Count(a.Account_ID) > 1
order by Count(a.Account_ID) desc;

/* Task 33 
Display the latest transaction for every account. */
-- Answer : 
with RankedTransactions as ( select Account_ID, Transaction_Date, Transaction_Type, Transaction_Amount,
row_number() Over (partition by Account_ID order by Transaction_Date desc) as R from Transactions)
select Account_ID, Transaction_Date,Transaction_Type,Transaction_Amount from RankedTransactions where R = 1
order by Account_ID;

/* Task 34 
Rank customers based on transaction amount. */
-- Answer : 
with CustomerTotals as (select c.Customer_ID, c.Customer_Name,sum(t.Transaction_Amount) as Total_Transaction_Amount from Customer c
inner join Account a on c.Customer_ID = a.Customer_ID inner join Transactions t on a.Account_ID = t.Account_ID 
group by c.Customer_ID,c.Customer_Name)
select Customer_Name ,Total_Transaction_Amount ,
rank() over (order by Total_Transaction_Amount desc) as "Rank"from CustomerTotals
order by "Rank", "Customer Name";

/* Task 35 
Identify suspicious transactions greater than three times the customer's average transaction 
amount.*/
-- Answer :
select c.Customer_Name,t.Account_ID,t.Transaction_Date,t.Transaction_Amount,
(select avg(t2.Transaction_Amount) from Transactions t2 inner join Account a2 on t2.Account_ID = a2.Account_ID
where a2.Customer_ID = c.Customer_ID) AS "Customer Average Transaction Amount" from Customer c
inner join Account a on c.Customer_ID = a.Customer_ID inner join Transactions t on a.Account_ID = t.Account_ID
where t.Transaction_Amount >3 * (select avg(t2.Transaction_Amount) from Transactions t2
inner join Account a2 on t2.Account_ID = a2.Account_ID
where a2.Customer_ID = c.Customer_ID)
order by t.Transaction_Amount desc;

/* Task 36 
Create a View for branch-wise transaction summary.*/
-- Answer: 
Create view Branch_Transaction_Report as
select b.Branch_Name, Count(t.Transaction_ID) AS "Total Transactions",
sum(case when t.Transaction_Type = 'Deposit' then t.Transaction_Amount else 0 end) as "Total Deposit Amount",
sum(case when t.Transaction_Type = 'Withdrawal' then t.Transaction_Amount else 0 end) as "Total Withdrawal Amount"from Branch b
inner join Account a on b.Branch_ID = a.Branch_ID inner join Transactions t on a.Account_ID = t.Account_ID
group by b.Branch_ID,b.Branch_Name; 

/* Task 37 
Write a Stored Procedure to generate customer account statements. */
-- Answer: 
delimiter **
create procedure Get_Account_Statement(in p_Account_ID int) begin
select t.Account_ID,t.Transaction_Date,t.Transaction_Type,t.Transaction_Amount,a.Balance as "Current Balance" from Transactions t
inner join Account a on t.Account_ID = a.Account_ID
where t.Account_ID = p_Account_ID order BY t.Transaction_Date;
end **
delimiter ;

/* Task 38 
Create a Trigger that stores deleted transaction records into an audit table. */
-- Answer: 
delimiter **
create trigger trg_transaction_audit after delete on Transactions for each row
begin insert into Transaction_Audit(Transaction_ID,Account_ID,Transaction_Amount,Deleted_Date)
Values(old.Transaction_ID,old.Account_ID,old.Transaction_Amount,now());
end **
delimiter ;

DELIMITER //

/*Task 39 
Create a BEFORE INSERT Trigger to reject transactions with negative amounts.*/
-- Answer: 
delimiter **
create trigger trg_validate_transaction_amount
before insert on Transactions
for each row Begin
if new.Transaction_Amount < 0 then signal sqlstate '25000' set message_text = 'Transaction amount not be negative'; end if;
end **//
delimiter ;

/* Task 40 
Recommend appropriate indexes to improve transaction search performance. */
-- Answer : 
create index idx_transactions_account_date on Transactions (Account_ID, Transaction_Date);
select * from Transactions
where Account_ID = 5001 and Transaction_Date = '2026-08-09';

/* Module 5 – Advanced Data Engineering 
Scenarios */
create table Department (Department_ID int primary key,Department_Name varchar(100));
insert into Department(Department_ID, Department_Name)
values(1, 'HR'),(2, 'Finance'),(3, 'IT'),(4, 'Sales'),(5, 'Operations');
create table Employee (
Employee_ID int primary key,Employee_Name varchar(100),Department_ID int,Salary decimal(10,2),Hire_Date date);
insert into Employee
(Employee_ID, Employee_Name, Department_ID, Salary, Hire_Date)
values(101, 'James', 1, 45000.00, '2022-01-15'),(102, 'Emily', 2, 52000.00, '2021-03-20'),(103, 'Michael', 3, 75000.00, '2020-06-10'),
(104, 'Sophia', 4, 60000.00, '2022-08-05'),(105, 'Daniel', 5, 48000.00, '2023-02-12'),(106, 'Olivia', 1, 50000.00, '2021-11-18'),
(107, 'William', 2, 58000.00, '2023-04-25'),(108, 'Charlotte', 3, 82000.00, '2019-09-30'),(109, 'Benjamin', 4, 65000.00, '2020-12-14'),
(110, 'Amelia', 5, 55000.00, '2022-07-22');
create table Employee_History (Employee_ID int,Employee_Name varchar(100),Department_ID int,Salary decimal(10,2),Effective_Date date);
insert into Employee_History
(Employee_ID, Employee_Name, Department_ID, Salary, Effective_Date)
values(101, ' Wilson', 1, 42000.00, '2021-01-15'),(101, 'James', 1, 45000.00, '2022-01-15'),(102, ' Brown', 2, 48000.00, '2021-03-20'),
(102, 'Emily', 2, 52000.00, '2023-03-20'),(103, 'Michael ', 3, 68000.00, '2020-06-10'),(103, '\Davis', 3, 75000.00, '2022-06-10');
create table Category (Category_ID int primary key,Category_Name varchar(100));
insert into Category(Category_ID, Category_Name)
values(1, 'Electronics'),(2, 'Clothing'),(3, 'Home Appliances'),(4, 'Books'),(5, 'Sports');
Create table Product (Product_ID int primary key,Product_Name VARCHAR(100),Category_ID INT,Unit_Price DECIMAL(10,2));
insert into Product(Product_ID, Product_Name, Category_ID, Unit_Price)
values(101, 'Laptop', 1, 65000.00),(102, 'Smartphone', 1, 35000.00),(103, 'T-Shirt', 2, 1200.00),(104, 'Jeans', 2, 2500.00),
(105, 'Microwave Oven', 3, 15000.00),(106, 'Programming Book', 4, 1800.00),(107, 'Running Shoes', 5, 4500.00),
(108, 'Headphones', 1, 3000.00);
create table Customer (Customer_ID int primary key,Customer_Name varchar(100),Region varchar(50));
insert into Customer(Customer_ID, Customer_Name, Region)
values(201, 'John', 'North'),(202, 'Emily', 'South'),(203, 'Michael', 'East'),(204, 'Sophia', 'West'),
(205, 'William', 'North'),(206, 'Taylor', 'South');
create table Orders (Order_ID int primary Key,Customer_ID int,Order_Date date);
insert into Orders(Order_ID, Customer_ID, Order_Date)
values(3001, 201, '2026-01-10'),(3002, 202, '2026-01-15'),(3003, 203, '2026-02-05'),
(3004, 204, '2026-02-20'),(3005, 205, '2026-03-10');
create table Fact_Sales (Sale_ID int primary key,Order_ID int,Product_ID int,Quantity int,Sales_Amount decimal(12,2),Batch_ID int);
insert into Fact_Sales(Sale_ID, Order_ID, Product_ID, Quantity, Sales_Amount, Batch_ID)
values(4001, 3001, 101, 1, 65000.00, 1),(4002, 3001, 103, 3, 3600.00, 1),(4003, 3002, 102, 2, 70000.00, 1),(4004, 3002, 104, 2, 5000.00, 1),
(4005, 3003, 105, 1, 15000.00, 2),(4006, 3003,  106, 2, 3600.00, 2),(4007, 3004, 107, 2, 9000.00, 2),
(4008, 3004, 108, 3, 9000.00, 2),(4009, 3005, 101, 1, 65000.00, 3),(4010, 3005, 102, 1, 35000.00, 3);
create table Staging_Sales (Sale_ID int primary Key,Order_ID int,Product_ID int,Quantity int,Sales_Amount decimal(12,2),
Validation_Status varchar(20),Batch_ID int);
insert into Staging_Sales(Sale_ID, Order_ID, Product_ID, Quantity, Sales_Amount, Validation_Status, Batch_ID)
values(5001, 3001, 101, 1, 65000.00, 'Valid', 1),(5002, 3001, 103, 3, 3600.00, 'Valid', 1),(5003, 3002, 102, 2, 70000.00, 'Valid', 1),
(5004, 3002, 104, 2, 5000.00, 'Invalid', 1),(5005, 3003, 105, 1, 15000.00, 'Valid', 2),(5006, 3003, 106, 2, 3600.00, 'Invalid', 2),
(5007, 3004, 107, 2, 9000.00, 'Valid', 2),(5008, 3005, 101, 1, 65000.00, 'Invalid', 3);
create table ETL_Batch (Batch_ID int primary key,Batch_Date DATE,Source_Count int,Staging_Count int,Warehouse_Count int);
insert into ETL_Batch(Batch_ID, Batch_Date, Source_Count, Staging_Count, Warehouse_Count)
values(1, '2026-08-01', 120, 115, 110),(2, '2026-08-02', 150, 145, 140),(3, '2026-08-03', 180, 175, 170),(4, '2026-08-04', 200, 192, 185);
Create table Fact_Sales_Audit (Audit_ID int primary key auto_increment,Sale_ID int,Action_Type varchar(20),Action_Date datetime);

/* Task 41 
Using a CTE, generate department-wise average salary and display employees earning above 
that average. */
-- Answer : 
with Department_Average as(
select Department_ID,avg(Salary) as Department_Average_Salary from Employee
group by Department_ID)
select d.Department_Name,e.Employee_Name,e.Salary,da.Department_Average_Salary from Employee e
inner join Department d on e.Department_ID = d.Department_ID
inner join Department_Average da on e.Department_ID = da.Department_ID
where e.Salary > da.Department_Average_Salary
order by d.Department_Name,e.Salary desc;

/* Task 42 
Generate the top five products for every category using Window Functions. */
with Product_Sales as (
select c.Category_ID,c.Category_Name,p.Product_ID,p.Product_Name,sum(fs.Sales_Amount) as Total_Sales from Category c
inner join Product on c.Category_ID = p.Category_ID
inner join Fact_Sales fs on p.Product_ID = fs.Product_ID
group by c.Category_ID,c.Category_Name,p.Product_ID,p.Product_Name),
Ranked_Products as (
select Category_Name,Product_Name,Total_Sales,
dense_rank() over (partition by Category_ID order by Total_Sales desc) as Product_Rank from Product_Sales)
select Category_Name,Product_Name,Total_Sales,Product_Rank AS "Rank"from Ranked_Products
where Product_Rank <= 5
order by Category_Name,Product_Rank;

/* Task 43 
Create a Temporary Table for the top-selling products and generate multiple reports from it. */
 Create temporary table Top_Selling_Products as
select p.Product_ID,p.Product_Name,sum(fs.Sales_Amount) as Total_Sales from Product p
inner join Fact_Sales fs on p.Product_ID = fs.Product_ID
group by p.Product_ID, p.Product_Name
order by Total_Sales desc
limit 5;

/*Task 44 
Create a Stored Procedure to load validated records from the staging table into the Data 
Warehouse. */
delimiter **
create procedure Load_Valid_Sales()
begin insert into Fact_Sales(Sale_ID,Order_ID,Product_ID,Quantity,Sales_Amount,Batch_ID)
select Sale_ID,Order_ID,Product_ID,Quantity,Sales_Amount,Batch_ID from Staging_Sales
where Validation_Status = 'Valid';
end **
delimiter ;

/* Task 45 
Create a Trigger that logs every INSERT, UPDATE, and DELETE performed on the Fact_Sales 
table. */
delimiter //
create trigger trg_fact_sales_after_insert after insert on Fact_Sales for each row
begin
insert into Fact_Sales_Audit (Sale_ID, Action_Type, Action_Date)
values(new.Sale_ID, 'insert', Now());
end //
delimiter ; -- just change insert to delete or update

/* Task 46 
Create a View that combines Customer, Orders, and Sales information for business reporting. */
-- Answer : 
Create view Customer_Order_Sales_Report as
select c.Customer_Name, o.Order_ID,o.Order_Date,fs.Product_ID,fs.Quantity,fs.Sales_Amount from Customer c
inner join Orders o on c.Customer_ID = o.Customer_ID
inner join Fact_Sales fs on o.Order_ID = fs.Order_ID;

/*Task 47 
Recommend indexes for improving performance of a monthly dashboard query involving 
multiple joins and aggregations. */
-- Answer : 
Create index idx_orders_customer on Orders (Customer_ID);
Customer.Customer_ID = Orders.Customer_ID
select * from Orders
where Customer_ID = 201;

/* Task 48 
Generate a report comparing source, staging, and warehouse record counts for every batch.*/
-- Answer : 
select Batch_ID ,Source_Count,Staging_CountWarehouse_Count,
(Source_Count - Warehouse_Count) as "Difference",
case when Source_Count = Staging_Count and Staging_Count = Warehouse_Count then 'Successful Load'
when Source_Count > Warehouse_Count then 'Partially Successful'
else 'Check Required'end as "Load Status" from ETL_Batch
order by Batch_ID;

/* Task 49 
Identify slowly changing records by comparing historical employee data with the latest snapshot. */
with Latest_History as (
select Employee_ID,Employee_Name,Department_ID,Salary,
row_number() over (partition by Employee_ID order by Effective_Date desc) as rn from Employee_History)
select e.Employee_ID,e.Employee_Name, h.Salary AS "Old Salary",e.Salary AS "New Salary",
old_d.Department_Name AS "Old Department", new_d.Department_Name AS "New Department" from Employee e
inner join Latest_History h on e.Employee_ID = h.Employee_ID and h.rn = 1
inner join Department old_d on h.Department_ID = old_d.Department_ID
inner join Department new_d on e.Department_ID = new_d.Department_ID
where e.Salary <> h.Salary or e.Department_ID <> h.Department_ID
order by e.Employee_ID;

/* Task 50 – End-to-End Data Warehouse Validation Project 
A retail company has loaded data from multiple source systems into a centralized Data */
with Quality_Checks as (select 'null Customer Records' as Check_Name, Count(*) AS Issue_Count from Customer
where Customer_ID is null or Customer_Name is null or Region is null
union all
select 'Invalid Staging Records', count(*)from Staging_Sales
where Validation_Status = 'Invalid'
union all
select'Duplicate Staging Records',count(*)from(select Order_ID, Product_ID from Staging_Sales
group by Order_ID, Product_ID
having count(*) > 1) d
union all
select 'Negative Quantity',count(*)from Staging_Sales
where Quantity <= 0 union all
select'Negative Sales Amount',count(*)from Staging_Sales
where Sales_Amount < 0 union all
select 'Orphan Orders', count(*) from Orders o left join Customer c
on o.Customer_ID = c.Customer_ID
where c.Customer_ID is null union all
select 'Orphan Products', count(*) from Fact_Sales fs left join Product p
on fs.Product_ID = p.Product_ID
where p.Product_ID is null union all
select'Orphan Sales Orders',count(*)from Fact_Sales fs left join Orders o
on fs.Order_ID = o.Order_ID
where o.Order_ID is null union all
select 'Incorrect Sales Amount',count(*)from Fact_Sales fs inner join Product p
on fs.Product_ID = p.Product_ID
where fs.Sales_Amount <> fs.Quantity * p.Unit_Price)
select Check_Name, Issue_Count, case
when Issue_Count = 0 then 'PASS' else 'FAIL'
end from Quality_Checks
order by case
when Issue_count > 0 then 1 else 2 end, Check_Name;
