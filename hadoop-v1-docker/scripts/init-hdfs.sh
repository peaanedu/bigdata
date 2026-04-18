#!/usr/bin/env bash
set -euo pipefail

export HADOOP_HOME=${HADOOP_HOME:-/opt/hadoop}
export PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH

$HADOOP_HOME/bin/hdfs dfsadmin -report
$HADOOP_HOME/bin/hdfs dfs -mkdir -p /input /output
$HADOOP_HOME/bin/hdfs dfs -put -f /data/input/sample.txt /input/
$HADOOP_HOME/bin/yarn jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar wordcount /input /output
$HADOOP_HOME/bin/hdfs dfs -cat /output/part-r-00000
