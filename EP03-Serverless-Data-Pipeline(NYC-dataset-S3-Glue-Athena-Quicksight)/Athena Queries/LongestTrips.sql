-- Longest Trips 
SELECT trip_distance,fare_amount
FROM taxi_db.taxi_raw
ORDER BY trip_distance DESC
LIMIT 10;