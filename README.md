# Benchcfe - Cost for Efficiency Benchmark tool


## Description

Benchmark tool to measure the performance of various cloud providers and thus be able to obtain the **cost for efficiency** of each one according to the metrics of my previous [article](https://www.linkedin.com/pulse/hidden-cost-cloud-computing-alfonso-de-la-guarda-reyes).


## Reference

Technically, the vms (instances) are evaluated by CPU, Read and Write Disk performance.
Additionally, the performance of the network between the virtual machine and 3 cloud servers is measured: Google Cloud, Aws, Azure and/or IBM as the case may be.

The process consists of three measurements 5 seconds apart and a fourth measurement that runs in parallel while running a bash Fibonacci sequence between 10 and 50000.

To avoid discrepancies, I have used 2 or more virtual machines per provider, indicating the type and flavor, while maintaining almost the same characteristics (if the provider offers that too):

    * 2 CPU / 4 GB RAM
    * 4 CPU / 8 GB RAM.

The machines were created from scratch and the only tasks they execute are those described in this benchmark.

## Tools

    * fio
    * sysbench
    * iperf3
    * bash script for primes generation


## Requirements

The script was develop and tested for Ubuntu 22.04, however you can easily adapt to any distro ( i am personally use #Manjaro which is #Arch based)


## Usage

Just clone the repository inside your instance (vm/bare metal) and run the **benchcfe.sh** script, after that in the project directory you will see that files have been generated that refer to each test, simply take those values to the referenced table at the end of the document so that the respective calculation of the cost for efficiency can be represented and graphed.

The **$HOSTNAME** variable is defined in the script and taken for the host name command in bash, the user does not need to define it or act on this variable, it will simply be part of each generated file to be able to clearly identify it.

The generated files start with the name **data_cpu_test_X_$HOSTNAME**, **data_disk_test_X_$HOSTNAME**, where **X** is the test number.

Also we will have some additional files **data_mixed_cpu_result_$HOSTNAME** and **data_mixed_disk_result_$HOSTNAME** those indicates the CPU and disk benchmarks meanwhile is running the prime generator script.

Finally we got also: **data_cpu_info_$HOSTNAME**, **data_mem_info_$HOSTNAME** and **data_disk_info_$HOSTNAME** which shows our full resources for each instance(vm/bare metal).



## Network benchmarks

The generation of the network test does not generate any files, it is done manually because it involves interacting with another host on another network, which is a security risk in an uncontrolled environment, in addition to adjusting firewalls and security rules per instance.

The measure of the benchmark is very simple in this case, you only install install **iperf3** put one host in server mode and another in client mode, as this:


## Providers included in the benchmark

    * Vultr
    * Digital Ocean
    * Hetzner x86_64
    * Hetzner ARM
    * OVH x86_64
    * Oracle x86_64
    * Oracle ARM
    * Alibaba Cloud x86_64
    * AWS x86_64
    * AWS ARM
    * Azure x86_64
    * Azure ARM
    * Google Cloud x86_64
    * Google Cloud ARM





## Initial Analysis

All the **virtual machines** (**VMs**) or **instances** have been selected based on their service promises and price (from the lowest to the highest), in addition to the fact that they had to maintain the basic structure (when possible and offered) of 2/4 and 4/8 .

In each instance only ssh access was enabled and when they had a small bootable disk capacity (like AWS), it just went up to 50 GB. No other additional modifications were made.

The purpose of this evaluation is to **compare the average cost of compute units based on processing power and disk read/write offered as standard**.

I am fully aware that several providers can increase the IOPS on disks when required but that will always imply a higher cost, so I am excluding it from the equation because the requirements can simply be variable and their costs are much higher only at that point.

The other key factor is the incoming and outgoing traffic, the **top** providers charge this according to the demand and the free traffic for the computing unit becomes very small therefore an additional cost is generated that according to the demand can take off enormously.

I'm omitting all the traditional aspects of **PAAS**, like load balancers, flexible ips, kubernetes, etc, etc... all those components make the solution even more expensive and can multiply by up to 10+ times the compute units themselves. For that, they can go to the relevant providers and have them size and cost their infrastructure, just remember that the more services they need, the prices not only increase a little more but are even enhanced.  **This is just a compute analysis cost and benchmarks**.

All the metrics ans results from the current tests are available for anyone [here](https://docs.google.com/spreadsheets/d/12DbzpJ058i90bfUvVVFQsrVR7IOyf-DnCIH-7lBFw-8/edit?usp=sharing)

The evidence (data* files) can be freely accessible [here](https://drive.google.com/drive/folders/13AVvSJh1lat3FHJdm5o5Cz6J32RN6LDf?usp=sharing) too


## Warning

The test presents a delay of more than 3 hours (actually some more than 5) in various **AWS** instances, which already indicates a performance problem. If someone has a **VM / instance in AWS**, I invite you to run the script so they can check it out.


## Pro tip

To download the data_* files generated by the script I recommend using a simple scp, something like this:

    bash: scp USER@SERVER:/LOCATION/benchcfe/data* LOCAL_DIRECTORY
    zsh: scp USER@SERVER:/LOCATION/benchcfe/data\* LOCAL_DIRECTORY

Don't forget fill up the correspondent values in the [spreadsheet](https://docs.google.com/spreadsheets/d/12DbzpJ058i90bfUvVVFQsrVR7IOyf-DnCIH-7lBFw-8/edit?usp=sharing) to generate the metrics


## Additional comments

I decided to develop this script and the corresponding table based on the private comments i received in relation to [my first article](https://www.linkedin.com/pulse/hidden-cost-cloud-computing-alfonso-de-la-guarda-reyes) where some traditional cloud providers did not get good metrics and criticized the model I developed, in this case I decided to test all vms and instances and equality of absolute conditions and in its different forms and flavors in such a way that there is no doubt about the **cost for efficiency** to which I refer.

I must also point out that computing power and its relation to cost is not the only factor that one considers for the implementation of a cloud solution, there are very important factors such as network storage, balancing, bonding, networking, security, auto scaling, redundancy, traffic, etc. However, almost all the costs of these services are directly related to the cost of the computing unit.


## Reference: the bash script for primes

I got the bash script that generates the prime numbers from this [website](https://phoxis.org/2011/03/06/bash-script-generating-primes-within-range/), modifying some lines so that the initial and final values were static and did not ask me for the range.


## Contributors ✨

Alfonso de la Guarda [github](https://github.com/alfonsodg).

## License

**Benchcfe** is licensed under the GNU General Public License, Version 2. View a copy of the [License file](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html).
