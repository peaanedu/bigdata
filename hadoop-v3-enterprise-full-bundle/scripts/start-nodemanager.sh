#!/bin/bash
set -e
source /opt/bootstrap/scripts/common.sh

until nc -z resourcemanager 8032; do
  echo "Waiting for resourcemanager:8032..."
  sleep 5
done

echo "Starting NodeManager..."
yarn --daemon start nodemanager
tail -f /opt/hadoop/logs/*nodemanager*.log
