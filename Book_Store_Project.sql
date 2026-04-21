CREATE TABLE Books (
	Book_ID SERIAL PRIMARY KEY,
	Title VARCHAR(100) NOT NULL,
	Author VARCHAR(100) NOT NULL,
	Genre VARCHAR(50) NOT NULL,
	Published_Year INT NOT NULL,
	Price NUMERIC(10,2) CHECK (Price> 0),
	Stock INT NOT NULL
);

CREATE TABLE Customers (
	Customer_ID SERIAL PRIMARY KEY,
	Name VARCHAR(100),
	Email VARCHAR(100),
	Phone VARCHAR(15),
	City VARCHAR(50),
	Country VARCHAR(150)
);

CREATE TABLE Orders (
	Order_ID SERIAL PRIMARY KEY,
	Customer_ID INT REFERENCES Customers(customer_id),
	Book_ID INT REFERENCES Books(book_id),
	Order_Date DATE,
	Quantity INT,
	Total_Amount NUMERIC(10,2)
);

SELECT * FROM Books;
SELECT * FROM Orders;
SELECT * FROM Customers;

-- 1) Retrieve all Books in the "Fiction" Genre.
SELECT * FROM Books
WHERE genre='Fiction';

--2) Find Books published after the year 1950.
SELECT * FROM Books
WHERE published_year>1950;

--3) List all the Customers from the Canada.
SELECT * FROM Customers
WHERE country='Canada';

--4) Show Orders placed in November 2023.
SELECT * FROM Orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

--5) Retrieve the total stock of Book avaliable.
SELECT SUM(stock) AS total_stocks
FROM Books;

--6) Find the details of most expensive Book.
SELECT * FROM Books
ORDER BY price DESC
LIMIT 1;

--7) Show all Customers who ordered more than 1 quantity.
SELECT * FROM Orders
WHERE quantity>1;

--8) Retrieve all the Orders where the total amount exceed $20.
SELECT * FROM Orders
WHERE total_amount>20;

--9) List all the Genre available
SELECT DISTINCT Genre FROM Books;

--10) Find the Book with the lowest stock.
SELECT * FROM Books
ORDER BY stock ASC;
LIMIT 1;

--11) Calculate the total revenue genrated from all Orders.
SELECT SUM(total_amount) AS total_revenue
FROM Orders;

--12) Retrieve the total number of Books sold for each Genre.
SELECT b.genre, SUM(o.quantity) AS total_sold
FROM Orders o
JOIN Books b ON b.Book_id=o.Book_id
GROUP BY genre;

--13) Find the average price of Books in the Fantasy genre.
SELECT AVG(price) AS avg_price
FROM Books
WHERE genre='Fantasy';

--14) List Customers who have placed at least 2 Orders.
SELECT o.customer_id, c.name, COUNT(o.order_id) AS total_order
FROM Orders o
JOIN Customers c ON c.customer_id=o.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(o.order_id)>=2;

--15) Find most frequently order Book.
SELECT o.book_id, b.title, COUNT(o.order_id) AS most_order
FROM Orders o
JOIN Books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY most_order DESC
LIMIT 1;

--16) Show the top 3 most expensive Book of Fantasy genre.
SELECT * FROM Books
WHERE genre='Fantasy'
ORDER BY price DESC
LIMIT 3;

--17) Retrive the totaL quantity of Books by each author.
SELECT b.author, SUM(o.quantity) AS total_sold
FROM Orders o
JOIN Books b ON o.book_id=b.book_id
GROUP BY b.author;

--18) List the cities where Customers who spent over $30 are located.
SELECT DISTINCT c.city, o.total_amount
FROM Orders o
JOIN Customers c ON o.customer_id=c.customer_id
WHERE o.total_amount>30;

--19) Find the Customer spent the most on order.
SELECT c.name, SUM(o.total_amount) AS total_spent
FROM Orders o
JOIN Customers c ON o.customer_id=c.customer_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 1;

--20) Calculate the stock remaining after fullfilling all orders.
SELECT b.book_id, b.title, b.stock, COALESCE(SUM(quantity),0) AS order_qty,
		b.stock-COALESCE(SUM(quantity),0) AS remaining_stock
FROM Books b
LEFT JOIN Orders o ON b.book_id=o.book_id
GROUP BY b.book_id
ORDER BY b.book_id;