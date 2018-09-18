#!/bin/bash

if ! whoami &> /dev/null; then
  if [ -w /etc/passwd ]; then
    echo "${USER_NAME:-apache}:x:$(id -u):0:${USER_NAME:-apache} user:/home/apache:/sbin/nologin" >> /etc/passwd
  fi
fi

openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout /etc/pki/tls/private/server.key -out /etc/pki/tls/certs/server.crt -subj "/C=GB/ST=London/L=London/O=Global Security/OU=IT Department/CN=$HOSTNAME"

/usr/local/bin/setenv.sh /etc/httpd/conf.d/servername.conf

apachectl

tail -f /dev/null
