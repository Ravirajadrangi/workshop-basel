# Workshop Basel

This repository contains the scripts used in the workshop Oct, 24th - Oct, 26th. The agenda of the workshop is to give an introduction into big data technologies and perform an exercise using Elastic Map Reduce (EMR) the Big Data offering from Amazon Web Services (AWS).

Within the Hive folder you'll find scripts to create the inital table in Hive as well as scripts to convert & partition the data from GZIP into Avro or ORC format.

## Start an EMR cluster and clone the GitHub repository

Log into the AWS console and go to the EMR pane. Here create a new cluster (or clone an old existing one). The creation of a cluster takes approximately 15 minutes. Once the cluster is up and running make a notice of the public DNS name. This public DNS name is required to connect to the cluster.

### Connect to Cluster

```bash
ssh -i <keyfile> hadoop@<public dns name>
```

After successful login additional software is required to access the GitHub repository. Please install git and clone the repository using the following commands:

### Clone repository
```bash
sudo yum install git
git clone https://github.com/altusinsight/workshop-basel.git
```

## Create Hive tables
Now you're able to run the Hive scripts and create the initial table but before move the hiverc file into place (Hive uses the hiverc file to initialize its environment):

```
cp workshop-basel/hive/hiverc $HOME/.hiverc
hive -v -f workshop-basel/hive/create_small_table.sql
```

The data in the table ```raw_data``` are in ascii files. Hadoop uses the TextInputFormat to read and parse the data which is usually in CSV format. While this format has the advantage of being easily readable it's not the most efficient way to store and process data. There are other file formats which store the data more efficiently and allow Hadoop to process the data more efficiently. Two common formats are the AvroFileFormat and the ORCFileFormat. The next section shows how data can be converted (and partitioned) from one format into another by using Hive.

### Repartition data and convert into AvroFileFormat

First the new table needs to be created. Please run the following command to create the new table containing the data as Avro files. (Make sure the bucket exists in S3):

```
hive -v -f workshop-basel/hive/create_small_partitioned_avro.sql
```
Now that the table has been created the insert statement can be started to reads the data from the table raw_data_small and writes the data in the table partitioned_data_small_avro. While the data is converted it's also partitioned by using a station predix (first 2 or 3 letters from the station name). Log into the Hive shell:
```
$ hive
hive> INSERT OVERWRITE TABLE partitioned_data_small_avro  PARTITION(station_prefix) SELECT station, date, otype, ovalue, omflag, oqflag, osflag, otime, REGEXP_EXTRACT(station, '^([A-Za-z]+)(.*)', 1) FROM raw_data_small;
```

This command takes a few minutes to complete. When it's done please check the S3 bucket to see how the data is parititoned. The same exercise can be done converting and repartition the data into ORCFileFormat:

### Repartition data and convert into ORCFileFormat

First create the table:
```
hive -v -f workshop-basel/hive/create_small_partitioned_orc.sql
```

Now enter the Hive shell and run the insert statement:

```
$ hive
hive> INSERT OVERWRITE TABLE partitioned_data_small_orc  PARTITION(station_prefix) SELECT station, date, otype, ovalue, omflag, oqflag, osflag, otime, REGEXP_EXTRACT(station, '^([A-Za-z]+)(.*)', 1) FROM raw_data_small;
```

