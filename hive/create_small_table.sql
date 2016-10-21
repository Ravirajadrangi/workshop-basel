CREATE EXTERNAL TABLE raw_data_small (
station STRING,
date STRING,
otype STRING,
ovalue STRING,
omflag STRING,
oqflag STRING,
osflag STRING,
otime STRING
) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
LOCATION 's3://de.altusinsight.data.basel.small/';
