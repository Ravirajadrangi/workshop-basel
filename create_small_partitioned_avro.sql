CREATE TABLE partitioned_data_small_avro (
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
STORED AS ORC
LOCATION 's3://de.altusinsight.data.baselpartitioned.small/avro';

-- populate partitioned table from raw_data table
-- INSERT OVERWRITE  TABLE partitioned_data_small  PARTITION(station_prefix) SELECT station, date, otype, ovalue, omflag, oqflag, osflag, otime, REGEXP_EXTRACT(station, '^([A-Za-z]+)(.*)', 1) FROM raw_data_small;
