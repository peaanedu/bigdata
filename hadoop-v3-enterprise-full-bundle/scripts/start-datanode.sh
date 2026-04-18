#!/bin/bash
set -e
source /opt/bootstrap/scripts/common.sh

until nc -z namenode 8020; do
  echo "Waiting for namenode:8020..."
  sleep 5
done

echo "Starting DataNode..."
hdfs --daemon start datanode
tail -f /opt/hadoop/logs/*datanode*.log
