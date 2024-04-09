FROM php:8.2-fpm
WORKDIR /var/www
ADD . /var/www
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    libmagickwand-dev \
    --no-install-recommends \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install gd \
    && docker-php-ext-install zip
RUN apt-get -y install git
RUN chown -R www-data:www-data /var/www
RUN chmod -R 755 /var/www/storage
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
