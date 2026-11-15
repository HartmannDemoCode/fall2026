---
title: 08 Deployment Workshop
description: Deploy your React project to a virtual server at Digital Ocean
weight: 8
draft: false
geekdocCollapseSection: true
---

## Prepare for the class
- Follow steps 0-4 in [Toolbox: Deployment Infrastructure](../toolbox/deployment-infrastructure/_index.md) to set up your droplet and SSH access.

# Videos
1. [Buy your domain, start a new droplet and point name servers to Digital Ocean 10:00](https://youtu.be/eNdRjnl-HjM) 
2. [SSH into your droplet, create folder and files 15:00](https://youtu.be/NWJb2gxR-hs)
3. [Build project locally, copy to droplet and run with Caddy 10:00](https://youtu.be/IQh8_m_vroM)

## Code snippets
### Docker compose with Caddy
- Indentation is important in YAML files. Make sure to use spaces, not tabs.
- We use a preinstalled Caddy image from Docker Hub. Caddy is a web server that can serve static files and handle HTTPS automatically.
- We open ports 80 and 443 for HTTP and HTTPS traffic. Caddy will automatically obtain and renew SSL certificates for your domain.
- We mount the Caddyfile, site folder, and Caddy data/config folders as volumes. This allows us to configure Caddy and serve our website files.
- Our website files should be placed in the `site/deployfolder` directory. Caddy will serve files from this directory.

```yaml
services:
  caddy:
    image: caddy:2.7.6
    restart: unless-stopped
    container_name: caddy
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./Caddyfile:/etc/caddy/Caddyfile
      - ./site:/srv
      - ./caddy_data:/data
      - ./caddy_config:/config

```

### Caddyfile
- The Caddyfile is the configuration file for Caddy. It defines how Caddy should serve your website.
- The `root` directive specifies the root directory for your website files. In this case, it is `/srv/deployfolder`, which corresponds to the `site/deployfolder` directory on your host machine.
- The `file_server` directive enables static file serving. Caddy will serve files from the specified root directory.
- The `try_files` directive tells Caddy to try to serve the requested file. If the file does not exist, it will fall back to serving `index.html`. This is useful for single-page applications (SPAs) that use client-side routing.

```text
yourdomain.dk {
    root * /srv/deployfolder
    file_server
    try_files {path} /index.html
}
```

## Linux commands
- `ls -la` - list all files in current directory with details
- `cd <directory>` - change directory to `<directory>`
- `cd ..` - go up one directory level
- `mkdir <directory>` - create a new directory called `<directory>`
- `rm -rf <directory>` - remove a directory and its contents (recursively)
- `touch <filename>` - create a new empty file called `<filename>`
- `nano <filename>` - open a file called `<filename>` in the nano text editor
- `cat <filename>` - display the contents of a file called `<filename>`
- `cp <source> <destination>` - copy a file or directory from `<source>` to `<destination>`
- `mv <source> <destination>` - move a file or directory from `<source>` to `<destination>` also used for renaming files or directories
- `pwd` - print the current working directory
- `whoami` - print the current logged in user

### Less frequently used commands
- `grep <pattern> <filename>` - search for a pattern in a file
- `find <directory> -name <filename>` - search for a file in a directory
- `tar -xzvf <archive.tar.gz>` - extract a compressed tar archive
- `scp <source> <user>@<host>:<destination>` - securely copy a file from local to remote host
- `ssh <user>@<host>` - connect to a remote host via SSH
- `sudo <command>` - run a command with superuser privileges
- `apt-get update` - update package lists for upgrades and new packages
- `apt-get upgrade` - upgrade all installed packages to the latest version
- `apt-get install <package>` - install a package
- `apt-get remove <package>` - remove a package
- `apt-get purge <package>` - remove a package and its configuration files
- `systemctl start <service>` - start a service
- `systemctl stop <service>` - stop a service
- `systemctl restart <service>` - restart a service
- `systemctl status <service>` - check the status of a service
- `chmod +x <filename>` - make a file executable
- `chown <user>:<group> <filename>` - change the owner and group of a file or directory
- `df -h` - display disk space usage in human-readable format
- `du -sh <directory>` - display the size of a directory in human-readable format
- `top` - display running processes and system resource usage
- `ps aux` - display all running processes with details
- `kill <pid>` - terminate a process with the given process ID `<pid>`
- `ping <hostname>` - send ICMP echo requests to a host to check connectivity
- `ifconfig` - display network interface configuration (use `ip addr` on newer systems)
- `ip addr` - display network interface configuration (newer systems)
- `netstat -tuln` - display listening ports and network connections
