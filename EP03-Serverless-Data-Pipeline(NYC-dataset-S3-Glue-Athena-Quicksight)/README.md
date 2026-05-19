# EP03 Serverless Data Pipeline (NYC dataset, S3, Glue, Athena, QuickSight)

## Overview
For this episode, I want to work with a dataset, pipeline and be serverless, resulting in this episode of getting real-world dataset for NYC taxi-trips (or public transport in NYC). Using S3 to store the dataset, once uploaded, Lambda will fully trigger a pipeline, the data will be sent to Glue first to automatically detect the schema and I'll use Athena where I can do queries in the data and finally it will go to QuickSight to visualise the data.

## Dataset
NYC Taxi & Limousine Commission Trip Data:
https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page

The dataset contains real taxi trip records including:

- pickup and dropoff locations
- trip distance
- timestamps
- fare amounts
- payment types

## Architecture
```
Dataset → S3 → Lambda → Glue → Athena → Quicksight
```

## Stack
- AWS S3
- AWS Glue
- AWS Athena
- AWS Lambda
- AWS QuickSight

