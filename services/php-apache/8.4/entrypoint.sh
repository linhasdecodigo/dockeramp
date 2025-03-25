#!/bin/sh

APACHE_SOURCE="/tmp/apache-sites"
APACHE_DEST="/etc/apache2/sites-available"

PHP_SOURCE="/tmp/php-ini"
PHP_DEST="/usr/local/etc/php/conf.d"

# Verifica se há arquivos .conf no diretório de origem do Apache
if [ -z "$(ls $APACHE_SOURCE/*.conf 2>/dev/null)" ]; then
  # Nenhum arquivo .conf encontrado na pasta do Apache, copia o arquivo padrão
  cp /tmp/default/vhost.conf "$APACHE_DEST"/
else
  # Copia apenas arquivos .conf para os sites disponíveis do Apache
  cp "$APACHE_SOURCE"/*.conf "$APACHE_DEST"/
fi

# Ativa todos os arquivos .conf copiados ou de fallback
for file in "$APACHE_DEST"/*.conf; do
    a2ensite "$(basename "$file")"
done

# Verifica se há arquivos .ini no diretório de origem do PHP
if [ -z "$(ls $PHP_SOURCE/*.ini 2>/dev/null)" ]; then
  # Nenhum arquivo .ini encontrado na pasta do PHP, copia o arquivo padrão
  cp /tmp/default/zzz-php.ini "$PHP_DEST"/
else
  # Copia apenas arquivos .ini para a pasta de configurações adicionais do PHP
  cp "$PHP_SOURCE"/*.ini "$PHP_DEST"/
fi

# Comando padrão para iniciar os serviços e manter o container em execução, definido na imagem php:8.4-apache
apache2-foreground