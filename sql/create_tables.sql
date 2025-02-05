CREATE OR REPLACE EXTERNAL TABLE `kestra-de.bq_dataset.yellow_tripdata_2024_ext`
OPTIONS (
  uris=["gs://kestra-de-main-bucket/*.parquet"],
  format='parquet'
);

CREATE OR REPLACE TABLE `kestra-de.bq_dataset.yellow_tripdata_2024`
AS
    SELECT *
    FROM `kestra-de.bq_dataset.yellow_tripdata_2024_ext`;

CREATE OR REPLACE TABLE `kestra-de.bq_dataset.yellow_tripdata_2024_partitioned_clustered`
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY VendorID
AS
    SELECT *
    FROM `kestra-de.bq_dataset.yellow_tripdata_2024_ext`;