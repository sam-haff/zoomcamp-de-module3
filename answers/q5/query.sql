CREATE OR REPLACE TABLE `kestra-de.bq_dataset.yellow_tripdata_2024_partitioned_clustered`
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY VendorID
AS
    SELECT *
    FROM `kestra-de.bq_dataset.yellow_tripdata_2024_ext`;