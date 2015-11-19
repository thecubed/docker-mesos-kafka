#!/bin/bash
set -e
jar='kafka-mesos*.jar'

if [ "$1" = 'scheduler' ]; then
	set -- "$@" "--storage=zk:/kafka-mesos" "--api=http://127.0.0.1:7000" "--framework-timeout=2d"
fi

java -jar $jar "$@"