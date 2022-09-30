#!/bin/bash

cd /boot || return
rm -rf vmlinuz* initr*
shutdown -r
