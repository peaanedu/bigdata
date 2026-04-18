FROM eclipse-temurin:17-jre-jammy

ARG HADOOP_VERSION=3.5.0
ENV HADOOP_HOME=/opt/hadoop \
    HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop \
    JAVA_HOME=/opt/java/openjdk \
    PATH=/opt/hadoop/bin:/opt/hadoop/sbin:$PATH

RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-client openssh-server curl bash procps net-tools rsync tini \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://downloads.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz -o /tmp/hadoop.tgz \
    && mkdir -p /opt \
    && tar -xzf /tmp/hadoop.tgz -C /opt \
    && ln -s /opt/hadoop-${HADOOP_VERSION} /opt/hadoop \
    && rm -f /tmp/hadoop.tgz

RUN mkdir -p /var/run/sshd /hadoop/dfs/name /hadoop/dfs/data /hadoop/logs \
    && useradd -ms /bin/bash hadoop \
    && chown -R hadoop:hadoop /opt/hadoop-${HADOOP_VERSION} /hadoop

COPY config/* ${HADOOP_CONF_DIR}/
COPY scripts/entrypoint.sh /entrypoint.sh
COPY scripts/init-hdfs.sh /init-hdfs.sh
RUN chmod +x /entrypoint.sh /init-hdfs.sh

EXPOSE 9870 9864 8088 19888 9000 8020 8032 8042
ENTRYPOINT ["/usr/bin/tini","--","/entrypoint.sh"]
