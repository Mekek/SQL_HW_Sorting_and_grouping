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
    COUNT(DISTINCT CASE WHEN category != 'Bedding' THEN category END) AS total_categ,
    ROUND(AVG(CASE WHEN category != 'Bedding' THEN rating END), 2) AS avg_rating,
    SUM(CASE WHEN category != 'Bedding' THEN revenue END) AS total_revenue,
    CASE 
        WHEN COUNT(DISTINCT CASE WHEN category != 'Bedding' THEN category END) > 1 
             AND SUM(CASE WHEN category != 'Bedding' THEN revenue END) > 50000 THEN 'rich'
        WHEN COUNT(DISTINCT CASE WHEN category != 'Bedding' THEN category END) > 1 THEN 'poor'
    END AS seller_type
FROM sellers
GROUP BY seller_id
ORDER BY seller_id;