#!/bin/bash

apt update -y
apt upgrade -y
apt install fio -y
apt install sysbench -y
apt install iperf3 -y
sysbench cpu --threads=2 run | grep 'events per second:\|events (avg/stddev):' > cpu_test_1
sleep 5
sysbench cpu --threads=2 run | grep 'events per second:\|events (avg/stddev):' > cpu_test_2
sleep 5
sysbench cpu --threads=2 run | grep 'events per second:\|events (avg/stddev):' > cpu_test_3
sleep 5
fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test --filename=test --bs=4k --iodepth=64 --size=4G --readwrite=randrw --rwmixread=75 | grep 'read:\|write:' | awk {'print ($1$2) ($4)'} | sed 's/;//g' | sed "s/([^)]*msec)/ /g" > disk_test_1
sleep 5
fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test --filename=test --bs=4k --iodepth=64 --size=8G --readwrite=randrw --rwmixread=75 | grep 'read:\|write:' | awk {'print ($1$2) ($4)'} | sed 's/;//g' | sed "s/([^)]*msec)/ /g" > disk_test_2
sleep 5
fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test --filename=test --bs=4k --iodepth=64 --size=16G --readwrite=randrw --rwmixread=75 | grep 'read:\|write:' | awk {'print ($1$2) ($4)'} | sed 's/;//g' | sed "s/([^)]*msec)/ /g" > disk_test_3
sleep 5
nohup ./primes.sh &
sysbench cpu --threads=2 run | grep 'events per second:\|events (avg/stddev):' > mixed_cpu_result
fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test --filename=test --bs=4k --iodepth=64 --size=4G --readwrite=randrw --rwmixread=75 | grep 'read:\|write:' | awk {'print ($1$2) ($4)'} | sed 's/;//g' | sed "s/([^)]*msec)/ /g" > mixed_disk_result
