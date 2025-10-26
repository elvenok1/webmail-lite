# Usa una imagen oficial de PHP con el servidor web Apache
FROM php:8.1-apache

# PASO 1: Instala las herramientas del sistema operativo que necesitan las extensiones de PHP
# zlib, libpng, libjpeg, libfreetype son para la extensión 'gd' (imágenes)
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zlib1g-dev \
 && rm -rf /var/lib/apt/lists/*

# PASO 2: Ahora sí, instala las extensiones de PHP (mysqli y gd)
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install -j$(nproc) gd mysqli

# PASO 3: Copia todo el código de la aplicación al directorio del servidor web
COPY . /var/www/html/

# PASO 4: Da permisos a Apache para que pueda escribir en la carpeta de datos
RUN chown -R www-data:www-data /var/www/html/data

# Expone el puerto 80 para que el mundo exterior pueda acceder a la aplicación
EXPOSE 80
