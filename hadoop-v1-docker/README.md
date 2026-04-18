# Hadoop v1 Docker Cluster for Ubuntu

This project creates a multi-container Hadoop cluster with:
- 1 NameNode
- 3 DataNodes
- 1 ResourceManager
- 3 NodeManagers
- 1 JobHistory Server
- HDFS + YARN + MapReduce example

## Prerequisites
- Ubuntu 22.04 or later
- Docker Engine
- Docker Compose plugin
- At least 8 GB RAM and 4 CPU recommended

## Start
```bash
cd hadoop-v1-docker
sudo docker compose up -d --build
```

## Check containers
```bash
sudo docker compose ps
```

## Open web UI
- NameNode: http://YOUR_UBUNTU_IP:9870
- ResourceManager: http://YOUR_UBUNTU_IP:8088
- HistoryServer: http://YOUR_UBUNTU_IP:19888

## Run sample MapReduce wordcount
```bash
sudo docker exec -it namenode bash
/init-hdfs.sh
```

## Useful commands
```bash
sudo docker exec -it namenode hdfs dfs -ls /
sudo docker exec -it namenode hdfs dfsadmin -report
sudo docker exec -it resourcemanager yarn node -list
sudo docker compose logs -f namenode
```

## Stop
```bash
sudo docker compose down
```

## Reset all cluster data
```bash
sudo docker compose down -v
```
