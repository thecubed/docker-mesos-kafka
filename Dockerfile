FROM ubuntu:16.04

ENV MESOS_VERSION 1.0.0-2.0.86.ubuntu1604
ENV MESOS_KAFKA_VERSION 0.10.0.0
ENV KAFKA_VERSION 0.10.1.1

# Add mesos repo
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E56151BF \
	&& echo deb http://repos.mesosphere.io/ubuntu xenial main > /etc/apt/sources.list.d/mesosphere.list \
	&& apt-get update \
	&& apt-get install -qy --no-install-recommends \
		wget openjdk-8-jre-headless mesos=$MESOS_VERSION \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /kafka-mesos
WORKDIR /kafka-mesos
RUN wget -o /dev/null https://github.com/mesos/kafka/releases/download/v$MESOS_KAFKA_VERSION/kafka-mesos-$MESOS_KAFKA_VERSION-kafka_2.10-$KAFKA_VERSION.jar
RUN wget https://archive.apache.org/dist/kafka/$KAFKA_VERSION/kafka_2.12-$KAFKA_VERSION.tgz
ADD docker-entrypoint.sh /kafka-mesos/docker-entrypoint.sh

ENTRYPOINT ["/kafka-mesos/docker-entrypoint.sh"]
