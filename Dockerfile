FROM php:7-apache

# Build args and env.

ARG ssl

ENV SYMFONY symfonyapp
ENV SYMFONY_APP_PUBLIC_FOLDER public
ENV SSL_CERT /etc/ssl/symfonyapp/cert.pem
ENV SSL_KEY /etc/ssl/symfonyapp/privkey.pem
ENV SSL_CHAIN /etc/ssl/symfonyapp/chain.pem

# Install system packages

WORKDIR /root/

RUN apt-get update
RUN apt-get --assume-yes install zip
RUN apt-get autoclean

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

COPY --chown=root:root ./apache_base_ssl_$ssl.conf /etc/apache2/sites-enabled/000-default.conf

VOLUME /var/log
VOLUME /etc/apache2

#RUN composer create-project symfony/website-skeleton symfonyapp
#ENTRYPOINT ["/usr/local/bin/apache2-foreground"]

