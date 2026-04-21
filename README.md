# Books Store Project
## Overview
The Books Store Project is a SQL‑based database system designed to manage a bookstore’s core operations. It demonstrates relational database design, query writing, and data manipulation skills using structured datasets.

## This project includes three main entities:

**Books** – Information about available titles, authors, genres, and prices

**Customers** – Details of registered buyers and their contact information

**Orders** – Records of customer purchases, order dates, and quantities

The repository highlights practical SQL development skills, including table creation, relationships, and query optimization.

## Objectives
Build a normalized relational database for a bookstore

Practice SQL queries for data retrieval, filtering, and aggregation

Showcase JOINS to connect multiple tables

Provide a foundation for analytics and reporting

## Features
**Database Schema:** Tables for Books, Customers, and Orders

**Relationships:** Primary keys, foreign keys, and constraints

## Queries:
**1) Retrieve all Books in the "Fiction" Genre.**
```sql
SELECT * FROM Books
WHERE genre='Fiction';
```
**2) Find Books published after the year 1950.**
```sql
SELECT * FROM Books
WHERE published_year>1950;
```
**3) List all the Customers from the Canada.**
```sql
SELECT * FROM Customers
WHERE country='Canada';
```
**4) Show Orders placed in November 2023.**
```sql
SELECT * FROM Orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';
```
**5) Retrieve the total stock of Book avaliable.**
```sql
SELECT SUM(stock) AS total_stocks
FROM Books;
```
**6) Find the details of most expensive Book.**
```sql
SELECT * FROM Books
ORDER BY price DESC
LIMIT 1;
```
**7) Show all Customers who ordered more than 1 quantity.**
```sql
SELECT * FROM Orders
WHERE quantity>1;
```
**8) Retrieve all the Orders where the total amount exceed $20.**
```sql
SELECT * FROM Orders
WHERE total_amount>20;
```
**9) List all the Genre available**
```sql
SELECT DISTINCT Genre FROM Books;
```
**10) Find the Book with the lowest stock.**
```sql
SELECT * FROM Books
ORDER BY stock ASC;
LIMIT 1;
```
**11) Calculate the total revenue genrated from all Orders.**
```sql
SELECT SUM(total_amount) AS total_revenue
FROM Orders;
```
**12) Retrieve the total number of Books sold for each Genre.**
```sql
SELECT b.genre, SUM(o.quantity) AS total_sold
FROM Orders o
JOIN Books b ON b.Book_id=o.Book_id
GROUP BY genre;
```
**13) Find the average price of Books in the Fantasy genre.**
```sql
SELECT AVG(price) AS avg_price
FROM Books
WHERE genre='Fantasy';
```
**14) List Customers who have placed at least 2 Orders.**
```sql
SELECT o.customer_id, c.name, COUNT(o.order_id) AS total_order
FROM Orders o
JOIN Customers c ON c.customer_id=o.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(o.order_id)>=2;
```
**15) Find most frequently order Book.**
```sql
SELECT o.book_id, b.title, COUNT(o.order_id) AS most_order
FROM Orders o
JOIN Books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY most_order DESC
LIMIT 1;
```
**16) Show the top 3 most expensive Book of Fantasy genre.**
```sql
SELECT * FROM Books
WHERE genre='Fantasy'
ORDER BY price DESC
LIMIT 3;
```
**17) Retrive the totaL quantity of Books by each author.**
```sql
SELECT b.author, SUM(o.quantity) AS total_sold
FROM Orders o
JOIN Books b ON o.book_id=b.book_id
GROUP BY b.author;
```
**18) List the cities where Customers who spent over $30 are located.**
```sql
SELECT DISTINCT c.city, o.total_amount
FROM Orders o
JOIN Customers c ON o.customer_id=c.customer_id
WHERE o.total_amount>30;
```
**19) Find the Customer spent the most on order.**
```sql
SELECT c.name, SUM(o.total_amount) AS total_spent
FROM Orders o
JOIN Customers c ON o.customer_id=c.customer_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 1;
```
**20) Calculate the stock remaining after fullfilling all orders.**
```sql
SELECT b.book_id, b.title, b.stock, COALESCE(SUM(quantity),0) AS order_qty,
		b.stock-COALESCE(SUM(quantity),0) AS remaining_stock
FROM Books b
LEFT JOIN Orders o ON b.book_id=o.book_id
GROUP BY b.book_id
ORDER BY b.book_id;
```
