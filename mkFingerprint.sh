#!/bin/bash

# TODO parameterize drive and volumn names

set -e

# For FS layout see: https://mutschler.dev/linux/pop-os-btrfs-22-04/
cd fingerprint/`hostname`
while read name command ; do
    if [ "$name" = "#" -o -z "$name" ]; then
	echo "$name $command"
	continue
    fi
    echo -n "$name"
    echo "# $command" > "$name"
    $command >> "$name"
    echo " done"
done <<EOF
# Disks and storage
01lsblk sudo lsblk -f
02parted sudo parted /dev/nvme0n1 unit MiB print
03luksDump sudo sudo cryptsetup luksDump /dev/nvme0n1p3
041mapper ls /dev/mapper
042pvs sudo pvs
043vgs sudo vgs
044lsblk sudo lsblk /dev/mapper/data-root -f
09mount mount -l

# Other hardware
11lspci lspci
12lscpu lscpu
13lsmem lsmem
14lsusb sudo lsusb
15udevadm udevadm info /dev/input/by-id/*
19lshw sudo lshw

# Kernel and drivers
21uname uname -a
22boot sudo ls -Rl /boot
23config egrep . /boot/config*
24lsmod lsmod

# Userland
31apt apt list
25rootpip sudo pip list
35userpip pip list

# users and accounts
81lslogins lslogins

# personal profile
91bashrc cat ${HOME}/.bashrc
92bash_profile cat ${HOME}/.bash_profile
93bash_logout cat ${HOME}/.bash_logout
94profile cat ${HOME}/.profile
94xinput xinput
EOF

exit
# Tools to consider

