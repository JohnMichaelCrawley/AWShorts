-- Taxi Zone Lookup Table
CREATE EXTERNAL TABLE taxi_db.taxi_zone_lookup (
  LocationID INT,
  Borough STRING,
  Zone STRING,
  service_zone STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar" = "\""
)
STORED AS TEXTFILE
LOCATION 's3://awshorts-taxi-pipeline-577385563258-eu-west-1-an/lookup/'
TBLPROPERTIES ("skip.header.line.count"="1");