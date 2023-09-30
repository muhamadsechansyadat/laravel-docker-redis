FROM php:8.2-fpm-alpine

RUN set -ex \
	&& apk add --update --no-cache \
		postgresql-dev 

	
RUN docker-php-ext-install pdo_pgsql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Git
RUN apk update && apk add --no-cache git

RUN mkdir -p /var/www/app/vendor

WORKDIR /var/www/app

COPY . .

RUN chown -R www-data:www-data storage/ bootstrap/ public/ vendor/

RUN apk add shadow && usermod -u 1000 www-data && groupmod -g 1000 www-data

USER www-data
