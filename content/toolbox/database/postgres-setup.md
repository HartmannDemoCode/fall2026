---
title: "Postgres Setup"
description: "Hjælp til lokal opsætning af Postgres via Docker"
weight: 1
draft: false
---
This documents tells you  how to setup Postgres and PgAdmin for 2nd + 3rd semester on you local machine. The two applications, Postgres and PgAdmin both run in isolated Docker Containers. Postgres as a Database Server and PgAdmin as a Database Client. You will launch PgAdmin through a browser.

## Setup Localhost

### 1. Install Docker Desktop

[Docker Desktop](https://docs.docker.com/get-docker/). If you are installing on Windows, you might need to update WSL. A message with instructions will show if necessary during installation. If so, open the PowerShell as Administrator and type:

```bash
wsl --install
```

### 2. Create a folder for your Postgres setup

Find a suitable spot on your harddisk. Could be:

```plaintext
C:\Users\<YourUsername>\Documents\Postgres
```

Open a blank file named `docker-compose.yml` in this folder and paste this into it - and save:

```yml
# Localhost Docker Compose fil for 2+3. semester på datamatiker uddannelsen
# Opretter to containere: 
# db: Postgresql data base server som kører på port 5432
# pgadmin: Webbaseret interface til brug af Postgres. Den tilgås på port 8080

services:
  db:
    image: postgres:16.2
    container_name: db
    restart: unless-stopped
    mem_limit: 1536MB
    mem_reservation: 1024MB
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: appdb            # optional: default DB
      TZ: Europe/Copenhagen
    volumes:
      - ./data:/var/lib/postgresql/data
    ports:
      - "5432:5432"
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 10s
      timeout: 5s
      retries: 5

  pgadmin:
    image: dpage/pgadmin4:latest
    container_name: pgadmin
    restart: unless-stopped
    mem_reservation: 512MB
    mem_limit: 1024MB
    depends_on:
      db:
        condition: service_healthy
    environment:
      PGADMIN_DEFAULT_EMAIL: admin@cphbusiness.dk
      PGADMIN_DEFAULT_PASSWORD: 1234
      PGADMIN_CONFIG_MASTER_PASSWORD_REQUIRED: 'False'  # skip extra prompt (dev only)
      PGADMIN_CONFIG_MAX_LOGIN_ATTEMPTS: 0              # disable lockout on failed logins
      TZ: Europe/Copenhagen
    volumes:
      - ./pgadmin-data:/var/lib/pgadmin   # named volume, persists pgAdmin config
    ports:
      - "8080:80"
    healthcheck:
      test: ["CMD-SHELL", "curl -fsS http://localhost:80/misc/ping || exit 1"]
      interval: 10s
      timeout: 5s
      retries: 10

volumes:
  pgadmin-data:
```

Open a terminal / gitBash and navigate to the folder where you created the `docker-compose.yml` file. Run the following command to start the containers:

```bash
docker-compose up -d
```

This command will download the necessary Docker images and start the Postgres and PgAdmin containers in detached mode. You can check the status of the containers with:

```bash
docker-compose ps
```

Also, you should be able to see the two running containers in Docker Desktop.

### 3. Access Postgres pgadmin dashboard through browser

```bash
  localhost:8080
```

#### 3.1. Login

- login: **<admin@cphbusiness.dk>** (see docker-compose.yml)
- password: **1234** (see docker-compose.yml)

#### 3.2. Add new server

- Choose: Server -> Register -> Server

On Register - Server dialogue:

- On General tab:
  - Name: localhost

- On Connection tab:
  - Host name/address: **db**
  - Port: **5432**
  - username: postgres
  - password: postgres

![Connection](../images/pgadmin_db_connect.png)

#### 3.3 Fine tune PgAdmin

To simplify the UI, you can hide unused menus here:

- File -> Preferences -> Nodes

You can easily hide these guys:

![Show/hide nodes](../images/pgadmin_nodes.png)

***

## Docker commands

### Stop Docker

```bash
  docker compose down
```

### Reset DB data installation

(-v) // remove volumes

```bash
 docker compose down -v 
```

```bash
 sudo  rm -rf ./data
```

***

### Debugging

- Check if all containers are running with `docker ps -a`
- Check if all env variables are set in .env file and are correct
- Check if docker compose has read all environment variables with `docker-compose config`
- Check the logs of the individual container with `docker logs <container_name>` or `docker logs --follow <container_name>`

### Windows errors when starting Docker Desktop

On a few laptops, Docker Desktop will not work. The problems can be hard to find - but these two areas are usually the case:

A. Problems with hyper-V - need to be activated in your BIOS

B. Problems with WSL. In the WSL case - it might help to do this:

  1. Uninstall the current Docker Desktop.
  2. Remove any .docker folder from your user directory.
  3. Clean the %temp% folder.
  4. Unregister docker-desktop using WSL.
  5. Run wsl --update.
  6. Reinstall Docker Desktop.
  7. Restart Windows.
  8. Make sure WSL Ubuntu is running (check in powershell)
  9. Start Docker Desktop

## Documentation

- [PostgreSQL](https://www.postgresql.org/) for database
- [pgAdmin](https://www.pgadmin.org/) for database management
- [Docker](https://www.docker.com/) for containerization
- [Docker Compose](https://docs.docker.com/compose/) for container orchestration.

![Tech Stack](../images/techstack.png)
