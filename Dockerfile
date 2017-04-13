FROM ubuntu:16.04

ENV MESOS_VERSION 1.0.0-2.0.86.ubuntu1604
ENV MESOS_KAFKA_VERSION 0.10.1.0
ENV KAFKA_VERSION 0.10.2.0
ENV GIT_VERSION f080281dd128e8ce0ecab3d5266984937216ace5

# Add mesos repo
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E56151BF \
	&& echo deb http://repos.mesosphere.io/ubuntu xenial main > /etc/apt/sources.list.d/mesosphere.list \
	&& apt-get update \
	&& apt-get install -qy --no-install-recommends \
		wget openjdk-8-jdk-headless mesos=$MESOS_VERSION gradle scala git-core \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /kafka-mesos
WORKDIR /kafka-mesos

# Build from source
RUN git clone https://github.com/mesos/kafka.git framework && \
	git checkout $GIT_VERSION && \
	cd framework && \
	./gradlew jar && \
	mv kafka-mesos-$MESOS_KAFKA_VERSION-SNAPSHOT-kafka_2.11-$KAFKA_VERSION.jar ../

# Uncomment and comment above to use prebuilt version
#RUN wget -o /dev/null https://github.com/mesos/kafka/releases/download/v$MESOS_KAFKA_VERSION/kafka-mesos-$MESOS_KAFKA_VERSION-kafka_2.10-$KAFKA_VERSION.jar
RUN wget https://archive.apache.org/dist/kafka/$KAFKA_VERSION/kafka_2.11-$KAFKA_VERSION.tgz
ADD docker-entrypoint.sh /kafka-mesos/docker-entrypoint.sh

ENTRYPOINT ["/kafka-mesos/docker-entrypoint.sh"]
