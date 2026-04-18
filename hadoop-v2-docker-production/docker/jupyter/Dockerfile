ARG SPARK_VERSION=3.5.2
FROM jupyter/pyspark-notebook:latest

USER root
RUN apt-get update && apt-get install -y --no-install-recommends curl netcat-openbsd && rm -rf /var/lib/apt/lists/*
#RUN pip install --no-cache-dir pyhive thrift thrift-sasl sasl pandas pyarrow findspark
RUN pip install --no-cache-dir pyhive thrift thrift-sasl pandas pyarrow findspark
RUN mkdir -p /workspace /opt/hadoop-conf
USER ${NB_UID}
