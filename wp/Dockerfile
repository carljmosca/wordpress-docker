FROM centos:7.4.1708

RUN yum install epel-release yum-utils -y
RUN yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum-config-manager --enable remi-php72

RUN yum -y install httpd libmcrypt-dev php libapache2-mod-php \
    php-mysql mod_ssl mod_php mod_rewrite openssl wget unzip

RUN cd /tmp && \
    wget -c https://wordpress.org/wordpress-4.9.8.tar.gz && \
    tar -xzvf wordpress-4.9.8.tar.gz && \
    rm wordpress-4.9.8.tar.gz && \
    rm -Rf /var/www/html/* && \
    mv wordpress/* /var/www/html/ 

RUN cd /tmp && \
    wget https://downloads.wordpress.org/plugin/wordpress-social-login.zip && \
    unzip wordpress-social-login.zip && \
    rm wordpress-social-login.zip && \
    mv wordpress-social-login /var/www/html/wp-content/plugins/

COPY image/wp-config.php /var/www/html/    

RUN chmod g=u /etc/passwd && \
    usermod -l apache1 apache

COPY image/servername.conf /etc/httpd/conf.d/

RUN chown -R 1001:0 /var/log && \
    chown -R 1001:0 /var/www && \
    chown -R 1001:0 /etc/httpd && \
    chown -R 1001:0 /etc/pki && \
    mkdir -p /var/run/httpd && \
    chown -R 1001:0 /var/run/httpd && \
    chown -R 1001:0 /var/lib/php && \
    mkdir -p /var/lock/httpd && \
    chown -R 1001:0 /var/lock/httpd && \
    chown -R 1001:0 /tmp

RUN chmod -R 775 /var/log && \
    chmod -R 775 /var/lib/php && \
    chmod -R 775 /var/www && \
    chmod -R 775 /etc/httpd && \
    chmod -R 775 /etc/pki && \
    chmod -R 775 /var/run/httpd && \
    chmod -R 775 /var/lock/httpd

RUN sed -i 's/Listen 80/Listen 8080/g' /etc/httpd/conf/httpd.conf && \
    sed -i 's/443/8443/g' /etc/httpd/conf.d/ssl.conf && \
    sed -i "s|SSLCertificateFile /etc/pki/tls/certs/localhost.crt|SSLCertificateFile /etc/pki/tls/certs/server.crt|g" /etc/httpd/conf.d/ssl.conf && \
    sed -i "s|SSLCertificateKeyFile /etc/pki/tls/private/localhost.key|SSLCertificateKeyFile /etc/pki/tls/private/server.key|g" /etc/httpd/conf.d/ssl.conf

COPY image/fix-permissions.sh /usr/bin/

COPY image/*.sh /usr/local/bin/
RUN chmod 555 /usr/local/bin/*

RUN /usr/bin/fix-permissions.sh /var/www && \
    /usr/bin/fix-permissions.sh /var/lock/httpd && \
    /usr/bin/fix-permissions.sh /var/run/httpd

EXPOSE 8080
EXPOSE 8443

ENTRYPOINT [ "/usr/local/bin/startup.sh" ]

USER 1001
