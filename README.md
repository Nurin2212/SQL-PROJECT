# SQL-PROJECT
Project on Online Bookstore, using SQL 

In this project we will be practicing inserting and querying data using SQL.


 Table - Book
Instructions
Create a table called Book that records a Book's id, Title ,Author ,Genre , Published_Year ,Price NUMERIC,Stock 
id should be an auto-incrementing id/primary key - Use type: SERIAL
Add data from csvfile of 500 datavalues into the Book table.



Table - Customers
Instructions
Create a table called Customers that records a Customers's id, Name VARCHAR(100), Email , Phone ,City ,Country 
 id should be an auto-incrementing id/primary key - Use type: SERIAL
Add data from csvfile of 500 datavalues into the Customers table.


Table - Orders
Instructions
Create a table called Orders that records a Orders's id,Customer_ID INT REFERENCES Customers(Customer_ID),Book_ID  REFERENCES Books(Book_ID),Order_Date ,Quantity ,Total_Amount
 id should be an auto-incrementing id/primary key - Use type: SERIAL
Add data from csvfile of 500 datavalues into the Orders table.
and here the two column of Orders connected two different table with common column i.e; Book's id from Book table and  Customers's id from Customer table.

