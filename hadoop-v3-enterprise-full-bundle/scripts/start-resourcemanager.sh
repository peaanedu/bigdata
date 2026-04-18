#!/bin/bash
set -e
source /opt/bootstrap/scripts/common.sh

until nc -z namenode 8020; do
  echo "Waiting for namenode:8020..."
  sleep 5
done

echo "Starting ResourceManager..."
yarn --daemon start resourcemanager
tail -f /opt/hadoop/logs/*resourcemanager*.log
