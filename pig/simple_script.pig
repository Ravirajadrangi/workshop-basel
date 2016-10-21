data = LOAD 'partitioned_data_small_avro' USING org.apache.hive.hcatalog.pig.HCatLoader();
single_group = GROUP data ALL;
record_count = FOREACH single_group GENERATE COUNT(data);
DUMP record_count;