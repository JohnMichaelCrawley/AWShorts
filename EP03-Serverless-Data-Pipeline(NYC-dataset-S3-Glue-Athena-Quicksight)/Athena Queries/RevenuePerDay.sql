-- Daily Taxi Revenue
SELECT date(tpep_pickup_datetime) as trip_date,
SUM(total_amount) as revenue
FROM taxi_db.taxi_raw
GROUP BY date(tpep_pickup_datetime)
ORDER BY trip_date;