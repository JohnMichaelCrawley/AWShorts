--Busiest Pickup Locations
SELECT PULocationID, COUNT(*) AS trips
FROM taxi_db.taxi_raw
GROUP BY PULocationID
ORDER BY trips DESC
LIMIT 10;