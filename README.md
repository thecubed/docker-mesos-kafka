# Apache Kafka Mesos Scheduler
Apache Kafka on Apache Mesos in Docker

## Usage

This project simply encapsulates the `mesos/kafka` project in a Docker container to allow easy scheduling with Marathon. For all configration options please see: https://github.com/mesos/kafka#scheduler-configuration

```
$ docker pull sagent/mesos-kafka
$ docker run -d -p 7000:7000 sagent/mesos-kafka scheduler --master=master:5050 --zk=zookeeper:2181
```
