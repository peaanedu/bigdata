#!/usr/bin/env bash
set -euo pipefail

copy_hadoop_conf() {
  cp /opt/bootstrap/conf/core-site.xml /opt/hadoop/etc/hadoop/core-site.xml
  cp /opt/bootstrap/conf/hdfs-site.xml /opt/hadoop/etc/hadoop/hdfs-site.xml
  cp /opt/bootstrap/conf/yarn-site.xml /opt/hadoop/etc/hadoop/yarn-site.xml
  cp /opt/bootstrap/conf/mapred-site.xml /opt/hadoop/etc/hadoop/mapred-site.xml
  cp /opt/bootstrap/conf/workers /opt/hadoop/etc/hadoop/workers
}

copy_spark_conf() {
  mkdir -p /opt/spark/conf
  cp /opt/bootstrap/spark-conf/spark-defaults.conf /opt/spark/conf/spark-defaults.conf
  cp /opt/bootstrap/spark-conf/spark-env.sh /opt/spark/conf/spark-env.sh
  chmod +x /opt/spark/conf/spark-env.sh
}

wait_for_port() {
  local host="$1"
  local port="$2"
  until nc -z "$host" "$port"; do
    echo "Waiting for ${host}:${port} ..."
    sleep 3
  done
}
