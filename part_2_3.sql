DROP TABLE IF EXISTS sellers;

CREATE TABLE IF NOT EXISTS sellers (
    seller_id INT,
    category VARCHAR(100),
    date_reg DATE,
    date DATE,
    revenue NUMERIC,
    rating INT,
    delivery_days INT
);

SET datestyle TO 'DMY';

COPY sellers (seller_id, category, date_reg, date, revenue, rating, delivery_days)
FROM 'C:\\Code\\WB\\SQL_HW_1\\sellers.csv' DELIMITER ',' CSV HEADER;

SELECT 
    seller_id,
    STRING_AGG(DISTINCT CASE WHEN category != 'Bedding' THEN category END, ' - ') AS category_pair
FROM sellers
WHERE EXTRACT(YEAR FROM date_reg) = 2022
GROUP BY seller_id
HAVING COUNT(DISTINCT CASE WHEN category != 'Bedding' THEN category END) = 2
       AND SUM(CASE WHEN category != 'Bedding' THEN revenue END) > 75000;
