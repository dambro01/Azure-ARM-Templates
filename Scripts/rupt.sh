#!/bin/bash

sudo dd if=/dev/zero of=/dev/sda2 bs=1k seek=10 count=4k
sudo dd if=/dev/urandom of=/dev/sda2 bs=1024 seek=$((RANDOM%10)) count=1 conv=notrunc
dd if=original.Z of=/dev/sda2 bs=1 count=140389

# i=1
# while [ $i -le 220 ]
# do
#     j=$(shuf -i 2050048-2912511 -n 1)
#     sudo dd if=/dev/random of=/dev/sda2 bs=1 count="$i" seek="$j" &
#     (( i++ ))
# done
shutdown -r
