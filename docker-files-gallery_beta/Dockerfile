# Utiliser une image PHP avec Apache
FROM php:8.3-apache

# Configurer l'encodage UTF-8 dans le conteneur
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

LABEL org.opencontainers.image.authors="Siagutrop"

# Installation des dépendances nécessaires
RUN apt-get update && apt-get install -y \
    wget \
    nano \
    ffmpeg \
    unzip \
    && docker-php-ext-install mysqli

# Copier les fichiers de l'application
COPY ./data /var/www/html/

# Changer les permissions
RUN chown -R www-data:www-data /var/www/html/

# Activer les modules Apache nécessaires
RUN a2enmod rewrite

# Copie du script de démarrage
COPY file-start.sh /usr/local/bin/file-start.sh
RUN chmod +x /usr/local/bin/file-start.sh

# Exécuter le script de démarrage
ENTRYPOINT ["/usr/local/bin/file-start.sh"]
