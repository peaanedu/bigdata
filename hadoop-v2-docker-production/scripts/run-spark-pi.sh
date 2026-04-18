#!/usr/bin/env bash
set -euo pipefail
/opt/spark/bin/spark-submit --master spark://spark-master:7077 --class org.apache.spark.examples.SparkPi /opt/spark/examples/jars/spark-examples_2.12-*.jar 50
