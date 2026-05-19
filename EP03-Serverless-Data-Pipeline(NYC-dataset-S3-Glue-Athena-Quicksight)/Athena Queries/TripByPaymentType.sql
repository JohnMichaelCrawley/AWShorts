-- Trips By Payment Type
SELECT payment_type,
COUNT(*) AS trips
FROM taxi_db.taxi_raw
GROUP BY payment_type
ORDER BY trips DESC;