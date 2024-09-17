#!/bin/bash

# Variable de version PHP et dossier cible
PHP_VERSION="7.4"  # Ou la version de PHP que tu souhaites
FOLDER_WEB=/var/www/html/
APP_NAME="file_gallery"

# URL pour télécharger File Gallery
FILE_GALLERY_URL="https://cdn.jsdelivr.net/npm/files.photo.gallery/index.php"

# Configuration du fuseau horaire
if [[ -z "${TIMEZONE}" ]]; then 
    echo "TIMEZONE is unset"; 
else 
    echo "date.timezone = \"$TIMEZONE\"" > /etc/php/${PHP_VERSION}/apache2/conf.d/timezone.ini;
    echo "date.timezone = \"$TIMEZONE\"" > /etc/php/${PHP_VERSION}/cli/conf.d/timezone.ini;
fi

# Activer session.cookie_httponly
sed -i 's,session.cookie_httponly = *\(on\|off\|true\|false\|0\|1\)\?,session.cookie_httponly = on,gi' /etc/php/${PHP_VERSION}/apache2/php.ini

# Télécharger et installer File Gallery
if [ "$(ls ${FOLDER_WEB}${APP_NAME}/index.php)" ];
then
    echo "File Gallery is already installed"
else
    echo "Downloading File Gallery..."
    mkdir -p ${FOLDER_WEB}${APP_NAME}
    wget -O ${FOLDER_WEB}${APP_NAME}/index.php ${FILE_GALLERY_URL}
    chown -R www-data:www-data ${FOLDER_WEB}${APP_NAME}
fi

# Configurer Apache pour File Gallery
echo -e "<VirtualHost *:80>\n\tDocumentRoot /var/www/html/${APP_NAME}\n\n\t<Directory /var/www/html/${APP_NAME}>\n\t\tAllowOverride All\n\t\tRequire all granted\n\t</Directory>\n\n\tErrorLog /var/log/apache2/error-${APP_NAME}.log\n\tLogLevel warn\n\tCustomLog /var/log/apache2/access-${APP_NAME}.log combined\n</VirtualHost>" > /etc/apache2/sites-available/000-default.conf

# Activer le module rewrite d'Apache et redémarrer le service
a2enmod rewrite
service apache2 restart

# Démarrer Apache au premier plan
/usr/sbin/apache2ctl -D FOREGROUND
