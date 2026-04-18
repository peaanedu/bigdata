#!/usr/bin/env bash
set -euo pipefail

export HADOOP_HOME=${HADOOP_HOME:-/opt/hadoop}
export PATH=$HADOOP_HOME/bin:$PATH

$HADOOP_HOME/bin/hdfs dfs -rm -r -f /output/wordcount || true
$HADOOP_HOME/bin/hdfs dfs -mkdir -p /mapreduce-input
printf 'hadoop spark hive hadoop yarn mapreduce docker ubuntu hadoop cluster\n' > /tmp/words.txt
$HADOOP_HOME/bin/hdfs dfs -put -f /tmp/words.txt /mapreduce-input/words.txt
$HADOOP_HOME/bin/hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar wordcount /mapreduce-input /output/wordcount
$HADOOP_HOME/bin/hdfs dfs -cat /output/wordcount/part-r-00000
