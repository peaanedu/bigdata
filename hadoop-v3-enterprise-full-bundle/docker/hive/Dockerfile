ARG HIVE_VERSION=3.1.3
ARG HADOOP_VERSION=3.3.6
ARG APACHE_MIRROR=https://archive.apache.org/dist
FROM openjdk:8-jdk

ARG HIVE_VERSION
ARG HADOOP_VERSION
ARG APACHE_MIRROR

ENV HADOOP_HOME=/opt/hadoop
ENV HIVE_HOME=/opt/hive
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$HIVE_HOME/bin

RUN apt-get update && apt-get install -y curl procps net-tools netcat-traditional postgresql-client && rm -rf /var/lib/apt/lists/*
RUN curl -fsSL ${APACHE_MIRROR}/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz     | tar -xz -C /opt  && mv /opt/hadoop-${HADOOP_VERSION} ${HADOOP_HOME}
RUN curl -fsSL ${APACHE_MIRROR}/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz     | tar -xz -C /opt  && mv /opt/apache-hive-${HIVE_VERSION}-bin ${HIVE_HOME}
RUN curl -fsSL https://jdbc.postgresql.org/download/postgresql-42.7.3.jar -o ${HIVE_HOME}/lib/postgresql.jar

RUN mkdir -p /opt/bootstrap/scripts /opt/hive/logs
WORKDIR /opt/bootstrap
