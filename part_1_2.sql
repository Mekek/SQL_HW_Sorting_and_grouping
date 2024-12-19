DROP TABLE IF EXISTS products;

CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price NUMERIC
);

COPY products FROM 'C:\\Code\\WB\\SQL_HW_1\\products.csv' DELIMITER ',' CSV HEADER;

SELECT 
    category,
    ROUND(AVG(price), 2) AS avg_price
FROM products
WHERE name ILIKE '%hair%' OR name ILIKE '%home%'
GROUP BY category;
