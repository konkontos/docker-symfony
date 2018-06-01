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

`docker run --net test --rm -it -v ~/docker_data/symfony/www:/var/www handmadeapps/symfony composer install`

`docker run --rm -it -v ~/docker_data/symfony/www:/var/www handmadeapps/symfony composer create-project symfony/website-skeleton myapp`

`docker run --rm -p 127.0.0.1:8080:80 -v ~/docker_data/symfony/www:/var/www --env SYMFONY=myapp -- env SYMFONY_APP_PUBLIC_FOLDER=web handmadeapps/symfony apache2-foreground`


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


## Docker-Compose | Tutorial | New Project

`git clone https://bitbucket.org/ready-labs-team/docker_symfony.git`

`cd docker_symfony`

edit `setup-env.sh` to fit your project (hint: the **SYMFONY** variable is the same as the name of your symfony project repo.)

run `source setup-env.sh`

start the app :

`docker-compose -f ./docker-compose_off.yml up -d`

setup a new symfony project:

`docker exec symfony-app composer create-project symfony/website-skeleton [symfony app name]`

in a browser, go to : [http://localhost:8080/](http://localhost:8080/)

your app is up & running

stop the app by issuing:

`docker-compose -f ./docker-compose_off.yml down`

at any time you can enter your symfony app container to run commands:

`docker exec -it symfony-app bash`

to enter the database container:

`docker exec -it symfony-database bash`


## Docker-Compose | Tutorial | Existing Project

`git clone https://bitbucket.org/ready-labs-team/docker_symfony.git`

`cd docker_symfony`

edit `setup-env.sh` to fit your project (hint: the **SYMFONY** variable is the same as the name of your symfony project repo.)

run `source setup-env.sh`

start the app :

`docker-compose -f ./docker-compose_off.yml up -d`

`cd symfony/www`

`git clone [your symfony git project URL]`

`cd ../..`

run `composer install` after initial cloning

`docker exec symfony-app composer --working-dir=[symfony app name] install`

edit the newly generated `parameters.yml` file to match the settings in the `setup-env.sh` script

run further setup commands, such as setting up your database. e.g.:

`docker exec symfony-app php [symfony app name]/bin/console doctrine:schema:update --force`

in a browser, go to : [http://localhost:8080/](http://localhost:8080/)

your app is up & running

stop the app by issuing:

`docker-compose -f ./docker-compose_off.yml down`

at any time you can enter your symfony app container to run commands:

`docker exec -it symfony-app bash`

to enter the database container:

`docker exec -it symfony-database bash`


## MariaDB | Default Connection Settings

**hostname**: symfony-database
**dbname**: symfony
**user**: symfony
**password**: passwd


