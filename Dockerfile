# Usa una imagen oficial de PHP con el servidor web Apache
FROM php:8.1-apache

# Instala las extensiones de PHP que AfterLogic necesita
RUN docker-php-ext-install mysqli gd

# Copia todo el código de la aplicación al directorio del servidor web
COPY . /var/www/html/

# Da permisos a Apache para que pueda escribir en la carpeta de datos
RUN chown -R www-data:www-data /var/www/html/data

# Expone el puerto 80 para que el mundo exterior pueda acceder a la aplicación
EXPOSE 80
