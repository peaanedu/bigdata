#!/usr/bin/env bash
set -euo pipefail
source /opt/bootstrap/scripts/common.sh
copy_hadoop_conf
if [ ! -f /hadoop/dfs/name/current/VERSION ]; then
  /opt/hadoop/bin/hdfs namenode -format -force -nonInteractive
fi
/opt/hadoop/bin/hdfs namenode
