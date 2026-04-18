#!/usr/bin/env bash
set -euo pipefail

export HADOOP_HOME=${HADOOP_HOME:-/opt/hadoop}
export HADOOP_CONF_DIR=${HADOOP_CONF_DIR:-$HADOOP_HOME/etc/hadoop}
export PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH

service_name=${SERVICE_NAME:-shell}

wait_for_host() {
  local host="$1"
  local port="$2"
  until bash -c "</dev/tcp/${host}/${port}" >/dev/null 2>&1; do
    sleep 2
  done
}

case "$service_name" in
  namenode)
    if [ ! -f /hadoop/dfs/name/current/VERSION ]; then
      $HADOOP_HOME/bin/hdfs namenode -format -force -nonInteractive "$CLUSTER_NAME"
    fi
    exec $HADOOP_HOME/bin/hdfs namenode
    ;;
  datanode)
    wait_for_host namenode 9000
    exec $HADOOP_HOME/bin/hdfs datanode
    ;;
  resourcemanager)
    wait_for_host namenode 9000
    exec $HADOOP_HOME/bin/yarn resourcemanager
    ;;
  nodemanager)
    wait_for_host resourcemanager 8032
    exec $HADOOP_HOME/bin/yarn nodemanager
    ;;
  historyserver)
    wait_for_host namenode 9000
    $HADOOP_HOME/bin/hdfs dfs -mkdir -p /mr-history/tmp /mr-history/done || true
    $HADOOP_HOME/bin/hdfs dfs -chmod -R 1777 /mr-history/tmp || true
    $HADOOP_HOME/bin/hdfs dfs -chmod -R 1777 /mr-history/done || true
    exec $HADOOP_HOME/bin/mapred historyserver
    ;;
  shell)
    exec /bin/bash
    ;;
  *)
    exec "$@"
    ;;
esac
