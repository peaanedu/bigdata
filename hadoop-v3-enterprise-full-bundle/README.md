# Hadoop v3 Enterprise Full Bundle

A fuller lab bundle with Hadoop, YARN, Spark, Hive, Jupyter, PostgreSQL metastore, Prometheus, and Grafana.

## Included
- Hadoop HDFS + YARN
- 1 NameNode + 3 DataNodes
- 1 ResourceManager + 3 NodeManagers
- History Server
- Spark Master + 2 Workers
- Hive Metastore + HiveServer2
- JupyterLab
- Prometheus + Grafana

## Quick start
```bash
docker compose up -d --build
docker ps
```

## Main URLs
- HDFS UI: http://localhost:9870
- YARN UI: http://localhost:8088
- Job History: http://localhost:19888
- Spark Master: http://localhost:8080
- JupyterLab: http://localhost:8888
- Prometheus: http://localhost:9090
- Grafana: http://localhost:3000

## Default credentials
- Jupyter token: `bigdata123`
- Grafana: `admin / admin123`

## Recommended first checks
```bash
docker logs namenode
docker logs resourcemanager
docker logs spark-master
docker logs hive-metastore
```

## Notes
- This is a practical lab/portfolio bundle, not a hardened production security build.
- After the first startup, HDFS bootstrap folders are created automatically by the NameNode startup script.
