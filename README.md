# htpi
My docker-compose HTPC configuration for raspberry py 


## Features:

* Transmission for torrents
* Couchpotato for Movies
* Sickrage for TV Shows


## Setting up

* install docker 
* install docker-compose
* install git


Create a `settings.bash` file which will export the necessary environment variables

```bash
cat <<EOF > settings.bash
#!/usr/bin/env bash

export HTPC_HOME="/mnt/hdd/htpc"
export HTPC_CONFIG_HOME="~/.htpc"
export HTPC_MEDIA_HOME="/mnt/hdd/htpc"
export HTPC_USER_ID=$(id -u)
export HTPC_GROUP_ID=$(id -u)
export HTPC_TIMEZONE=$(</etc/timezone)
export HTPC_RESTART_POLICY="no"
EOF
```


```
# find out hdd uuid
blkid

# add entry to fstab
UUID=123455678 /mnt/hdd ntfs-3g defaults,auto,uid=1000,gid=1000, 0 0

sudo mkdir -p /mnt/hdd
sudo chmod 775 /mnt/hdd

# umount before mounting
umount /media/EFI/

sudo mount -a

```