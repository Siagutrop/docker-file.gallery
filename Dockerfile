#On choisit une debian
FROM debian:12.5

# Configurer l'encodage UTF-8 dans le conteneur
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

LABEL org.opencontainers.image.authors="raphael.martins.correia41@gmail.com"


#Ne pas poser de question à l'installation
ENV DEBIAN_FRONTEND noninteractive

#Installation d'apache et de php8.3 avec extension
RUN apt update \
&& apt install --yes ca-certificates apt-transport-https lsb-release wget curl \
&& curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg \ 
&& sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list' \
&& apt update \
&& apt install --yes --no-install-recommends \
nano \
apache2 \
php8.3 \
php8.3-mysql \
php8.3-ldap \
php8.3-xmlrpc \
php8.3-imap \
php8.3-curl \
php8.3-gd \
php8.3-mbstring \
php8.3-xml \
php-cas \
php8.3-intl \
php8.3-zip \
php8.3-bz2 \
php8.3-redis \
ffmpeg \
cron \
jq \
libldap-2.5-0 \
libldap-common \
libsasl2-2 \
libsasl2-modules \
libsasl2-modules-db \
&& rm -rf /var/lib/apt/lists/*

#Copie et execution du script pour l'installation et l'initialisation de GLPI
COPY file-start.sh /opt/
RUN chmod +x /opt/file-start.sh
ENTRYPOINT ["/opt/file-start.sh"]

#Exposition des ports
EXPOSE 80
