#!/bin/bash
set -e

export HADOOP_HOME=/opt/hadoop
export HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

mkdir -p /opt/hadoop/logs
mkdir -p /hadoop/dfs/name /hadoop/dfs/data

cp -f /opt/bootstrap/conf/* $HADOOP_HOME/etc/hadoop/ 2>/dev/null || true
