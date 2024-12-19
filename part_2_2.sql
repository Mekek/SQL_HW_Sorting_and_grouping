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

WITH poor_sellers AS (
    SELECT 
        seller_id,
        COUNT(DISTINCT CASE WHEN category != 'Bedding' THEN category END) AS total_categ,
        SUM(CASE WHEN category != 'Bedding' THEN revenue END) AS total_revenue,
        MIN(delivery_days) AS min_delivery_days,
        MAX(delivery_days) AS max_delivery_days,
        FLOOR((EXTRACT(EPOCH FROM now() - MIN(date_reg)) / 2592000)) AS month_from_registration
    FROM sellers
    GROUP BY seller_id
    HAVING COUNT(DISTINCT CASE WHEN category != 'Bedding' THEN category END) > 1
           AND SUM(CASE WHEN category != 'Bedding' THEN revenue END) <= 50000
)
SELECT 
    seller_id,
    month_from_registration,
    (SELECT MAX(max_delivery_days - min_delivery_days) FROM poor_sellers) AS max_delivery_difference
FROM poor_sellers
ORDER BY seller_id;
