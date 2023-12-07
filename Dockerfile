# Establecer la imagen base
FROM php:7.4-fpm

# Instalar las dependencias necesarias
RUN apt-get update && apt-get install -y \
    nginx \
    git \
    unzip \
    libzip-dev

# Instalar las extensiones de PHP
RUN docker-php-ext-install zip

# Copiar la configuración de Nginx
COPY nginx.conf /etc/nginx

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copiar el archivo composer.json
COPY composer.json /var/www/

# Establecer el directorio de trabajo
WORKDIR /var/www

# Instalar las dependencias
RUN composer install --no-scripts --no-autoloader

# Copiar el código de la aplicación
COPY . /var/www

# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Exponer el puerto 80
EXPOSE 80

# Iniciar Nginx y PHP-FPM
CMD nginx && php-fpm