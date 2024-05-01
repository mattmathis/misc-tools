#!/bin/bash

backups='/media/mattmathis/Seagate Portable Drive/Backups/'

if [ ! -d "$backups" ]; then
    echo "Missing $backups - Is the drive mounted?"
    exit 2
fi

target="${backups}/"`date --iso`

echo "Backing up $HOME to $target"

sudo mkdir -p "$target"
# NB: this makes two passes: owner and stat are copied after the data
# Do not ever cross mount points
sudo time cp --archive --one-file-system "$HOME" "$target"
echo "Backup Done"

