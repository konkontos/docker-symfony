# Overview

Base image for Symfony projects.

Comes with composer, Apache 2.4, PHP 7 and SSL support.

# Build

`docker build --no-cache --rm --build-arg ssl=off -t handmadeapps/symfony .`

OR

`docker build --no-cache --rm --build-arg ssl=on -t handmadeapps/symfony .`

Depending on the **ssl** option Apache is setup with the appropriate default file.


# Volumes and Environment vars.

## App content

Apache server is setup to run a Symfony app under **/var/www/[myapp]/[public folder]**

Map a local volume to **/var/www** and then provide values for the following vars:

SYMFONY (default: symfonyapp)

SYMFONY_APP_PUBLIC_FOLDER (default: public)

## SSL certificates

If you have enabled SSL, then map a local volume with the necessary files and then provide values for the following vars:

SSL_CERT

SSL_KEY

SSL_CHAIN

## Logs

Logs are written under **/var/log**

Map a local volume to this location if you want to store logs locally.


# Quick testing

`docker run --rm -it -v ~/docker_data/symfony/www:/var/www handmadeapps/symfony composer create-project symfony/website-skeleton myapp`

`docker run --rm -p 127.0.0.1:8080:80 -v ~/docker_data/symfony/www:/var/www --env SYMFONY=myapp handmadeapps/symfony apache2-foreground`


# Docker Compose App

In development, and for conveniency, you can deploy a Symfony app using docker-compose.

To deploy a plain HTTP Symfony with accompanying MariaDB run:

`docker-compose -f ./docker-compose_off.yml up`

for SSL run:

`docker-compose -f ./docker-compose_on.yml up`

Running these commands will, in-place, create the following folder hierarchy:

    symfony
        database
        www
        log
        
Use the **www** sub-folder to clone your existing Symfony project in.

You can specify the port for the Symfony app by setting the **SYMFONY_PORT** environment variable.

