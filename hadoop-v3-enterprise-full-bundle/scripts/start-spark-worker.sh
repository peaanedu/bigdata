#!/bin/bash
set -e
export SPARK_HOME=/opt/spark
export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
mkdir -p /opt/spark/logs

cp -f /opt/bootstrap/spark-conf/* $SPARK_HOME/conf/ 2>/dev/null || true

until nc -z spark-master 7077; do
  echo "Waiting for spark-master:7077..."
  sleep 5
done

echo "Starting Spark Worker..."
$SPARK_HOME/sbin/start-worker.sh ${SPARK_MASTER_URL}
tail -f /opt/spark/logs/*worker*.out
