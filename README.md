# htpi
My docker-compose HTPC configuration for raspberry pi 


## Features:

* Transmission for torrents
* Radarr for Movies
* Sickrage for TV Shows


## Setting up

* setup sd card with latest OSMC image
* install docker 
* [install docker-compose](https://github.com/hypriot/arm-compose#installation)
* install git

```bash

# install lsb-release
sudo apt-get install lsb-release

# install docker
curl -sSL https://get.docker.com | sh

# Add osmc user to docker group
sudo usermod -aG docker osmc

```

Create a `settings.bash` file which will export the necessary environment variables

```bash
cat <<'EOF' > settings.bash
#!/usr/bin/env bash

export HTPC_PLATFORM="lsioarmhf"
export HTPC_KODI_HOST=$(ifconfig | grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}" | grep -v 127.0.0.1 | awk '{ print $2 }' | cut -f2 -d: | head -n1)
export HTPC_HOME="/mnt/hdd/htpc"
export HTPC_CONFIG_HOME="~/.htpc"
export HTPC_MEDIA_HOME="/mnt/hdd/htpc"
export HTPC_DOWNLOAD_HOME="/mnt/hdd/htpc"
export HTPC_USER_ID=$(id -u)
export HTPC_GROUP_ID=$(id -u)
export HTPC_TIMEZONE=$(</etc/timezone)
export HTPC_RESTART_POLICY="unless-stopped"
EOF
```

Mounting an external hdd

```bash
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


# Running

```bash

# starting containers
source settings.bash && docker-compose -f transmission.yaml -f sonarr.yaml -f radarr.yaml up -d

# removing containers
source settings.bash && docker-compose -f transmission.yaml -f sonarr.yaml -f radarr.yaml down


```