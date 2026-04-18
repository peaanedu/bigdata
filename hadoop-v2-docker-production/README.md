# Hadoop v2 Production Edition for Docker on Ubuntu (Hadoop 3.5.0)

This package is a fuller, production-style big data lab for Ubuntu using Docker Compose and Apache Hadoop 3.5.0.

## What is included

- Hadoop 3.5.0 with HDFS + YARN + MapReduce
- 1 NameNode, 3 DataNodes
- 1 ResourceManager, 3 NodeManagers
- 1 JobHistory Server
- Spark master + 2 Spark workers
- Jupyter Notebook for PySpark testing
- Hive Metastore + HiveServer2
- PostgreSQL metastore database
- Persistent Docker volumes for data and logs
- Healthchecks and startup ordering
- Sample sales dataset and MapReduce wordcount test

## Recommended Ubuntu host

- Ubuntu 22.04 or 24.04
- Docker Engine + Docker Compose plugin
- Minimum 8 vCPU, 16 GB RAM, 80+ GB free disk
- Open these ports if you want remote browser access:
  - 9870 NameNode
  - 8088 YARN
  - 19888 JobHistory
  - 8080 Spark Master
  - 8081 / 8082 Spark Workers
  - 10000 HiveServer2
  - 8888 Jupyter

## Folder layout

```text
hadoop-v2-production/
├── .env
├── docker-compose.yml
├── conf/
├── docker/
│   ├── hadoop-base/
│   ├── hive/
│   └── jupyter/
├── hive/conf/
├── jupyter/hadoop-conf/
├── notebooks/
├── scripts/
├── spark/conf/
└── datasets/
```

## Deploy

```bash
cd hadoop-v2-production
sudo docker compose up -d --build
sudo docker compose ps
```

## Initialize HDFS

Run once after Hadoop core services are healthy:

```bash
sudo docker exec -it namenode bash /opt/bootstrap/scripts/init-hdfs.sh
```

That command creates these HDFS paths:
- `/tmp`
- `/user/hive/warehouse`
- `/spark-logs`
- `/input`

It also uploads `datasets/sales.csv` into HDFS as `/input/sales.csv`.

## Test MapReduce

```bash
sudo docker exec -it namenode bash /opt/bootstrap/scripts/run-mapreduce-wordcount.sh
```

Expected result: a small wordcount output printed to the terminal.

## Test Spark

```bash
sudo docker exec -it spark-master bash /opt/bootstrap/scripts/run-spark-pi.sh
```

## Access web UIs

Replace `YOUR_UBUNTU_IP` with your server IP.

- NameNode: `http://YOUR_UBUNTU_IP:9870`
- ResourceManager: `http://YOUR_UBUNTU_IP:8088`
- JobHistory: `http://YOUR_UBUNTU_IP:19888`
- Spark Master: `http://YOUR_UBUNTU_IP:8080`
- Spark Worker 1: `http://YOUR_UBUNTU_IP:8081`
- Spark Worker 2: `http://YOUR_UBUNTU_IP:8082`
- Jupyter: `http://YOUR_UBUNTU_IP:8888`

## Jupyter token

```text
bigdata123
```

## Hive quick check

```bash
sudo docker exec -it hiveserver2 bash
beeline -u jdbc:hive2://localhost:10000
```

Then run:

```sql
SHOW DATABASES;
CREATE DATABASE IF NOT EXISTS demo;
USE demo;
CREATE EXTERNAL TABLE IF NOT EXISTS sales (
  order_id INT,
  order_date STRING,
  region STRING,
  product STRING,
  category STRING,
  quantity INT,
  unit_price INT,
  total_amount INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/input';
```

## Production notes

- This is production-style for lab and pre-production use, not a full HA enterprise cluster.
- NameNode is single-node in this package. For true production HA, add JournalNodes, ZooKeeper, and an Active/Standby NameNode pair.
- Persistent Docker volumes are already enabled for HDFS, PostgreSQL, Hive logs, and Spark logs.
- If your host is low on RAM, reduce worker count or Spark services before starting the stack.

## Stop the stack

```bash
sudo docker compose down
```

To also remove volumes:

```bash
sudo docker compose down -v
```
