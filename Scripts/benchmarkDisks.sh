#!/bin/bash

# Add kernel dump conditions
{
    echo "kernel.sysrq=1"
    echo "kernel.hung_task_panic = 1"
    echo "kernel.panic = 1"
    echo "kernel.panic_on_io_nmi = 1"
    echo "kernel.panic_on_oops = 1"
    # echo "kernel.panic_on_stackoverflow = 1"
    echo "kernel.panic_on_unrecovered_nmi = 1"
    echo "kernel.softlockup_panic = 1"
    echo "kernel.unknown_nmi_panic = 1"
    echo "vm.panic_on_oom = 1"
} >> /etc/sysctl.conf

# Add kernel dump conditions
{
    echo "USE_KDUMP=1"
    echo 'KDUMP_COREDIR="/var/crash"'
} >> /etc/default/kdump-tools

sed 's/rootdelay=300/rootdelay=300 crashkernel=auto/g' /etc/default/grub

# updating sysctl per https://docs.microsoft.com/en-us/troubleshoot/azure/virtual-machines/serial-console-nmi-sysrq
sysctl -p

# Grab PerfInsights
curl -lj "https://download.microsoft.com/download/9/F/8/9F80419C-D60D-45F1-8A98-718855F25722/PerfInsights.tar.gz" -o "/tmp/PerfInsights.tar.gz"
mkdir /tmp/PerfInsights
tar xzvf "/tmp/PerfInsights.tar.gz" -C "/tmp/PerfInsights"

# Grab Fio
yum install fio -y

# Run PerfInsights
echo 'python3 "/tmp/PerfInsights/perfinsights.py" -q -u -r vmslow -d 700s -a &' > /tmp/perf.py
chmod +x /tmp/perf.py
nohup /tmp/perf.py &

# Run Fio benchmarking
fio --name=randrw2.dat --ioengine=libaio --iodepth=128 --rw=randwrite --bs=8k --direct=1 --size=1024M --numjobs=1 --runtime=300 --group_reporting --time_based
fio --name=randrw2.dat --ioengine=libaio --iodepth=128 --rw=randwrite --bs=512k --direct=1 --size=1024M --numjobs=1 --runtime=300 --group_reporting --time_based
