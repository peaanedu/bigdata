#!/usr/bin/env bash
set -euo pipefail
source /opt/bootstrap/scripts/common.sh
copy_hadoop_conf
wait_for_port namenode 8020
wait_for_port resourcemanager 8032
/opt/hadoop/bin/mapred --daemon start historyserver
trap '/opt/hadoop/bin/mapred --daemon stop historyserver' EXIT
while true; do sleep 3600; done
