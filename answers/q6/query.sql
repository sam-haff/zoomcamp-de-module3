SELECT DISTINCT (VendorID)
FROM `kestra-de.bq_dataset.yellow_tripdata_2024_partitioned_clustered`
WHERE DATE(tpep_dropoff_datetime) BETWEEN '2024-03-01' and '2024-03-15'

SELECT DISTINCT (VendorID)
FROM `kestra-de.bq_dataset.yellow_tripdata_2024`
WHERE DATE(tpep_dropoff_datetime) BETWEEN '2024-03-01' and '2024-03-15'