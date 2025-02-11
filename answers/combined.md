1. What is count of records for the 2024 Yellow Taxi Data?
   
   **Answer:** 20,332,093

   Explanation:
    - You can find the rows number in the properties of the table. Alternatively, you could run COUNT(*), but that comes with a cost.
2. Write a query to count the distinct number of PULocationIDs for the entire dataset on both the tables.
What is the estimated amount of data that will be read when this query is executed on the External Table and the Table?

    **Answer:** 0 MB for the External Table and 155.12 MB 
    for the Materialized Table.

    Explanation:
    - Checked the approx. processed data in the BigQuery Studio(top right corner when cursor is at the target query).
        ~~~
        SELECT DISTINCT(VendorID)
        FROM `kestra-de.bq_dataset.yellow_tripdata_2024_ext`;

        SELECT DISTINCT(VendorID)
        FROM `kestra-de.bq_dataset.yellow_tripdata_2024`;
        ~~~
3. Write a query to retrieve the PULocationID from the table (not the external table) in BigQuery. Now write a query to retrieve the PULocationID and DOLocationID on the same table. Why are the estimated number of Bytes different?
   
    **Answer:** BigQuery is a columnar database, and  it only scans the specific columns requested in the query. Querying two columns (PULocationID,DOLocationID) requires reading more data than querying one column (PULocationID), leading to a higher estimated number of bytes processed.

    Explanation:
    - Src: 3rd course video + docs: https://cloud.google.com/bigquery/docs/storage_overview#storage_layout \
    Query:
        ~~~
        SELECT PULocationID FROM `bq_dataset.yellow_tripdata_2024`;
        ~~~
4. How many records have a fare_amount of 0?
   
   **Answer:** 8,333

    Explanation:
    - Got with the help of the following query:
        ~~~
        SELECT COUNT(*)
        FROM `kestra-de.bq_dataset.yellow_tripdata_2024`
        WHERE fare_amount=0;
        ~~~
5. What is the best strategy to make an optimized table in Big Query if your query will always filter based on tpep_dropoff_datetime and order the results by VendorID (Create a new table with this strategy)
   
   **Answer:** Partition by tpep_dropoff_datetime and Cluster on VendorID

   Explanation: 
   - If we were to partition on VendorID, it would result in 3 super big partitions. It has no sense, since it would mean, that we will always potentially process 1/3 of the whole data(and the clustering maintence will be hard, because any big insert will definetely update all partiotions ).\
   Query:
        ~~~
        CREATE OR REPLACE TABLE `kestra-de.bq_dataset.yellow_tripdata_2024_partitioned_clustered`
        PARTITION BY DATE(tpep_dropoff_datetime)
        CLUSTER BY VendorID
        AS
            SELECT *
            FROM `kestra-de.bq_dataset.yellow_tripdata_2024_ext`;
        ~~~
6. Write a query to retrieve the distinct VendorIDs between tpep_dropoff_datetime 2024-03-01 and 2024-03-15 (inclusive)
    Use the materialized table you created earlier in your from clause and note the estimated bytes. Now change the table in the from clause to the partitioned table you created for question 5 and note the estimated bytes processed. What are these values?

    **Answer:** 310.24 MB for non-partitioned table and 26.84 MB for the partitioned table

    Explanation: 
    - got using the SQL studio calc. 
    Reason behind the difference is that for partitioned table
    we scan only over partitions which date ranges overlap  the querie's one, while we scan all the records for 
    non-partiotioned(because DB has no hints where to search).\
    Queries:
        ~~~
        SELECT DISTINCT (VendorID)
        FROM `kestra-de.bq_dataset.yellow_tripdata_2024_partitioned_clustered`
        WHERE DATE(tpep_dropoff_datetime) BETWEEN '2024-03-01' AND '2024-03-15'

        SELECT DISTINCT (VendorID)
        FROM `kestra-de.bq_dataset.yellow_tripdata_2024`
        WHERE DATE(tpep_dropoff_datetime) BETWEEN '2024-03-01' AND '2024-03-15'
        ~~~
7. Where is the data stored in the External Table you created?
   **Answer:** GCP Bucket

    Explanation: 
    - Docs: external tables let you query structured data in external data stores
    In own words:
    From my current exposure to BQ, external tables look like smart parsers, integrated into the BigQuery ecosystem by smart abstraction. \
    While they imitate a regular table, they act more like a proxy object, that kinda implements a table interface (allowing usual table ops on it), 
    with all the fetching ops using external storage for the actual data (structured using provided or parsed schema).

8. It is best practice in Big Query to always cluster your data:
   **Answer:** False

    Explanation: 
    - As per https://www.youtube.com/watch?v=-CqXf7vhhDs&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb&index=28
    Partitioning or Clustering tables with small data size don't provide any query perfomance benefits while potentially resulting in more costs(for metadata reads and maintenance).

9. Write a SELECT count(*) query FROM the materialized table you created. How many bytes does it estimate will be read? Why?
    
    **Answer:** 0 bytes.

    Explanation: 
    - This info is already stored in the metadata.