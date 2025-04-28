/*Switch to the database
\c OnlineBookstore;*/


-- CREATE THE BOOK TABLE

CREATE TABLE IF NOT EXISTS Book(
Book_ID	SERIAL PRIMARY KEY,
Title	VARCHAR(100) ,
Author	VARCHAR(100) ,
Genre	VARCHAR(100) ,
Published_Year	INT,
Price	NUMERIC(10,2),
Stock	INT
);

SELECT * FROM Book;

-- CREATE THE Customers TABLE

CREATE TABLE IF NOT EXISTS Customers(
Customer_ID	SERIAL PRIMARY KEY,
Name	VARCHAR(100),
Email	VARCHAR(100),
Phone	VARCHAR(15),
City	VARCHAR(50),
Country	VARCHAR(100)

);

SELECT * FROM Customers;

-- CREATE THE Orders TABLE

CREATE TABLE IF NOT EXISTS Orders(

Order_ID	SERIAL PRIMARY KEY, 
Customer_ID	INT REFERENCES Customers(Customer_ID),
Book_ID	INT REFERENCES Book(Book_ID),
Order_Date	DATE,
Quantity	INT,
Total_Amount	NUMERIC(10,2)

);

SELECT * FROM Orders;

--BASIC QUERIES
-- 1) Retrieve all books in the "Fiction" genre:
SELECT * FROM Book
WHERE Genre = 'Fiction';

-- 2) Find books published after the year 1950:
SELECT * FROM Book
WHERE Published_Year>= 1950;


-- 3) List all customers from the Canada:
SELECT * FROM Customers
WHERE Country= 'Canada';


-- 4) Show orders placed in November 2023:

SELECT * FROM Orders
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';


-- 5) Retrieve the total stock of books available:

SELECT SUM(Stock) as Total_stock  FROM 
Book;


-- 6) Find the details of the most expensive book:

SELECT  *  
FROM Book 
ORDER BY Price DESC
limit 1;


-- 7) Show all customers who ordered more than 1 quantity of a book:
  SELECT c.Customer_ID,c.Name,
  o.Quantity
FROM  Customers c
INNER JOIN
Orders o
ON 
c.Customer_ID= o.Customer_ID AND o.Quantity>1;


-- 8) Retrieve all orders where the total amount exceeds $20:

SELECT * FROM Orders
WHERE Total_Amount>20;


-- 9) List all genres available in the Books table:

SELECT Genre
FROM Book
GROUP BY Genre;


-- 10) Find the book with the lowest stock:

SELECT* FROM
Book
ORDER BY Stock asc
limit 1;


-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(Total_Amount)AS REVENUE
FROM Orders;



-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
SELECT b.Genre, SUM(o.Quantity) AS Book_sold
FROM  Book b
INNER JOIN
Orders o
ON 
b.Book_ID= o.Book_ID 
GROUP BY Genre;


-- 2) Find the average price of books in the "Fantasy" genre:
SELECT Genre,AVG(price)
OVER(PARTITION BY Genre) AS AVG_gENRE_PRICE
FROM Book
WHERE Genre='Fantasy';


-- 3) List customers who have placed at least 2 orders:



SELECT o.Customer_ID, c.Name, COUNT(o.Order_ID) AS Order_ID
FROM   Orders o
 JOIN
Customers c
ON 
o.Customer_ID = c.Customer_ID 
GROUP BY o.Customer_ID,c.Name
HAVING COUNT(Order_ID)>=2
ORDER BY Customer_ID  Asc;



-- 4) Find the most frequently ordered book:

SELECT * FROM Orders;

SELECT o.Book_ID, b.Title, COUNT(o.Order_ID) AS Order_ID
FROM   Orders o
 JOIN
Book b
ON 
o.Book_ID = b.Book_ID 
GROUP BY o.Book_ID,b.Title
ORDER BY Order_ID  DESC
LIMIT 1;



-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT Title, Genre, Price
From Book
WHERE Genre='Fantasy'
ORDER BY Price DESC
LIMIT 3;



-- 6) Retrieve the total quantity of books sold by each author:
SELECT b.Author, SUM(o.Quantity) 
FROM
Book b
JOIN
Orders o
ON
o.BOOK_ID= b.BOOK_ID
group by b.Author;


-- 7) List the cities where customers who spent over $30 are located:

SELECT o.Customer_ID,  c.City,o.Total_Amount 
FROM   Orders o
 JOIN
Customers c
ON 
o.Customer_ID = c.Customer_ID AND o.Total_Amount> 30;


-- 8) Find the customer who spent the most on orders:
SELECT c.Customer_ID,c.Name, c.City,SUM(o.Total_Amount) AS TOTAL_SPENT
FROM   Orders o
 JOIN
Customers c
ON 
o.Customer_ID = c.Customer_ID 
GROUP BY c.Customer_ID,c.Name
ORDER BY TOTAL_SPENT DESC
LIMIT 1;



--9) Calculate the stock remaining after fulfilling all orders:

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM Book b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id;


