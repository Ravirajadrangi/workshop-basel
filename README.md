# Workshop Basel

This repository contains the scripts used in the workshop Oct, 24th - Oct, 26th. The agenda of the workshop is to give an introduction into big data technologies and an exercise using Elastic Map Reduce the Big Data offering from Amazon Web Services.

Within the Hive folder you'll find scripts to create the inital table in Hive as well as scripts to convert & partition the data from GZIP into Avro or ORC format.

## Start an EMR cluster and clone the GitHub repository

Log into the AWS console and go to the EMR pane. Here create a new cluster (or clone an old existing one). The creation of a cluster takes approximately 15 minutes. Once the cluster is up and running make a notice of the public DNS name. This public DNS name is required to connect to the cluster.

## Connect to Cluster

```bash
ssh -i <keyfile >hadoop@<public dns name>
```

After successful login additional software is required to access the GitHub repository. Please install git and clone the repository using the following commands:

```bash
sudo yum install git
git clone https://github.com/altusinsight/workshop-basel.git
```

