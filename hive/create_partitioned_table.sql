SET parquet.compression=SNAPPY;
CREATE TABLE partitioned_data (
station STRING,
date STRING,
otype STRING,
ovalue STRING,
omflag STRING,
oqflag STRING,
osflag STRING,
otime STRING
)
PARTITIONED BY (
station_prefix STRING
)
STORED AS PARQUET
LOCATION 's3://de.altusinsight.data.baselpartitioned/';

-- populate partitioned table from raw_data table
INSERT OVERWRITE  TABLE partitioned_data PARTITION(station_prefix) SELECT station, date, otype, ovalue, omflag, oqflag, osflag, otime, REGEXP_EXTRACT('USW00024031', '^([A-Za-z]+)(.*)', 1) FROM raw_data;
