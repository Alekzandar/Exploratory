CREATE TABLE product (
	product_name VARCHAR(200),
	price INTEGER
);

INSERT INTO product (product_name, price)
VALUES ('Dress', 120);



UPDATE product
SET price = 76
WHERE product_name = 'Jeans';


SELECT product_name, price
FROM product
WHERE product_name = 'Jeans';

SELECT * 
FROM product;

--Add a column to the table:
ALTER TABLE product
ADD in_stock VARCHAR(3);

INSERT INTO product (product_name, price)
	VALUES 
		('T-Shirt', 15),	
		('Sneakers', 60);

UPDATE product
SET in_stock = 'Yes'
WHERE product_name = 'Jeans'
	OR product_name = 'T-Shirt'

UPDATE product
SET in_stock = 'No'
WHERE in_stock = null;

--Change data type of existing column
ALTER TABLE product
ALTER COLUMN in_stock TYPE INTEGER
USING in_stock::integer;

UPDATE product
SET in_stock = 1
WHERE in_stock ~ '^[A-Za-z]+$';