include:
  - yum_lnmp.lnmp

nginx-service:
  service.running:
    - name: nginx
    - enable: True
    - reload: True
    - require:
      - file: nginx-conf
mysql-service:
  service.running:
    - name: mariadb
    - enable: True
    - reload: True
    - require:
      - file: mysql-conf
php-service:
  service.running:
    - name: php-fpm
    - enable: True
    - reload: True
    - require:
      - file: php-fpm
index_php:
  file.managed:
    - name: /var/www/html/index.php
    - source: salt://yum_lnmp/files/index.php
    - user: root
    - group: root
    - mode: 644
    - require:
      - service: nginx-service
