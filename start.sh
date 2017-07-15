#!/bin/bash

# start.sh file. run this file when you want to build and start initbuntu.

docker build -t 'logandark/initbuntu:latest' .
docker run --tmpfs /tmp --tmpfs /run -v /sys/fs/cgroup:/sys/fs/cgroup:ro -it --rm logandark/initbuntu
