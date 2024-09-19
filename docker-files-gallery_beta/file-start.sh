#!/bin/bash

# Variable de version PHP et dossier cible
PHP_VERSION="8.3"
FOLDER_WEB="/var/www/html"
APP_NAME="file_gallery"

# URL pour télécharger File Gallery
FILE_GALLERY_URL="https://cdn.jsdelivr.net/npm/files.photo.gallery/index.php"

# Configuration du fuseau horaire
if [[ -z "${TIMEZONE}" ]]; then 
    echo "TIMEZONE is unset"; 
else 
    echo "date.timezone = \"$TIMEZONE\"" > /usr/local/etc/php/conf.d/timezone.ini;
fi

# Activer session.cookie_httponly
sed -i 's,session.cookie_httponly = *\(on\|off\|true\|false\|0\|1\)\?,session.cookie_httponly = on,gi' /usr/local/etc/php/php.ini

# Télécharger et installer File Gallery si non présent
if [ ! -f "${FOLDER_WEB}/index.php" ]; then
    echo "Downloading File Gallery..."
    wget -O ${FOLDER_WEB}/index.php ${FILE_GALLERY_URL}
    chown -R www-data:www-data ${FOLDER_WEB}
else
    echo "File Gallery is already installed"
fi

# Configurer Apache pour pointer directement vers le dossier file_gallery
echo -e "<VirtualHost *:80>\n\tDocumentRoot /var/www/html\n\n\t<Directory /var/www/html>\n\t\tAllowOverride All\n\t\tRequire all granted\n\t</Directory>\n\n\tErrorLog /var/log/apache2/error.log\n\tLogLevel warn\n\tCustomLog /var/log/apache2/access.log combined\n</VirtualHost>" > /etc/apache2/sites-available/000-default.conf

# Activer le module rewrite (sans redémarrage d'Apache)
a2enmod rewrite

# Démarrer Apache au premier plan
exec apache2-foreground

