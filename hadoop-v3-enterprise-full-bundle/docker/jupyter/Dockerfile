ARG SPARK_VERSION=3.5.1
FROM jupyter/pyspark-notebook:spark-3.5.0

USER root
RUN apt-get update && apt-get install -y curl procps net-tools && rm -rf /var/lib/apt/lists/*
USER jovyan

WORKDIR /workspace
