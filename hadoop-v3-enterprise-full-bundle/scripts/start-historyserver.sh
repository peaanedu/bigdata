#!/bin/bash
set -e
source /opt/bootstrap/scripts/common.sh

until nc -z resourcemanager 8032; do
  echo "Waiting for resourcemanager:8032..."
  sleep 5
done

echo "Starting JobHistory Server..."
mapred --daemon start historyserver
tail -f /opt/hadoop/logs/*historyserver*.log
