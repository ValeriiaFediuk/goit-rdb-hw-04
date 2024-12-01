- Task 1

CREATE SCHEMA LibraryManagement;

USE LibraryManagement;

CREATE TABLE authors (
  author_id INT AUTO_INCREMENT PRIMARY KEY,
  author_name VARCHAR(255)
);

CREATE TABLE genres (
  genre_id INT AUTO_INCREMENT PRIMARY KEY,
  genre_name VARCHAR(255)
);

CREATE TABLE books (
  book_id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255),
  publication_year YEAR,
  author_id INT,
  genre_id INT,
  FOREIGN KEY (author_id) REFERENCES authors(author_id),
  FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

CREATE TABLE users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255),
  email VARCHAR(255)
);

CREATE TABLE borrowed_books (
  borrow_id INT AUTO_INCREMENT PRIMARY KEY,
  book_id INT,
  user_id INT,
  borrow_date DATE,
  return_date DATE,
  FOREIGN KEY (book_id) REFERENCES books(book_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

- Task 2

INSERT INTO authors (author_name) 
VALUES 
('Julia Quinn'),
('Agatha Christie');

INSERT INTO genres (genre_name)
VALUES 
('Detective fiction'),
('Romance novel');

INSERT INTO books (title, publication_year, author_id, genre_id)
VALUES 
('The Viscount Who Loved Me', 2000, 1, 2),
('Evil Under the Sun', 1941, 2, 1);

INSERT INTO users (username, email)
VALUES 
('Valeriia Tuz', 'valerie.tuz@example.com'),
('Sherlock', 'Sherlock@example.com');

INSERT INTO borrowed_books (book_id, user_id, borrow_date, return_date)
VALUES 
(1, 1, '2024-10-13', '2024-11-01'),
(2, 2, '2024-08-10', '2024-09-10');

- Task 3

USE mydb;

SELECT *
FROM orders o
INNER JOIN customers c ON o.customer_id = c.id
INNER JOIN employees e ON o.employee_id = e.employee_id
INNER JOIN shippers sh ON o.shipper_id = sh.id
INNER JOIN order_details od ON o.id = od.order_id 
INNER JOIN products p ON od.product_id = p.id
INNER JOIN categories ct ON p.category_id = ct.id
INNER JOIN suppliers s ON p.supplier_id = s.id;

- Task 4

4.1 

USE mydb;

SELECT count(*)
FROM orders o
INNER JOIN customers c ON o.customer_id = c.id
INNER JOIN employees e ON o.employee_id = e.employee_id
INNER JOIN shippers sh ON o.shipper_id = sh.id
INNER JOIN order_details od ON o.id = od.order_id 
INNER JOIN products p ON od.product_id = p.id
INNER JOIN categories ct ON p.category_id = ct.id
INNER JOIN suppliers s ON p.supplier_id = s.id;


4.2 

USE mydb;

SELECT count(*)
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.id
LEFT JOIN employees e ON o.employee_id = e.employee_id
LEFT JOIN shippers sh ON o.shipper_id = sh.id
RIGHT JOIN order_details od ON o.id = od.order_id 
RIGHT JOIN products p ON od.product_id = p.id
LEFT JOIN categories ct ON p.category_id = ct.id
LEFT JOIN suppliers s ON p.supplier_id = s.id;


Після зміни INNER JOIN на LEFT JOIN та RIGHT JOIN, отримуємо той самий результат - 518 рядків.
Це вказує на те, що всі записи лівої таблиці мають відповідності у правій таблиці.
Тобто у таблиці orders немає записів, для яких не існує відповідників у таблиці customers.

4.3

USE mydb;

SELECT count(*)
FROM orders o
INNER JOIN customers c ON o.customer_id = c.id
INNER JOIN employees e ON o.employee_id = e.employee_id
INNER JOIN shippers sh ON o.shipper_id = sh.id
INNER JOIN order_details od ON o.id = od.order_id 
INNER JOIN products p ON od.product_id = p.id
INNER JOIN categories ct ON p.category_id = ct.id
INNER JOIN suppliers s ON p.supplier_id = s.id;

4.4 

USE mydb;

SELECT ct.name, COUNT(*), AVG(od.quantity)
FROM orders o
INNER JOIN customers c ON o.customer_id = c.id
INNER JOIN employees e ON o.employee_id = e.employee_id
INNER JOIN shippers sh ON o.shipper_id = sh.id
INNER JOIN order_details od ON o.id = od.order_id 
INNER JOIN products p ON od.product_id = p.id
INNER JOIN categories ct ON p.category_id = ct.id
INNER JOIN suppliers s ON p.supplier_id = s.id
WHERE e.employee_id > 3 and e.employee_id <= 10
GROUP BY ct.name
;

4.5

USE mydb;

SELECT ct.name, COUNT(*), AVG(od.quantity)
FROM orders o
INNER JOIN customers c ON o.customer_id = c.id
INNER JOIN employees e ON o.employee_id = e.employee_id
INNER JOIN shippers sh ON o.shipper_id = sh.id
INNER JOIN order_details od ON o.id = od.order_id 
INNER JOIN products p ON od.product_id = p.id
INNER JOIN categories ct ON p.category_id = ct.id
INNER JOIN suppliers s ON p.supplier_id = s.id
WHERE e.employee_id > 3 and e.employee_id <= 10
GROUP BY ct.name
HAVING AVG(od.quantity) > 21
;

4.6 

USE mydb;

SELECT ct.name, COUNT(*), AVG(od.quantity)
FROM orders o
INNER JOIN customers c ON o.customer_id = c.id
INNER JOIN employees e ON o.employee_id = e.employee_id
INNER JOIN shippers sh ON o.shipper_id = sh.id
INNER JOIN order_details od ON o.id = od.order_id 
INNER JOIN products p ON od.product_id = p.id
INNER JOIN categories ct ON p.category_id = ct.id
INNER JOIN suppliers s ON p.supplier_id = s.id
WHERE e.employee_id > 3 and e.employee_id <= 10
GROUP BY ct.name
HAVING AVG(od.quantity) > 21
ORDER BY COUNT(*) DESC
;

4.7

USE mydb;

SELECT ct.name, COUNT(*), AVG(od.quantity)
FROM orders o
INNER JOIN customers c ON o.customer_id = c.id
INNER JOIN employees e ON o.employee_id = e.employee_id
INNER JOIN shippers sh ON o.shipper_id = sh.id
INNER JOIN order_details od ON o.id = od.order_id 
INNER JOIN products p ON od.product_id = p.id
INNER JOIN categories ct ON p.category_id = ct.id
INNER JOIN suppliers s ON p.supplier_id = s.id
WHERE e.employee_id > 3 and e.employee_id <= 10
GROUP BY ct.name
HAVING AVG(od.quantity) > 21
ORDER BY COUNT(*) DESC
LIMIT 4
OFFSET 1
;


