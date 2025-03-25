FROM php:8.4-apache

WORKDIR /var/www

# Instala pacotes essenciais
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    zip \
    unzip \
    nano \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Instala o Composer copiando o binário da imagem oficial para o contêiner
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Habilita módulos essenciais do Apache
RUN a2enmod rewrite
RUN a2enmod headers
RUN a2enmod ssl
RUN a2enmod expires

# Desativa e remove sites e configurações padrão do Apache
RUN a2dissite 000-default.conf
RUN rm -rf /etc/apache2/sites-available/*
RUN rm -rf /etc/apache2/sites-enabled/*
RUN rm -rf /var/www/html

# Copia os novos arquivos de configuração padrão do Apache e PHP
COPY vhost.conf /tmp/default/vhost.conf
COPY zzz-php.ini /tmp/default/zzz-php.ini

# Copia o script de entrada e concede permissão de execução
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Executa o script de entrada padrão do PHP e, em seguida, o script personalizado
# O script '/usr/local/bin/docker-php-entrypoint' é o padrão da imagem php:8.4-apache
ENTRYPOINT ["/bin/bash", "-c", "/usr/local/bin/docker-php-entrypoint && /entrypoint.sh"]