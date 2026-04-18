#!/bin/bash
set -e
source /opt/bootstrap/scripts/common.sh

if [ ! -d "/hadoop/dfs/name/current" ]; then
  echo "Formatting NameNode..."
  hdfs namenode -format -force -nonInteractive
fi

echo "Starting NameNode..."
hdfs --daemon start namenode

for i in $(seq 1 30); do
  if jps | grep -q NameNode; then
    break
  fi
  sleep 2
done

echo "Initializing HDFS folders..."
bash /opt/bootstrap/scripts/init-hdfs.sh || true

tail -f /opt/hadoop/logs/*namenode*.log
