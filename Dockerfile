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

# Establecer el directorio de trabajo
WORKDIR /var/www

# Crear el directorio para el proyecto
RUN mkdir /var/www/my-project

# Cambiar al directorio del proyecto
WORKDIR /var/www/my-project

# Crear una nueva aplicación Slim
RUN composer create-project slim/slim-skeleton .

# Exponer el puerto 80
EXPOSE 80

# Iniciar Nginx y PHP-FPM
CMD nginx && php-fpm