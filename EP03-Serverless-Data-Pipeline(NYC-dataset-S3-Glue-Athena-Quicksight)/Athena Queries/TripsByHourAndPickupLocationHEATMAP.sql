-- Trips By Hour and Pickup Location
SELECT hour(tpep_pickup_datetime) as pickup_hour,PULocationID,
COUNT(*) AS trips
FROM taxi_db.taxi_raw
GROUP BY hour(tpep_pickup_datetime), PULocationID
ORDER BY pickup_hour;