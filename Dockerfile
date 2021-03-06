FROM php:7-apache

LABEL maintainer="kkon@handmadeapps.tech"

# Build args and env.

ARG SYMFONY_USE_SSL

#ENV SYMFONY symfonyapp
#ENV SYMFONY_APP_PUBLIC_FOLDER public
#ENV SYMFONY_APP_LOG_FOLDER log
#ENV SYMFONY_APACHE_SSL_CERT /etc/ssl/symfonyapp/cert.pem
#ENV SYMFONY_APACHE_SSL_KEY /etc/ssl/symfonyapp/privkey.pem
#ENV SSL_CHAIN /etc/ssl/symfonyapp/chain.pem

WORKDIR /root/

# Install utils

RUN apt-get update
RUN apt-get --assume-yes install zip
RUN apt-get --assume-yes install git
RUN apt-get --assume-yes install vim
RUN apt-get --assume-yes install iputils-ping
RUN apt-get autoclean

# Configure PHP Extensions
RUN docker-php-ext-configure pdo_mysql && docker-php-ext-install pdo_mysql

# Copy PHP ini file
COPY php.ini /usr/local/etc/php/

# Enable Apache modules

RUN a2enmod rewrite
RUN a2enmod ssl

# Install composer

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=/usr/local/bin
RUN php -r "unlink('composer-setup.php');"
RUN mv /usr/local/bin/composer.phar /usr/local/bin/composer

# Copy default Apache conf.

WORKDIR /var/www

VOLUME /var/log
VOLUME /etc/apache2

COPY --chown=root:root ./apache_base_ssl_$SYMFONY_USE_SSL.conf /etc/apache2/sites-enabled/000-default.conf

#RUN composer create-project symfony/website-skeleton symfonyapp
#ENTRYPOINT ["/usr/local/bin/apache2-foreground"]

