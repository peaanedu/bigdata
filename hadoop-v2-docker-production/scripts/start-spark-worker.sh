#!/usr/bin/env bash
set -euo pipefail
source /opt/bootstrap/scripts/common.sh
copy_hadoop_conf
copy_spark_conf
wait_for_port spark-master 7077
mkdir -p /opt/spark/logs
/opt/spark/sbin/start-worker.sh spark://spark-master:7077
trap '/opt/spark/sbin/stop-worker.sh' EXIT
while true; do sleep 3600; done
