#!/bin/bash

yum install git unzip -y;apt install git unzip -y
mkdir -p /www/caddy && cd /www/caddy && wget "https://caddyserver.com/download/linux/386?plugins=http.filemanager&license=personal&telemetry=on" -O caddy.tar.gz && tar -zxvf caddy.tar.gz caddy && chmod +x caddy && rm -rf caddy.tar.gz
wget -P /www/h5ai https://release.larsjung.de/h5ai/h5ai-0.29.0.zip && unzip /www/h5ai/h5ai-0.29.0.zip -d /www/h5ai
chmod +777 /www/h5ai/_h5ai/public/cache/ /www/h5ai/_h5ai/private/cache/
git clone https://github.com/blueimp/jQuery-File-Upload.git "/www/jQuery-File-Upload"
chmod +777 /www/jQuery-File-Upload/server/php/files/
echo ":80 {
#basicauth / username password #网页密码验证,删除注释生效
#tls 你的邮箱地址@mail.com #tls证书自动申请,先解析到ip,然后开头的":80"改为"https://你的域名"删除注释生效
 root /www/h5ai
 timeouts none
 gzip
 filemanager /admin / {
  database /www/caddy/filemanager.db
  locale zh-cn }
 fastcgi / /home/hhvm/sock php
 rewrite {
        if {path} ends_with /
        to {dir}/index.html {dir}/index.php /_h5ai/public/index.php
 }
}
:8080 {
#basicauth / username password #网页密码验证,删除注释生效
 root /www/jQuery-File-Upload/
 timeouts none
 gzip
 fastcgi / /home/hhvm/sock php
}
" > /www/caddy/Caddyfile
useradd hhvm && mkdir -p /www/hhvm /home/hhvm/ && chmod +777 /www/hhvm /home/hhvm/
