#!/bin/bash

# TODO parameterize drive and volumn names

set -e

# For FS layout see: https://mutschler.dev/linux/pop-os-btrfs-22-04/
cd fingerprint/`hostname`

while read name command ; do
    echo -n $name
    $command > $name
    echo " done"
done <<EOF
01lsblk sudo lsblk -f
02parted sudo parted /dev/nvme0n1 unit MiB print
03luksDump sudo sudo cryptsetup luksDump /dev/nvme0n1p3
041mapper ls /dev/mapper
042pvs sudo pvs
043vgs sudo vgs
044lsblk sudo lsblk /dev/mapper/data-root -f
09mount mount -l
91bashrc cat ${HOME}/.bashrc
92bash_profile cat ${HOME}/.bash_profile
93bash_logout cat ${HOME}/.bash_logout
94profile cat ${HOME}/.profile
EOF
