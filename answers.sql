-- Practice joins

-- SELECT [Column names] 
-- FROM [table] [abbv]
-- JOIN [table2] [abbv2] ON abbv.prop = abbv2.prop WHERE [Conditions];

-- SELECT a.name, b.name FROM some_table a JOIN another_table b ON a.some_id = b.some_id;
-- SELECT a.name, b.name FROM some_table a JOIN another_table b ON a.some_id = b.some_id WHERE b.email = 'e@mail.com';

1) SELECT * FROM invoice AS i
INNER JOIN invoice_line AS il
ON il.invoice_id = i.invoice_id
WHERE il.unit_price > 0.99; 

2) SELECT i.invoice_date, c.first_name, c.last_name, i.total FROM invoice AS i
INNER JOIN customer AS c
ON c.customer_id = i.customer_id

3) SELECT c.first_name, c.last_name, e.first_name, e.last_name FROM customer AS c
INNER JOIN employee AS e
ON c.support_rep_id = e.employee_id

4) SELECT ar.name, al.title FROM album AS al
INNER JOIN artist AS ar
ON ar.artist_id = al.artist_id

5) SELECT track_id FROM playlist_track
WHERE playlist_id IN (
  SELECT playlist_id FROM playlist
  WHERE name = 'Music'
)

6) SELECT t.name FROM track AS t
INNER JOIN playlist_track AS p
ON p.track_id = t.track_id
WHERE p.playlist_id =5

7) SELECT t.name, pl.name FROM track AS t
INNER JOIN playlist_track AS p
ON p.track_id = t.track_id
INNER JOIN playlist AS pl
ON pl.playlist_id = p.playlist_id

8) SELECT t.name, al.title FROM track AS t
INNER JOIN album AS al
ON al.album_id = t.album_id
INNER JOIN genre AS g
ON t.genre_id = g.genre_id
WHERE g.name ILIKE 'Alternative & Punk'

BD: Get all tracks on the playlist(s) called Music and show their name, genre name, album name, and artist name.
At least 5 joins.



-- Practice nested queries
-- SELECT [column names] 
-- FROM [table] 
-- WHERE column_id IN ( SELECT column_id FROM [table2] WHERE [Condition] );

-- SELECT name, Email FROM Athlete WHERE AthleteId IN ( SELECT PersonId FROM PieEaters WHERE Flavor='Apple' );

1) SELECT * FROM invoice
WHERE invoice_id IN (
  SELECT invoice_id FROM invoice_line
	WHERE unit_price > 0.99
) 

2) SELECT playlist_track_id FROM playlist_track
WHERE playlist_id IN (
  SELECT playlist_id FROM playlist
	WHERE name ILIKE 'MUSIC'
)
-- OR --
SELECT name FROM track
WHERE track_id IN (
  SELECT playlist_track_id FROM playlist_track
  WHERE playlist_id IN (
    SELECT playlist_id FROM playlist
    WHERE name ILIKE 'MUSIC'
	)
)

3) SELECT name FROM track
WHERE track_id IN (
  SELECT track_id FROM playlist_track
	WHERE playlist_id = 5
)

4) SELECT * FROM track
WHERE genre_id IN (
  SELECT genre_id FROM genre
	WHERE name ILIKE 'COMEDY'
)

5) SELECT * FROM track
WHERE album_id IN (
  SELECT album_id FROM album
	WHERE name ILIKE 'FIREBALL'
)

6) SELECT * FROM track
WHERE album_id IN (
  SELECT album_id FROM album
	WHERE artist_id IN (
    SELECT artist_id FROM artist
    WHERE name ILIKE 'QUEEN'
  )
)



-- PRACTICE UPDATING ROWS
-- UPDATE [table] 
-- SET [column1] = [value1], [column2] = [value2] 
-- WHERE [Condition];

-- UPDATE athletes SET sport = 'Picklball' WHERE sport = 'pockleball';

1) UPDATE customer SET fax = NULL
WHERE fax IS NOT NULL

2) UPDATE customer SET company = 'Self'
WHERE company IS NULL;

3) UPDATE customer SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett';

4) UPDATE customer SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

5) UPDATE track SET composer = 'The darkness around us'
WHERE genre_id = (
  SELECT genre_id FROM genre
  WHERE name = 'Metal'
  ) AND composer IS NULL;

6) Refresh your page to remove all database changes.



-- GROUP BY --
-- SELECT [column1], [column2]
-- FROM [table] [abbr]
-- GROUP BY [column];

1) SELECT COUNT(*) FROM track AS t
INNER JOIN genre AS g
ON t.genre_id = g.genre_id
GROUP BY g.name

2) SELECT COUNT(*) FROM track AS t
INNER JOIN genre AS g
ON t.genre_id = g.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY g.name

3) SELECT COUNT(*) FROM artist AS ar
INNER JOIN album AS al
ON ar.artist_id = al.artist_id
GROUP BY ar.name



-- USE DISTINCT --
-- SELECT DISTINCT [column]
-- FROM [table];

1) SELECT DISTINCT composer FROM track

2) SELECT DISTINCT billing_postal_code FROM invoice

3) SELECT DISTINCT company FROM customer



-- DELETE ROWS --
-- DELETE FROM [table] WHERE [condition]

1) Copy, paste, and run the SQL code from the summary.

2) DELETE FROM practice_delete
WHERE type = 'bronze';

3) DELETE FROM practice_delete
WHERE type = 'silver';

4) DELETE FROM practice_delete
WHERE value = 150;



-- eCommerce Simulation --
-- Let's simulate an e-commerce site. We're going to need users, products, and orders.

-- users need a name and an email.
-- products need a name and a price
-- orders need a ref to product.
-- All 3 need primary keys.
-- Instructions

-- Create 3 tables following the criteria in the summary.
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(200)
);
CREATE TABLE product (
  product_id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  price INT
);
CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  product_id INT,
  FOREIGN KEY(product_id) REFERENCES product(product_id)
)

-- Add some data to fill up each table.
-- At least 3 users, 3 products, 3 orders.
INSERT INTO users (name, email)
VALUES ('Kevin', 'kevin@donglemonger.com'),
('Rachel', 'dongle4you@bendover.love'),
('David', 'totallyInnocent@didntdoit.net');
INSERT INTO product (name, price)
VALUES ('Large Dungle', 9.89),
('Medium Dongle', 8.98),
('Small Dongle', 5.55);
INSERT INTO orders (product_id)
VALUES (1),(1),(3)

-- Run queries against your data.
-- Get all products for the first order.
SELECT * FROM orders
WHERE order_id = 1

-- Get all orders.
SELECT * FROM orders

-- Get the total cost of an order ( sum the price of all products on an order ).
SELECT SUM(o.quantity * p.price) FROM orders AS o
INNER JOIN product AS p
ON o.product_id = p.product_id
WHERE order_id = 1

-- Add a foreign key reference from orders to users.
ALTER TABLE users
ADD COLUMN order_id INTEGER REFERENCES orders(order_id);
SELECT * FROM users

-- Update the orders table to link a user to each order.
UPDATE users 
SET order_id = user_id;
SELECT * FROM users

-- Run queries against your data.
-- Get all orders for a user.
SELECT * FROM users
WHERE order_id = 1

-- Get how many orders each user has.
SELECT COUNT(*) FROM users
WHERE order_id = 1

-- Black Diamond
-- Get the total amount on all orders for each user.