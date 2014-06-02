#!/bin/bash

set -e -x -u

cd /tmp/src

groupadd -g 600 flapjack
useradd -g flapjack -u 600 -r flapjack

mkdir -p /etc/flapjack /var/{run,log,lib}/flapjack

mv launch-flapjack.sh /usr/local/bin/
mv program-flapjack.conf /etc/supervisor.d/
mv collectd-flapjack.conf /etc/collectd.d/flapjack.conf
mv logstash-forwarder-flapjack.json /etc/logstash-forwarder.d/flapjack.json
mv flapjack_config.yaml.erb /etc/flapjack/
mv flapjack.logrotate /etc/logrotate.d/flapjack

chown -R flapjack:flapjack /etc/flapjack /var/{run,log,lib}/flapjack

## openssl-devel required for eventmachine to build with encryption support
yum install -y centos-release-SCL openssl-devel gcc-c++ patch collectd-curl_json
yum install --disablerepo=* --enablerepo=scl -y ruby193-ruby-devel

yum localinstall -y http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm
yum install -y nginx

mv nginx.conf /etc/nginx/
mv program-nginx.conf /etc/supervisor.d/

## gotta be a better way
export LD_LIBRARY_PATH="$( scl enable ruby193 'echo ${LD_LIBRARY_PATH}' )"
export PATH="$( scl enable ruby193 'echo ${PATH}' )"
export PKG_CONFIG_PATH="$( scl enable ruby193 'echo ${PKG_CONFIG_PATH}' )"

gem install --no-rdoc --no-ri flapjack --version 0.9.0

## cleanup
cd /
yum clean all
rm -rf /var/tmp/yum-root* /tmp/src
