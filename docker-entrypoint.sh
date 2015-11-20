#!/bin/bash
set -e
jar='kafka-mesos*.jar'
java -jar $jar "$@"