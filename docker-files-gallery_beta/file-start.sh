#!/bin/bash

# Variables de version PHP et dossier cible
PHP_VERSION="8.3"
FOLDER_WEB="/var/www/html"
APP_NAME="file_gallery"
CONFIG_FILE="${FOLDER_WEB}/${APP_NAME}/_files/config/config.php"
FILE_GALLERY_URL="https://cdn.jsdelivr.net/npm/files.photo.gallery/index.php"

# Créer les dossiers nécessaires
mkdir -p ${FOLDER_WEB}/${APP_NAME}/data
mkdir -p ${FOLDER_WEB}/${APP_NAME}/_files/config

# Configuration du fuseau horaire
if [[ -z "${TIMEZONE}" ]]; then 
    echo "TIMEZONE is unset"; 
else 
    echo "date.timezone = \"$TIMEZONE\"" > /etc/php/${PHP_VERSION}/apache2/conf.d/timezone.ini
    echo "date.timezone = \"$TIMEZONE\"" > /etc/php/${PHP_VERSION}/cli/conf.d/timezone.ini
fi

# Activer session.cookie_httponly
sed -i 's,session.cookie_httponly = *\(on\|off\|true\|false\|0\|1\)\?,session.cookie_httponly = on,gi' /etc/php/${PHP_VERSION}/apache2/php.ini

# Télécharger et installer File Gallery si non présent
if [ ! -f "${FOLDER_WEB}/${APP_NAME}/index.php" ]; then
    echo "Downloading File Gallery..."
    mkdir -p ${FOLDER_WEB}/${APP_NAME}
    wget -O ${FOLDER_WEB}/${APP_NAME}/index.php ${FILE_GALLERY_URL}
    chown -R www-data:www-data ${FOLDER_WEB}/${APP_NAME}
else
    echo "File Gallery is already installed"
fi

# Fonction pour ajouter les `//` si la variable n'existe pas
function get_config_line() {
    local var_name=$1
    local default_value=$2
    local env_value=$(printenv $var_name)

    if [ -z "$env_value" ]; then
        echo "//'$var_name' => $default_value,"
    else
        echo "'$var_name' => $env_value,"
    fi
}

# Créer le fichier config.php avec toutes les options disponibles
cat <<EOF > ${CONFIG_FILE}
<?php
return array(
    $(get_config_line 'ROOT' "''")
    $(get_config_line 'START_PATH' "false")
    $(get_config_line 'USERNAME' "'admin-mariage'")
    $(get_config_line 'PASSWORD' "'\$2y\$10\$.yrPj6HCAMcykGGKxmmAv.ZJNMnj/MYImc/eMRUXvqpCJjBtEBFxG'")
    $(get_config_line 'LOAD_IMAGES' "true")
    $(get_config_line 'LOAD_FILES_PROXY_PHP' "false")
    $(get_config_line 'LOAD_IMAGES_MAX_FILESIZE' "9999999999")
    $(get_config_line 'IMAGE_RESIZE_ENABLED' "true")
    $(get_config_line 'IMAGE_RESIZE_CACHE' "true")
    $(get_config_line 'IMAGE_RESIZE_DIMENSIONS' "320")
    $(get_config_line 'IMAGE_RESIZE_DIMENSIONS_RETINA' "480")
    $(get_config_line 'IMAGE_RESIZE_DIMENSIONS_ALLOWED' "''")
    $(get_config_line 'IMAGE_RESIZE_TYPES' "'jpeg, png, gif, webp, bmp'")
    $(get_config_line 'IMAGE_RESIZE_QUALITY' "85")
    $(get_config_line 'IMAGE_RESIZE_FUNCTION' "'imagecopyresampled'")
    $(get_config_line 'IMAGE_RESIZE_SHARPEN' "true")
    $(get_config_line 'IMAGE_RESIZE_MEMORY_LIMIT' "128")
    $(get_config_line 'IMAGE_RESIZE_MAX_PIXELS' "30000000")
    $(get_config_line 'IMAGE_RESIZE_MIN_RATIO' "1.5")
    $(get_config_line 'IMAGE_RESIZE_CACHE_DIRECT' "false")
    $(get_config_line 'FOLDER_PREVIEW_IMAGE' "true")
    $(get_config_line 'FOLDER_PREVIEW_DEFAULT' "'_filespreview.jpg'")
    $(get_config_line 'MENU_ENABLED' "true")
    $(get_config_line 'MENU_SHOW' "true")
    $(get_config_line 'MENU_MAX_DEPTH' "5")
    $(get_config_line 'MENU_SORT' "'name_asc'")
    $(get_config_line 'MENU_CACHE_VALIDATE' "true")
    $(get_config_line 'MENU_LOAD_ALL' "true")
    $(get_config_line 'MENU_RECURSIVE_SYMLINKS' "true")
    $(get_config_line 'LAYOUT' "'rows'")
    $(get_config_line 'SORT' "'name_asc'")
    $(get_config_line 'SORT_DIRS_FIRST' "true")
    $(get_config_line 'SORT_FUNCTION' "'locale'")
    $(get_config_line 'CACHE' "true")
    $(get_config_line 'CACHE_KEY' "0")
    $(get_config_line 'STORAGE_PATH' "'_files'")
    $(get_config_line 'FILES_EXCLUDE' "''")
    $(get_config_line 'DIRS_EXCLUDE' "''")
    $(get_config_line 'ALLOW_SYMLINKS' "true")
    $(get_config_line 'TITLE' "'%name% [%count%]'")
    $(get_config_line 'HISTORY' "true")
    $(get_config_line 'TRANSITIONS' "true")
    $(get_config_line 'CLICK' "'popup'")
    $(get_config_line 'CLICK_WINDOW' "''")
    $(get_config_line 'CLICK_WINDOW_POPUP' "true")
    $(get_config_line 'CODE_MAX_LOAD' "99999999")
    $(get_config_line 'TOPBAR_STICKY' "'scroll'")
    $(get_config_line 'CHECK_UPDATES' "false")
    $(get_config_line 'ALLOW_TASKS' "false")
    $(get_config_line 'GET_MIME_TYPE' "true")
    $(get_config_line 'CONTEXT_MENU' "true")
    $(get_config_line 'PREVENT_RIGHT_CLICK' "false")
    $(get_config_line 'LICENSE_KEY' "'F1-56Z3-4059-K7Q5-60J3-L4RD-TA3V'")
    $(get_config_line 'FILTER_LIVE' "true")
    $(get_config_line 'FILTER_PROPS' "'name, filetype, mime, features, title'")
    $(get_config_line 'DOWNLOAD_DIR' "'zip'")
    $(get_config_line 'DOWNLOAD_DIR_CACHE' "'dir'")
    $(get_config_line 'ALLOW_UPLOAD' "true")
    $(get_config_line 'ALLOW_DELETE' "true")
    $(get_config_line 'ALLOW_RENAME' "true")
    $(get_config_line 'ALLOW_NEW_FOLDER' "true")
    $(get_config_line 'ALLOW_NEW_FILE' "true")
    $(get_config_line 'ALLOW_DUPLICATE' "true")
    $(get_config_line 'ALLOW_TEXT_EDIT' "true")
    $(get_config_line 'DEMO_MODE' "false")
    $(get_config_line 'UPLOAD_ALLOWED_FILE_TYPES' "''")
    $(get_config_line 'UPLOAD_MAX_FILESIZE' "9999999999")
    $(get_config_line 'UPLOAD_EXISTS' "'increment'")
    $(get_config_line 'POPUP_VIDEO' "true")
    $(get_config_line 'VIDEO_THUMBS' "true")
    $(get_config_line 'VIDEO_FFMPEG_PATH' "'ffmpeg'")
    $(get_config_line 'VIDEO_AUTOPLAY' "true")
    $(get_config_line 'LANG_DEFAULT' "'en'")
    $(get_config_line 'LANG_AUTO' "true")
);
?>
EOF

# Définir ServerName pour éviter l'avertissement
echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Configurer Apache pour pointer directement vers le dossier file_gallery
echo -e "<VirtualHost *:80>\n\tDocumentRoot ${FOLDER_WEB}/${APP_NAME}\n\n\t<Directory ${FOLDER_WEB}/${APP_NAME}>\n\t\tAllowOverride All\n\t\tRequire all granted\n\t</Directory>\n\n\tErrorLog /var/log/apache2/error-${APP_NAME}.log\n\tLogLevel warn\n\tCustomLog /var/log/apache2/access-${APP_NAME}.log combined\n</VirtualHost>" > /etc/apache2/sites-available/000-default.conf

# Activer le module rewrite et démarrer Apache
a2enmod rewrite
exec /usr/sbin/apache2ctl -D FOREGROUND
