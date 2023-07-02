/**********************************************************************/
/* SQL Queries: Practice your SQL Knowledge! */
/**********************************************************************/

/**********************************************************************/
/* Credit to Schema : https://github.com/AndrejPHP/w3schools-database */
/**********************************************************************/
/* Run w3schools.sql to set up database, tables and data*/

/*
----Schema----
Customers (CustomerID, CustomerName, ContactName, Address, City, PostalCode, Country)
Categories (CategoryID,CategoryName, Description)
Employees (EmployeeID, LastName, FirstName, BirthDate, Photo, Notes)
OrderDetails(OrderDetailID, OrderID, ProductID, Quantity)
Orders (OrderID, CustomerID, EmployeeID, OrderDate, ShipperID)
Products(ProductID, ProductName, SupplierID, CategoryID, Unit, Price)
Shippers (ShipperID, ShipperName, Phone)
*/

/**** Advanced Level *****/
/*1. Select customer name together with each order(orderID) the customer made*/

select c.CustomerName,ors.OrderID
from customers c 
inner join orders ors on c.CustomerID=ors.CustomerID;

/*2. Select order id together with name of employee who handled the order*/

select e.EmployeeID,concat(e.firstname," ",e.lastname) as Full_name,o.orderid
from orders o
join employees e on o.EmployeeID=e.EmployeeID;

/*3. Select customers who did not placed any order yet*/

select c.CustomerName,c.CustomerID
from customers c
left join orders o on c.CustomerID=o.CustomerID 
where o.CustomerID is null;

/*4. Select order id together with the name of products*/

select o.orderid,p.ProductName
from orders o
join products p on o.CustomerID=p.ProductID;

SELECT o.OrderID, p.ProductID, p.ProductName
FROM orders o
JOIN order_details od ON o.OrderID = od.OrderID
JOIN products p ON p.ProductID = od.ProductID
ORDER BY o.OrderID;

/*5. Select products that no one bought*/

select p.ProductName,o.orderid
from products p
left join order_details o on p.ProductID=o.ProductID
where o.OrderID is  null;  

/*6. Select customer together with the products that he bought*/



/*7. Select product names together with the name of corresponding category*/


/*8. Select orders together with the name of the shipping company*/


/*9. Select customers with id greater than 50 together with each order they made*/


/*10. Select employees together with orders with order id greater than 10400*/


/************ Expert Level ************/

/*1. Select the most expensive product*/


/*2. Select the second most expensive product*/
/*version 1*/


/*version 2 (complex)*/
WITH
	tbl1 AS (SELECT ProductID,ProductName,Price
		FROM products
		ORDER BY Price DESC
		LIMIT 2),
	tbl2 AS (SELECT ProductID,ProductName,Price
		FROM products
		ORDER BY Price DESC
		LIMIT 1)
        
SELECT tbl1.ProductID,tbl1.ProductName,tbl1.Price
FROM tbl1
LEFT JOIN tbl2 ON tbl1.ProductID = tbl2.ProductID
WHERE tbl2.ProductID IS NULL;


/*3. Select name and price of each product, sort the result by price in decreasing order*/


/*4. Select 5 most expensive products*/


/*5. Select 5 most expensive products without the most expensive (in final 4 products)*/



/*6. Select name of the cheapest product (only name) without using LIMIT and OFFSET*/



/*7. Select name of the cheapest product (only name) using subquery*/


/* BONUS : same question for Customer this time */


/*9. Select customer name together with the number of orders made by the corresponding customer 
sort the result by number of orders in decreasing order*/


/*10. Add up the price of all products*/

/*11. Select orderID together with the total price of  that Order, order the result by total price of order in increasing order*/


/*12. Select customer who spend the most money*/


/*13. Select customer who spend the most money and lives in Canada*/


/*14. Select customer who spend the second most money*/


/*15. Select shipper together with the total price of proceed orders*/




