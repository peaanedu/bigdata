#!/usr/bin/env bash
set -euo pipefail

export HADOOP_HOME=/opt/hadoop
export HIVE_HOME=/opt/hive
export PATH=$HIVE_HOME/bin:$HADOOP_HOME/bin:$PATH

until nc -z postgres 5432; do echo 'Waiting for postgres...'; sleep 3; done
until nc -z namenode 8020; do echo 'Waiting for namenode...'; sleep 3; done

if [ ! -f /opt/hive/.schema_initialized ]; then
  /opt/hive/bin/schematool -dbType postgres -initSchema || /opt/hive/bin/schematool -dbType postgres -info
  touch /opt/hive/.schema_initialized
fi

if [ "${SERVICE_NAME}" = "metastore" ]; then
  /opt/hive/bin/hive --service metastore
else
  until nc -z hive-metastore 9083; do echo 'Waiting for hive-metastore...'; sleep 3; done
  /opt/hive/bin/hiveserver2
fi
