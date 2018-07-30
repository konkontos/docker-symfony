# Overview

Docker app (primarily) for Symfony projects.

Comes with PHP Composer, Apache 2.4, PHP 7, MariaDB, PHPMyAdmin and SSL support.

# Build

`docker build --no-cache --rm --build-arg SYMFONY_USE_SSL=off -t handmadeapps/symfony .`

OR

`docker build --no-cache --rm --build-arg SYMFONY_USE_SSL=on -t handmadeapps/symfony .`

Depending on the **ssl** option Apache is setup with the appropriate default file.


# Volumes and Environment vars.


## App content

Apache server is setup to run a Symfony app under **/var/www/[myapp]/[public folder]**

Map a local volume to **/var/www** and then provide values for the following vars:

SYMFONY (default: symfonyapp)

SYMFONY_APP_PUBLIC_FOLDER (default: public)

**See `sample.env` file, and inline comments, for all applicable variables.**


## SSL certificates

If you have enabled SSL, then map a local volume with the necessary files and then provide values for the following vars:

SSL_CERT

SSL_KEY


## Logs

Logs are written under **/var/log**

Map a local volume to this location if you want to store logs locally.


# Quick testing

`docker run --net test --rm -it -v ~/docker_data/symfony/www:/var/www handmadeapps/symfony composer install`

`docker run --rm -it -v ~/docker_data/symfony/www:/var/www handmadeapps/symfony composer create-project symfony/website-skeleton myapp`

`docker run --rm -p 127.0.0.1:8080:80 -v ~/docker_data/symfony/www:/var/www --env SYMFONY=myapp -- env SYMFONY_APP_PUBLIC_FOLDER=web handmadeapps/symfony apache2-foreground`


# Docker Compose App

## Config / Environment Variables

The project contains a `sample.env` file.

Copy this file into `.env` and edit accordingly (see inline comments).


## Running the app

In development, and for conveniency, you can deploy a Symfony app using docker-compose.

`docker-compose up [app | appssl]`

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

copy `sample.env` into `.env`

edit `.env` accordingly to fit your use (hint: the **SYMFONY** variable is the same as the name of your symfony project repo.)

**start** the app : (**NOTE**: you can also use the convenience script `start.sh`)

`docker-compose up -d app`

setup a new symfony project:

`docker exec symfony-app composer create-project symfony/website-skeleton [symfony app name]`

in a browser, go to : [http://localhost:8080/](http://localhost:8080/)

your app is up & running

**stop** the app by issuing: (**NOTE**: you can also use the convenience script `stop.sh`)

`docker-compose down`

at any time you can enter your symfony app container to run commands:

`docker exec -it symfony-app bash`

to enter the database container:

`docker exec -it symfony-database bash`


## Docker-Compose | Tutorial | Existing Project

`git clone https://bitbucket.org/ready-labs-team/docker_symfony.git`

`cd docker_symfony`

copy `sample.env` into `.env`

edit `.env` to fit your project (hint: the **SYMFONY** variable is the same as the name of your symfony project repo.)

**start** the app : (**NOTE**: you can also use the convenience script `start.sh`)

`docker-compose up -d app`

`cd symfony/www`

`git clone [your symfony git project URL]`

`cd ../..`

run `composer install` after initial cloning

`docker exec symfony-app composer --working-dir=[symfony app name] install`

edit the newly generated `parameters.yml` file to match the settings in the `.env` file

run further setup commands, such as setting up your database. e.g.:

`docker exec symfony-app php [symfony app name]/bin/console doctrine:schema:update --force`

in a browser, go to : [http://localhost:8080/](http://localhost:8080/)

your app is up & running

**stop** the app by issuing: (**NOTE**: you can also use the convenience script `stop.sh`)

`docker-compose down`

at any time you can enter your symfony app container to run commands:

`docker exec -it symfony-app bash`

to enter the database container:

`docker exec -it symfony-database bash`


## Optional, PHPMyAdmin service

You can optionally start a PHPMyAdmin by entering: `docker-compose up -d phpmyadmin`


## Notes

- When switching between SSL config (on / off) add the `--build` argument to `docker-compose up` (or at at the end of `start.sh`) to ensure that the app image is rebuilt with the correct Apache server configuration. 

## MariaDB | Default Connection Settings

**hostname**: symfony-database
**dbname**: symfony
**user**: symfony
**password**: passwd


# References

- [Docker Compose Overview](https://docs.docker.com/compose/overview/)
- [Installing & Setting up the Symfony Framework](https://symfony.com/doc/current/setup.html)
- [Symfony | Configuring a Web Server](https://symfony.com/doc/current/setup/web_server_configuration.html)





