ARG HADOOP_VERSION=3.5.0
ARG SPARK_VERSION=3.5.2
FROM eclipse-temurin:17-jre-jammy

ARG HADOOP_VERSION
ARG SPARK_VERSION

ENV DEBIAN_FRONTEND=noninteractive \
    JAVA_HOME=/opt/java/openjdk \
    HADOOP_HOME=/opt/hadoop \
    HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop \
    YARN_CONF_DIR=/opt/hadoop/etc/hadoop \
    SPARK_HOME=/opt/spark \
    PATH=/opt/hadoop/bin:/opt/hadoop/sbin:/opt/spark/bin:/opt/spark/sbin:$PATH

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash curl wget procps netcat-openbsd python3 python3-pip tini rsync openssh-client libsnappy1v5 \
    && rm -rf /var/lib/apt/lists/*

RUN wget -q https://downloads.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz -O /tmp/hadoop.tgz \
    && tar -xzf /tmp/hadoop.tgz -C /opt \
    && mv /opt/hadoop-${HADOOP_VERSION} /opt/hadoop \
    && rm -f /tmp/hadoop.tgz

#   RUN wget -q https://downloads.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.tgz -O /tmp/spark.tgz \
#    && tar -xzf /tmp/spark.tgz -C /opt \
#    && mv /opt/spark-${SPARK_VERSION}-bin-hadoop3 /opt/spark \
 #   && rm -f /tmp/spark.tgz
# Add new
RUN wget -q https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.tgz -O /tmp/spark.tgz \
    && tar -xzf /tmp/spark.tgz -C /opt \
    && mv /opt/spark-${SPARK_VERSION}-bin-hadoop3 /opt/spark \
    && rm -f /tmp/spark.tgz
    
RUN mkdir -p /hadoop/dfs/name /hadoop/dfs/data /opt/bootstrap/conf /opt/bootstrap/scripts /opt/bootstrap/spark-conf /opt/spark/logs \
    && echo 'export JAVA_HOME=/opt/java/openjdk' >> /opt/hadoop/etc/hadoop/hadoop-env.sh \
    && echo 'export HDFS_NAMENODE_USER=root' >> /opt/hadoop/etc/hadoop/hadoop-env.sh \
    && echo 'export HDFS_DATANODE_USER=root' >> /opt/hadoop/etc/hadoop/hadoop-env.sh \
    && echo 'export HDFS_SECONDARYNAMENODE_USER=root' >> /opt/hadoop/etc/hadoop/hadoop-env.sh \
    && echo 'export YARN_RESOURCEMANAGER_USER=root' >> /opt/hadoop/etc/hadoop/yarn-env.sh \
    && echo 'export YARN_NODEMANAGER_USER=root' >> /opt/hadoop/etc/hadoop/yarn-env.sh \
    && echo 'export JAVA_HOME=/opt/java/openjdk' >> /opt/hadoop/etc/hadoop/yarn-env.sh \
    && echo 'export JAVA_HOME=/opt/java/openjdk' >> /opt/hadoop/etc/hadoop/mapred-env.sh \
    && echo 'export HADOOP_MAPRED_HOME=/opt/hadoop' >> /opt/hadoop/etc/hadoop/mapred-env.sh \
    && echo 'export SPARK_DIST_CLASSPATH=$(/opt/hadoop/bin/hadoop classpath)' >> /opt/spark/conf/spark-env.sh

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["bash"]
