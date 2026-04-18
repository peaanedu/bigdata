#!/bin/bash
set -e
source /opt/bootstrap/scripts/common.sh

hdfs dfs -mkdir -p /tmp || true
hdfs dfs -chmod 1777 /tmp || true
hdfs dfs -mkdir -p /spark-logs || true
hdfs dfs -chmod 1777 /spark-logs || true
hdfs dfs -mkdir -p /user/hive/warehouse || true
hdfs dfs -chmod 777 /user/hive/warehouse || true
