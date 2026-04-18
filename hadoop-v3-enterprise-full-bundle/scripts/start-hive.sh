#!/bin/bash
set -e
source /opt/bootstrap/scripts/common.sh

export HIVE_HOME=/opt/hive
export PATH=$PATH:$HIVE_HOME/bin

until nc -z postgres 5432; do
  echo "Waiting for postgres:5432..."
  sleep 5
done

case "${SERVICE_NAME}" in
  metastore)
    echo "Starting Hive Metastore..."
    schematool -dbType postgres -initSchema || true
    hive --service metastore
    ;;
  hiveserver2)
    until nc -z hive-metastore 9083; do
      echo "Waiting for hive-metastore:9083..."
      sleep 5
    done
    echo "Starting HiveServer2..."
    hiveserver2
    ;;
  *)
    echo "Unknown SERVICE_NAME=${SERVICE_NAME}"
    exit 1
    ;;
esac
