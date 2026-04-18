#!/usr/bin/env bash
set -euo pipefail
source /opt/bootstrap/scripts/common.sh
copy_hadoop_conf
copy_spark_conf
mkdir -p /opt/spark/logs
/opt/spark/sbin/start-master.sh
trap '/opt/spark/sbin/stop-master.sh' EXIT
while true; do sleep 3600; done
