#!/usr/bin/env bash
set -euo pipefail
source /opt/bootstrap/scripts/common.sh
copy_hadoop_conf
wait_for_port namenode 8020
/opt/hadoop/bin/yarn resourcemanager
