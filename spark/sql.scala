sqlContext.sql("select count(*) from partitioned_data_small_avro").show()
sqlContext.sql("select count(*) from partitioned_data_small_orc").show()


val orc = sqlContext.read.format("orc").load("s3://de.altusinsight.data.baselpartitioned.small/orc")

val orc = sqlContext.read.format("text").load("s3://de.altusinsight.data.basel/")
orc.registerTempTable(orc)

val data = sc.textFile("s3://de.altusinsight.data.basel/*")

System.exit(0)