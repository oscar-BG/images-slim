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

# Establecer el directorio de trabajo
WORKDIR /var/www/html/app

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copiar el archivo de configuración de Composer y realizar la instalación
COPY composer.json /var/www/html/app
RUN composer install --no-scripts --no-autoloader


# Copiar el resto de tu aplicación
COPY . /var/www/html/app/


# Ejecutar los scripts de Composer y ajustar los permisos
RUN composer dump-autoload --optimize
RUN chown -R www-data:www-data /var/www/html

# Exponer el puerto 80
EXPOSE 80

# Iniciar Nginx y PHP-FPM
CMD nginx && php-fpm