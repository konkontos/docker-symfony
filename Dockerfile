FROM php:7-apache
ARG ssl
ENV SYMFONY symfonyapp
ENV SYMFONY_APP_PUBLIC_FOLDER public
WORKDIR /root/
RUN apt-get update
RUN apt-get --assume-yes install zip
RUN apt-get autoclean
RUN a2enmod rewrite
RUN a2enmod ssl
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=/usr/local/bin
RUN php -r "unlink('composer-setup.php');"
RUN mv /usr/local/bin/composer.phar /usr/local/bin/composer
WORKDIR /var/www
#RUN composer create-project symfony/website-skeleton symfonyapp
COPY --chown=root:root ./apache_base_ssl_$ssl.conf /etc/apache2/sites-enabled/000-default.conf
#WORKDIR /var/www/symfonyapp
#ENTRYPOINT ["/usr/local/bin/apache2-foreground"]






#ENV B2_ACCOUNT_INFO /mnt/data/.b2_account_info
#VOLUME /data
#ENV RESTIC_REPOSITORY unknown
#FROM alpine:latest
#RUN apk --no-cache add git
#WORKDIR /root/
#COPY --from=0 /go/src/github.com/alexellis/href-counter/app .
#CMD ["./app"]
