-- Join Tables
SELECT t.trip_distance,
t.total_amount,
z.Zone,
z.Borough
FROM taxi_db.taxi_raw t
JOIN taxi_db.taxi_zone_lookup z
ON t.pulocationid = z.locationID
LIMIT 20;