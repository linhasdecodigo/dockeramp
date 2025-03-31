#!/bin/sh

# Chamar o script de entrada padrão da imagem base
# O script '/usr/local/bin/docker-php-entrypoint' é o padrão da imagem php:8.4-apache
/usr/local/bin/docker-php-entrypoint

APACHE_SOURCE="/tmp/apache"
APACHE_DEST="/etc/apache2/sites-available"

PHP_SOURCE="/tmp/php"
PHP_DEST="/usr/local/etc/php/conf.d"

CRONTAB_SOURCE="/tmp/cron"

# Verifica se há arquivos .conf no diretório de origem do Apache
if [ -z "$(ls $APACHE_SOURCE/*.conf 2>/dev/null)" ]; then
  # Nenhum arquivo .conf encontrado no diretório Apache, usando o padrão
  cp /tmp/default/vhost.conf "$APACHE_DEST"/
else
  # Copia arquivos .conf do diretório Apache para sites disponíveis
  cp "$APACHE_SOURCE"/*.conf "$APACHE_DEST"/
fi

# Ativa todos os sites disponíveis
for file in "$APACHE_DEST"/*.conf; do
    a2ensite "$(basename "$file")"
done

# Verifica se há arquivos .ini no diretório de origem do PHP
if [ -z "$(ls $PHP_SOURCE/*.ini 2>/dev/null)" ]; then
  # Nenhum arquivo .ini encontrado, usando configuração padrão
  cp /tmp/default/zzz-php.ini "$PHP_DEST"/
else
  # Copia arquivos .ini para o diretório de configurações adicionais
  cp "$PHP_SOURCE"/*.ini "$PHP_DEST"/
fi

# Verifica se há arquivos .conf no diretório de origem do crontab
if [ -z "$(ls $CRONTAB_SOURCE/*.conf 2>/dev/null)" ]; then
  # Nenhum arquivo .conf encontrado, nenhuma tarefa de cron será configurada
  # O comando : é um no-op (não faz nada) e é útil para casos onde nenhum código precisa ser executado
  :   
else
  # Itera por todos os arquivos .conf encontrados e os importa para o crontab
  for file in "$CRONTAB_SOURCE"/*.conf; do
    crontab "$file"
  done
fi

# Valida a configuração do Apache antes de iniciar
apache2ctl configtest > /dev/null 2>&1 || exit 1

# Executa o Supervisor, substituindo o processo atual do entrypoint.sh pelo gerenciador de serviços supervisord
exec supervisord -c /etc/supervisor/conf.d/supervisord.conf