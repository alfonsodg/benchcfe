# Benchcfe - Cost for Efficiency Benchmark tool


## Description

Benchmark tool to measure the performance of various cloud providers and thus be able to obtain the **cost for efficiency** of each one according to the metrics of my previous [article](https://www.linkedin.com/pulse/hidden-cost-cloud-computing-alfonso-de-la-guarda-reyes).


## Reference

Technically, the vms (instances) are evaluated by CPU, Read and Write Disk performance.
Additionally, the performance of the network between the virtual machine and 3 cloud servers is measured: Google Cloud, Aws, Azure and/or IBM as the case may be.

The process consists of three measurements 5 seconds apart and a fourth measurement that runs in parallel while running a bash fibonacci sequence between 10 and 50000.

To avoid discrepancies, I have used 2 or more virtual machines per provider, indicating the type and flavor, while maintaining the same characteristics:

    * 2 CPU / 4 GB RAM
    * 4 CPU / 8 GB RAM.

The machines were created from scratch and the only tasks they execute are those described in this benchmark.

## Tools

    * fio
    * sysbench
    * iperf3
    * bash script for primes generation


## Requirements

The script was develop and tested for Ubuntu 22.04, however you can easly adapt to any distro ( i am personally use #Manjaro which is #Arch based)


## Usage

Just clone the repository inside your instance (vm/bare metal) and run the **benchcfe.sh** script, after that in the project directory you will see that files have been generated that refer to each test, simply take those values to the referenced table at the end of the document so that the respective calculation of the cost for efficiency can be represented and graphed.

The generated files start with the name **cpu_test_X**, **disk_test_X**, where **X** is the test number.

Also we will have two additional files **mixed_cpu_result** and **mixed_disk_result** those indicates the CPU and disk benchmarks meanwhile is running the prime generator script.


## Network benchmarks

The generation of the network test does not generate any files, it is done manually because it involves interacting with another host on another network, which is a security risk in an uncontrolled environment, in addition to adjusting firewalls and security rules per instance.

The measure of the benchmark is very simple in this case, you only install install **iperf3** put one host in server mode and another in client mode, as this:


## Providers included in the benchmark

    * Vultr
    * Digital Ocean
    * Oracle x86_64
    * Oracle ARM
    * Google Cloud x86_64
    * Google Cloud ARM
    * AWS x86_64
    * AWS ARM
    * Azure x86_64
    * Azure ARM
    * Alibaba Cloud x86_64


## Additional notes

I decided to develop this script and the corresponding table based on the private comments i received in relation to [my first article](https://www.linkedin.com/pulse/hidden-cost-cloud-computing-alfonso-de-la-guarda-reyes) where some traditional cloud providers did not get good metrics and criticized the model I developed, in this case I decided to test all vms and instances and equality of absolute conditions and in its different forms and flavors in such a way that there is no doubt about the **cost for efficiency** to which I refer.

I must also point out that computing power and its relation to cost is not the only factor that one considers for the implementation of a cloud solution, there are very important factors such as network storage, balancing, bonding, networking, security, auto scaling, redundancy, etc. However, almost all the costs of these services are directly related to the cost of the computing unit.


## Reference: the bash script for primes

I got the bash script that generates the prime numbers from this [website](https://phoxis.org/2011/03/06/bash-script-generating-primes-within-range/), modifying some lines so that the initial and final values were static and did not ask me for the range.


## Contributors ✨

Alfonso de la Guarda [github](https://github.com/alfonsodg).

## License

**Benchcfe** is licensed under the GNU General Public License, Version 2. View a copy of the [License file](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html).
