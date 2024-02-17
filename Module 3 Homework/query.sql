CREATE    OR REPLACE EXTERNAL TABLE `green_taxi_data.external_green_tripdata` OPTIONS(
          format = "PARQUE",
          uris = [
          "gs://semiotic-vial-413817-my-bucket/green_tripdata_2022-01.parquet",
          "gs://semiotic-vial-413817-my-bucket/green_tripdata_2022-02.parquet",
          "gs://semiotic-vial-413817-my-bucket/green_tripdata_2022-03.parquet",
          "gs://semiotic-vial-413817-my-bucket/green_tripdata_2022-04.parquet",
          "gs://semiotic-vial-413817-my-bucket/green_tripdata_2022-05.parquet",
          "gs://semiotic-vial-413817-my-bucket/green_tripdata_2022-06.parquet",
          "gs://semiotic-vial-413817-my-bucket/green_tripdata_2022-07.parquet",
          "gs://semiotic-vial-413817-my-bucket/green_tripdata_2022-08.parquet",
          "gs://semiotic-vial-413817-my-bucket/green_tripdata_2022-09.parquet",
          "gs://semiotic-vial-413817-my-bucket/green_tripdata_2022-10.parquet",
          "gs://semiotic-vial-413817-my-bucket/green_tripdata_2022-11.parquet",
          "gs://semiotic-vial-413817-my-bucket/green_tripdata_2022-12.parquet"
          ]
          );


SELECT COUNT(*)
from green_taxi_data.external_green_tripdata;


CREATE OR REPLACE TABLE green_taxi_data.green_tripdata_non_partitioned AS
SELECT *
FROM green_taxi_data.external_green_tripdata;


SELECT COUNT(DISTINCT (PULocationID))
from green_taxi_data.green_tripdata_non_partitioned;


SELECT COUNT(DISTINCT (PULocationID))
from green_taxi_data.external_green_tripdata;


SELECT COUNT(*)
FROM green_taxi_data.green_tripdata_non_partitioned
WHERE fare_amount = 0;


CREATE OR REPLACE TABLE green_taxi_data.green_tripdata_partitoned_clustered
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY VendorID AS
SELECT *
FROM green_taxi_data.external_green_tripdata;


SELECT COUNT(*) as trips
FROM green_taxi_data.green_tripdata_non_partitioned
WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30'
AND VendorID=1;