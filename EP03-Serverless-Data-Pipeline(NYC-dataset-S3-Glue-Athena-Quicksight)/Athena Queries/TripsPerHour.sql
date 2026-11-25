-- Trips per hour
SELECT hour(tpep_pickup_datetime) as pickup_hour,
COUNT(*) AS trips
FROM taxi_db.taxi_raw
GROUP BY hour(tpep_pickup_datetime)
ORDER BY trips DESC;