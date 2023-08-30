#!/bin/bash

apt update -y
apt upgrade -y
apt install fio -y
apt install sysbench -y
apt install iperf3 -y
echo "Starting tests...."
HN=`hostname`
sysbench cpu --threads=2 run | grep 'events per second:\|events (avg/stddev):' > data_cpu_test_1_$HN
sleep 5
sysbench cpu --threads=2 run | grep 'events per second:\|events (avg/stddev):' > data_cpu_test_2_$HN
sleep 5
sysbench cpu --threads=2 run | grep 'events per second:\|events (avg/stddev):' > data_cpu_test_3_$HN
sleep 5
fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test --filename=test --bs=4k --iodepth=64 --size=4G --readwrite=randrw --rwmixread=75 | grep 'read:\|write:' | awk {'print ($1$2) ($4)'} | sed 's/;//g' | sed "s/([^)]*msec)/ /g" > data_disk_test_1_$HN
sleep 5
fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test --filename=test --bs=4k --iodepth=64 --size=8G --readwrite=randrw --rwmixread=75 | grep 'read:\|write:' | awk {'print ($1$2) ($4)'} | sed 's/;//g' | sed "s/([^)]*msec)/ /g" > data_disk_test_2_$HN
sleep 5
fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test --filename=test --bs=4k --iodepth=64 --size=16G --readwrite=randrw --rwmixread=75 | grep 'read:\|write:' | awk {'print ($1$2) ($4)'} | sed 's/;//g' | sed "s/([^)]*msec)/ /g" > data_disk_test_3_$HN
sleep 5
nohup ./primes.sh &
sysbench cpu --threads=2 run | grep 'events per second:\|events (avg/stddev):' > data_mixed_cpu_result_$HN
fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test --filename=test --bs=4k --iodepth=64 --size=4G --readwrite=randrw --rwmixread=75 | grep 'read:\|write:' | awk {'print ($1$2) ($4)'} | sed 's/;//g' | sed "s/([^)]*msec)/ /g" > data_mixed_disk_result_$HN
cat /proc/cpuinfo > data_cpu_info_$HN
cat /proc/meminfo > data_mem_info_$HN
cat df -h > data_disk_info_$HN
echo "Tests ended..."
echo "Please colllect the data* files to fill up the spreadsheet"
