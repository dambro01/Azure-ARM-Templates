#!/bin/bash

# Add Python script to fill disk: https://stackoverflow.com/a/13800346/7954017
{
echo "import sys
import errno
import os

write_str = '!'*1024*1024*5  # 5MB
output_path = sys.argv[0]
try:
	with open(output_path, 'w') as f:
		while True:
			try:
				f.write(write_str)
				f.flush()
			except IOError as err:
				if err.errno == errno.ENOSPC:
					write_str_len = len(write_str)
					if write_str_len > 1:
						write_str = write_str[:write_str_len/2]
					else:
						break
				else:
					raise
except:
	print('Ran out of space')
os.system('shutdown now -r')"
} > /tmp/fillDisk.py

# Reconfigure auditd to halt server
sed -i 's/space_left = 75/space_left = 20%/g' /etc/audit/auditd.conf
sed -i 's/space_left_action = SYSLOG/space_left_action = halt/g' /etc/audit/auditd.conf
sed -i 's/admin_space_left_action = SUSPEND/admin_space_left_action = halt/g' /etc/audit/auditd.conf
sed -i 's/disk_full_action = SUSPEND/disk_full_action = halt/g' /etc/audit/auditd.conf
sed -i 's/disk_error_action = SUSPEND/disk_error_action = halt/g' /etc/audit/auditd.conf
sed -i 's/overflow_action = SYSLOG/overflow_action = halt/g' /etc/audit/auditd.conf

# Restart auditd and load new rules
service auditd reload
auditd -s enable

# Fill up partition on the server
fallocate -l 100G fFile
echo '#!/bin/bash' > /tmp/runPythonScript.sh
echo 'python3 "/tmp/fillDisk.py" &' >> /tmp/runPythonScript.sh
chmod +x /tmp/fillDisk.py
chmod +x /tmp/runPythonScript.sh
sh /tmp/runPythonScript.sh
dd if=/dev/zero of=ddFile bs=1G count=24 &
