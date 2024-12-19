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


ALTER TABLE sellers ADD COLUMN unique_seller_id SERIAL PRIMARY KEY;


SELECT 
    seller_id,
    COUNT(DISTINCT CASE WHEN category != 'Bedding' THEN category END) AS total_categ,
    ROUND(AVG(CASE WHEN category != 'Bedding' THEN rating END), 2) AS avg_rating,
    SUM(CASE WHEN category != 'Bedding' THEN revenue END) AS total_revenue,
    CASE 
        WHEN COUNT(DISTINCT CASE WHEN category != 'Bedding' THEN category END) > 1 
             AND SUM(CASE WHEN category != 'Bedding' THEN revenue END) > 50000 THEN 'rich'
        WHEN COUNT(DISTINCT CASE WHEN category != 'Bedding' THEN category END) > 1 
             AND SUM(CASE WHEN category != 'Bedding' THEN revenue END) <= 50000 THEN 'poor'
    END AS seller_type
FROM sellers
GROUP BY seller_id
HAVING 
    COUNT(DISTINCT CASE WHEN category != 'Bedding' THEN category END) > 1  -- Продавец продает более одной категории
    AND (SUM(CASE WHEN category != 'Bedding' THEN revenue END) > 50000 OR SUM(CASE WHEN category != 'Bedding' THEN revenue END) <= 50000)  -- Выручка больше или меньше 50 000
ORDER BY seller_id;
