ARG HIVE_VERSION=4.0.1
ARG HADOOP_VERSION=3.5.0
FROM eclipse-temurin:17-jre-jammy

ARG HIVE_VERSION
ARG HADOOP_VERSION

ENV DEBIAN_FRONTEND=noninteractive \
    JAVA_HOME=/opt/java/openjdk \
    HIVE_HOME=/opt/hive \
    HADOOP_HOME=/opt/hadoop \
    HIVE_CONF_DIR=/opt/hive/conf \
    PATH=/opt/hive/bin:/opt/hadoop/bin:$PATH

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash curl wget netcat-openbsd postgresql-client procps tini python3 \
    && rm -rf /var/lib/apt/lists/*

RUN wget -q https://downloads.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz -O /tmp/hadoop.tgz \
    && tar -xzf /tmp/hadoop.tgz -C /opt \
    && mv /opt/hadoop-${HADOOP_VERSION} /opt/hadoop \
    && rm -f /tmp/hadoop.tgz

RUN wget -q https://downloads.apache.org/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz -O /tmp/hive.tgz \
    && tar -xzf /tmp/hive.tgz -C /opt \
    && mv /opt/apache-hive-${HIVE_VERSION}-bin /opt/hive \
    && rm -f /tmp/hive.tgz

RUN wget -q https://jdbc.postgresql.org/download/postgresql-42.7.4.jar -O /opt/hive/lib/postgresql.jar \
    && mkdir -p /opt/bootstrap/scripts /opt/hive/logs \
    && echo 'export JAVA_HOME=/opt/java/openjdk' >> /opt/hive/conf/hive-env.sh

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["bash"]
