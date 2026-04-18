ARG HADOOP_VERSION=3.3.6
ARG SPARK_VERSION=3.5.1
ARG APACHE_MIRROR=https://archive.apache.org/dist
FROM openjdk:8-jdk

ARG HADOOP_VERSION
ARG SPARK_VERSION
ARG APACHE_MIRROR

ENV HADOOP_HOME=/opt/hadoop
ENV SPARK_HOME=/opt/spark
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$SPARK_HOME/bin:$SPARK_HOME/sbin

RUN apt-get update && apt-get install -y curl procps net-tools netcat-traditional python3 && rm -rf /var/lib/apt/lists/*
RUN curl -fsSL ${APACHE_MIRROR}/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz     | tar -xz -C /opt  && mv /opt/hadoop-${HADOOP_VERSION} ${HADOOP_HOME}
RUN curl -fsSL ${APACHE_MIRROR}/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.tgz     | tar -xz -C /opt  && mv /opt/spark-${SPARK_VERSION}-bin-hadoop3 ${SPARK_HOME}

RUN mkdir -p /opt/bootstrap/scripts /opt/bootstrap/spark-conf /opt/spark/logs
WORKDIR /opt/bootstrap
