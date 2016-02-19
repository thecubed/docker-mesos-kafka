FROM ubuntu:14.04

ENV MESOS_VERSION 0.27.0-0.2.190.ubuntu1404
ENV MESOS_KAFKA_VERSION 0.9.4.0
ENV KAFKA_VERSION 0.8.2.2

# Add mesos repo
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E56151BF \
	&& echo deb http://repos.mesosphere.io/ubuntu trusty main > /etc/apt/sources.list.d/mesosphere.list \
	&& apt-get update \
	&& apt-get install -qy \
		wget openjdk-7-jdk mesos=$MESOS_VERSION \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /kafka-mesos
WORKDIR /kafka-mesos  
RUN wget -o /dev/null https://github.com/mesos/kafka/releases/download/$MESOS_KAFKA_VERSION/kafka-mesos-$MESOS_KAFKA_VERSION.jar
RUN wget https://archive.apache.org/dist/kafka/$KAFKA_VERSION/kafka_2.11-$KAFKA_VERSION.tgz
ADD docker-entrypoint.sh /kafka-mesos/docker-entrypoint.sh

ENTRYPOINT ["/kafka-mesos/docker-entrypoint.sh"]
