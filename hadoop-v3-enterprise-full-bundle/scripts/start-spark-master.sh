#!/bin/bash
set -e
export SPARK_HOME=/opt/spark
export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
mkdir -p /opt/spark/logs

cp -f /opt/bootstrap/spark-conf/* $SPARK_HOME/conf/ 2>/dev/null || true

echo "Starting Spark Master..."
$SPARK_HOME/sbin/start-master.sh
tail -f /opt/spark/logs/*master*.out
