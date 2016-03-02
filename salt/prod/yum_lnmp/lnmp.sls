include:
  - yum_lnmp.epel_release
  - yum_lnmp.www

lnmp-install:
  pkg.installed:
    - names:
      - mariadb 
      - mariadb-server 
      - nginx 
      - php-fpm
      - php-common
      - php-cli
      - php-pecl-memcache
      - php-pecl-memcached
      - php-gd
      - php-pear
      - php-mcrypt
      - php-mbstring
      - php-mysqlnd
      - php-xml
      - php-bcmath
      - php-pdo
    - require:
      - pkg: repo_release
      - user: www

nginx-conf:
  file.managed:
    - name: /etc/nginx/nginx.conf
    - source: salt://yum_lnmp/files/nginx.conf
    - user: www
    - group: www
    - mode: 644
    - require:
      - pkg: lnmp-install
mysql-data:
  cmd.run:
    - name: mkdir -p /data/mysql/{data,tmp,run,binlog,log,relaylog} && chown -R mysql:mysql /data/mysql/* && mysql_install_db --user=mysql --datadir=/data/mysql/data/
    - unless: test -d /data/mysql/
mysql-conf:
  file.managed:
    - name: /etc/my.cnf
    - source: salt://yum_lnmp/files/my.cnf
    - user: root
    - group: root
    - require:
      - cmd: mysql-data

php-ini:
  file.managed:
    - name: /etc/php.ini
    - source: salt://yum_lnmp/files/php.ini
    - user: root
    - group: root
    - require:
      - pkg: lnmp-install

php-fpm:
  file.managed:
    - name: /etc/php-fpm.conf
    - source: salt://yum_lnmp/files/php-fpm.conf
    - user: root
    - group: root
    - require:
      - file: php-ini

/etc/php-fpm.d/www.conf:
  file.managed:
    - source: salt://yum_lnmp/files/php-fpm_www.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: php-fpm

/etc/nginx/conf.d/default.conf:
  file.managed:
    - source: salt://yum_lnmp/files/nginx_default.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: nginx-conf

/var/log/nginx:
  cmd.run:
    - name: mkdir -p /var/log/nginx
    - unless: test -d /var/log/nginx
    - require:
      - pkg: lnmp-install
