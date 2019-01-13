#!/bin/bash

mkdir -p /www/caddy && cd /www/caddy && wget "https://caddyserver.com/download/linux/amd64?license=personal&telemetry=on" -O caddy.tar.gz && tar -zxvf caddy.tar.gz caddy && chmod +x caddy && rm -rf caddy.tar.gz
echo ":80 {
#basicauth / username password #密码验证,删除注释生效
#tls 你的邮箱地址@mail.com #tls证书自动申请,先解析到ip,然后开头的":80"改为"https://你的域名"删除注释生效
 root /www/caddy #此处改成你要展示的路径
 timeouts none
 gzip
 browse
 filemanager /admin / {
  database /www/caddy/filemanager.db
  locale zh-cn }
}
" > /www/caddy/Caddyfile
nohup /www/caddy/caddy  --conf=/www/caddy/Caddyfile -agree &
