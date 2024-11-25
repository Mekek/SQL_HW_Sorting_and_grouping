CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    gender VARCHAR(10),
    age INTEGER,
    education VARCHAR(50),
    city VARCHAR(50)
);

\COPY users FROM 'path/to/users.csv' DELIMITER ',' CSV HEADER;


SELECT 
    city,
    CASE 
        WHEN age BETWEEN 0 AND 20 THEN 'young'
        WHEN age BETWEEN 21 AND 49 THEN 'adult'
        ELSE 'old'
    END AS age_category,
    COUNT(*) AS buyer_count
FROM users
GROUP BY city, age_category
ORDER BY city, buyer_count DESC;

SELECT * FROM users