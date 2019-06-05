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
