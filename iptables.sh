#!/bin/sh
ips=("100.110.17.166"  "59.36.221.227")
ports=("8888" "5000")
ip=${ips[$1]}
port=${ports[$1]}
echo "当前选择服务器"$ip",端口"$port
echo "正在检测服务器状态"
Chain_SSR="OUTPUT"
docker stop redsocks 2>&1 >/dev/null
docker rm redsocks 2>&1 >/dev/null
docker run  -itd  --net=host  -e type=socks5  -e ip=$ip -e port=$port   --name=redsocks  edgecode-docker.pkg.coding.net/router/public/redsocks:V1.0

iptables -t nat -F

iptables -t nat -A OUTPUT -d $ip  -p tcp -j   RETURN -m comment --comment 'socks5代理服务器放行'
iptables -t nat -A OUTPUT -d 100.12.0.0/16 -p tcp -j REDIRECT --to-ports 12345 -m comment --comment 'redsocks全局SSR代理'
iptables -t nat -A OUTPUT -d 100.80.0.0/16 -p tcp -j REDIRECT --to-ports 12345 -m comment --comment 'redsocks全局SSR代理'
iptables -t nat -A OUTPUT -d 100.81.0.0/16 -p tcp -j REDIRECT --to-ports 12345 -m comment --comment 'redsocks全局SSR代理'
iptables -t nat -A OUTPUT -d 100.82.0.0/16 -p tcp -j REDIRECT --to-ports 12345 -m comment --comment 'redsocks全局SSR代理'
iptables -t nat -A OUTPUT -d 100.86.0.0/16 -p tcp -j REDIRECT --to-ports 12345 -m comment --comment 'redsocks全局SSR代理'
iptables -t nat -A OUTPUT -d 100.87.0.0/16 -p tcp -j REDIRECT --to-ports 12345 -m comment --comment 'redsocks全局SSR代理'
iptables -t nat -A OUTPUT -d 100.88.0.0/16 -p tcp -j REDIRECT --to-ports 12345 -m comment --comment 'redsocks全局SSR代理'
iptables -t nat -A OUTPUT -d 100.119.0.0/16 -p tcp -j REDIRECT --to-ports 12345 -m comment --comment 'redsocks全局SSR代理'

iptables -t nat -A OUTPUT -d 10.207.0.0/16 -p tcp -j REDIRECT --to-ports 12345 -m comment --comment 'redsocks全局SSR代理'
iptables -t nat -A OUTPUT -d 10.116.0.0/16 -p tcp -j REDIRECT --to-ports 12345 -m comment --comment 'redsocks全局SSR代理'
iptables -t nat -A OUTPUT -d 10.119.0.0/16 -p tcp -j REDIRECT --to-ports 12345 -m comment --comment 'redsocks全局SSR代理'
iptables -t nat -A OUTPUT -d 10.216.0.0/16 -p tcp -j REDIRECT --to-ports 12345 -m comment --comment 'redsocks全局SSR代理'
iptables -t nat -A OUTPUT -d 10.218.0.0/16 -p tcp -j REDIRECT --to-ports 12345 -m comment --comment 'redsocks全局SSR代理'
iptables -t nat -A OUTPUT -d 10.240.0.0/16 -p tcp -j REDIRECT --to-ports 12345 -m comment --comment 'redsocks全局SSR代理'
iptables -t nat -A OUTPUT -d 10.246.0.0/16 -p tcp -j REDIRECT --to-ports 12345 -m comment --comment 'redsocks全局SSR代理'
iptables -t nat -A OUTPUT -d 10.203.0.0/16 -p tcp -j REDIRECT --to-ports 12345 -m comment --comment 'redsocks全局SSR代理'
