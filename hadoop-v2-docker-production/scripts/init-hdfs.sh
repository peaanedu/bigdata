#!/usr/bin/env bash
set -euo pipefail

export HADOOP_HOME=${HADOOP_HOME:-/opt/hadoop}
export PATH=$HADOOP_HOME/bin:$PATH

$HADOOP_HOME/bin/hdfs dfsadmin -safemode wait || true
$HADOOP_HOME/bin/hdfs dfs -mkdir -p /tmp /user/hive/warehouse /spark-logs /input
$HADOOP_HOME/bin/hdfs dfs -chmod 1777 /tmp
$HADOOP_HOME/bin/hdfs dfs -chmod 777 /user/hive/warehouse /spark-logs /input
$HADOOP_HOME/bin/hdfs dfs -put -f /datasets/sales.csv /input/sales.csv

echo "HDFS initialized."
