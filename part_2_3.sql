CREATE TABLE sellers (
    seller_id INT PRIMARY KEY,
    category VARCHAR(100),
    date_reg DATE,
    date DATE,
    revenue NUMERIC,
    rating INT,
    delivery_days INT
);

\COPY sellers FROM 'path/to/sellers.csv' DELIMITER ',' CSV HEADER;

SELECT 
    seller_id,
    GROUP_CONCAT(DISTINCT CASE WHEN category != 'Bedding' THEN category END, ' - ') AS category_pair
FROM sellers
WHERE strftime('%Y', date_reg) = '2022'
GROUP BY seller_id
HAVING COUNT(DISTINCT CASE WHEN category != 'Bedding' THEN category END) = 2
       AND SUM(CASE WHEN category != 'Bedding' THEN revenue END) > 75000;
