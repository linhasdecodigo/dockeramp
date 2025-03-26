FROM php:8.3-apache

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

# Instala a extensão ZIP e dependências necessárias para manipulação de arquivos compactados
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing \
    libzip-dev \
    && docker-php-ext-install zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Instala as extensões MySQL para manipulação de bancos de dados
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing \
    default-libmysqlclient-dev \
    mariadb-client \
    && docker-php-ext-install pdo_mysql mysqli \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Instala a extensão GD e bibliotecas necessárias para suporte a imagens
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing \
    libpng-dev \
    libjpeg-dev \
    libwebp-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install gd \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Instala a extensão INTL e dependências necessárias para suporte a internacionalização
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing \
    libicu-dev \
    && docker-php-ext-install intl \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Instala a extensão OPCACHE para otimização de desempenho do PHP
RUN docker-php-ext-install opcache

# Instala a extensão CURL e bibliotecas necessárias para manipulação de requisições HTTP
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing \
    libcurl4-openssl-dev \
    && docker-php-ext-install curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Instala a extensão BCMATH, necessária para realizar operações matemáticas de precisão arbitrária, como as usadas em login sem senha com WebAuthn
RUN docker-php-ext-install bcmath

# Instala a extensão EXIF e dependências necessárias para leitura de metadados de imagens, como rotação automática e extração de informações em aplicativos como o Fotos
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing \
    libexif-dev \
    && docker-php-ext-install exif \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Instala a extensão GMP e dependências necessárias para suporte a operações matemáticas avançadas, login sem senha com WebAuthn e criptografia em armazenamento SFTP
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing \
    libgmp-dev \
    && docker-php-ext-install gmp \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Instala a extensão SYSVSEM para suporte a semáforos do sistema para controle de processos
RUN docker-php-ext-install sysvsem

# Instala a extensão SOAP e dependências necessárias para manipulação de serviços web baseados em XML
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing \
    libxml2-dev \
    && docker-php-ext-install soap \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Instala a extensão XML e dependências necessárias para processamento e manipulação de documentos XML
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing \
    libxml2-dev \
    && docker-php-ext-install xml \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Instala a extensão CTYPE, necessária para validação e verificação de tipos de caracteres em strings
RUN docker-php-ext-install ctype

# Instala a extensão ICONV, necessária para conversão de conjuntos de caracteres em strings
RUN docker-php-ext-install iconv

# Instala a extensão MBSTRING e dependências necessárias para suporte a strings multibyte, como aquelas usadas em idiomas com caracteres especiais
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing \
    libonig-dev \
    && docker-php-ext-install mbstring \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Instala a extensão IMAGICK diretamente do repositório Git para manipulação avançada de imagens
# Usando a versão estável marcada como "3.7.0" no repositório oficial
RUN apt-get update \
    && apt-get install -y --no-install-recommends --fix-missing libmagickwand-dev \
    && rm -rf /var/lib/apt/lists/* \
    && cd /usr/local/src \
    && git clone --branch 3.7.0 https://github.com/Imagick/imagick.git \
    && cd imagick \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && cd .. \
    && rm -rf imagick \
    && docker-php-ext-enable imagick \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Instala a extensão POSIX, que fornece funções para interação com o sistema operacional baseadas nos padrões POSIX
RUN docker-php-ext-install posix

# Instala a extensão SESSION, necessária para gerenciamento de sessões em aplicações PHP
RUN docker-php-ext-install session

# Instala a extensão PDO_PGSQL e dependências necessárias para interação com o banco de dados PostgreSQL
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing \
    libpq-dev \
    && docker-php-ext-install pdo_pgsql \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Instala a extensão SODIUM e dependências necessárias para funções modernas de criptografia
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing \
    libsodium-dev \
    && docker-php-ext-install sodium \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Instala a extensão MEMCACHED e dependências necessárias para suporte a caching distribuído
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing \
    libmemcached-dev zlib1g-dev \
    && pecl install memcached \
    && docker-php-ext-enable memcached \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Instala a extensão REDIS, necessária para comunicação com servidores Redis, permitindo caching distribuído e armazenamento em memória
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing \
    libzip-dev \
    && pecl channel-update pecl.php.net \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Instala a extensão PDO_SQLITE e dependências necessárias para trabalhar com bancos de dados SQLite
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing \
    libsqlite3-dev \
    && docker-php-ext-install pdo_sqlite \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Instala a extensão GETTEXT, necessária para internacionalização e localização de aplicações PHP
RUN docker-php-ext-install gettext

# Instala a extensão CALENDAR, que fornece funções relacionadas a operações de calendário
RUN docker-php-ext-install calendar

# Instala a extensão LDAP e dependências necessárias para comunicação com servidores LDAP
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing \
    libldap2-dev \
    && docker-php-ext-install ldap \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Instala a extensão IMAP e dependências necessárias para acesso a caixas de correio usando os protocolos IMAP, POP3 e NNTP
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing \
    libc-client-dev libkrb5-dev \
    && pecl install imap \
    && docker-php-ext-enable imap \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Instala a extensão PCNTL, que fornece funções para o controle de processos PHP
RUN docker-php-ext-install pcntl

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
# O script '/usr/local/bin/docker-php-entrypoint' é o padrão da imagem php:8.3-apache
ENTRYPOINT ["/bin/bash", "-c", "/usr/local/bin/docker-php-entrypoint && /entrypoint.sh"]