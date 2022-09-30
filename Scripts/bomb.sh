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

# Add core directory
{
    echo "USE_KDUMP=1"
    echo 'KDUMP_COREDIR="/var/crash"'
} >> /etc/default/kdump-tools

sed 's/rootdelay=300/rootdelay=300 crashkernel=auto/g' /etc/default/grub

# updating sysctl per https://docs.microsoft.com/en-us/troubleshoot/azure/virtual-machines/serial-console-nmi-sysrq
sysctl -p

# Set off fork bomb
echo '#!/bin/bash' > /tmp/fork.sh
echo ':(){ :|:& };:' >> /tmp/fork.sh
chmod +x /tmp/fork.sh
bash /tmp/fork.sh
