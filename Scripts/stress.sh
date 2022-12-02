#!/bin/bash

# Grab PerfInsights
curl -lj "https://download.microsoft.com/download/9/F/8/9F80419C-D60D-45F1-8A98-718855F25722/PerfInsights.tar.gz" -o "/tmp/PerfInsights.tar.gz"
mkdir /tmp/PerfInsights
tar xzvf "/tmp/PerfInsights.tar.gz" -C "/tmp/PerfInsights"

# Grab stress-ng
# sudo apt-get update && sudo apt-get -y install unzip && sudo apt-get -y install stress-ng
sudo yum install stress-ng -y


# Run PerfInsights
echo 'python3 "/tmp/PerfInsights/perfinsights.py" -q -u -r vmslow -d 700s -a &' > /tmp/perf.py
chmod +x /tmp/perf.py
nohup /tmp/perf.py &

# Start benchmarking
stress-ng --aggressive --maximize --all -1 --pathological --matrix 0 -t 100000m --cpu-load 100 --syslog &
stress-ng --aggressive --maximize --all -1 --pathological --matrix 0 -t 100000m --cpu -1 --vm -1 --hdd -1 --syslog &
