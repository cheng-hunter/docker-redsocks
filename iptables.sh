#!/bin/sh
ips=("100.110.17.166"  "59.36.221.227")
ports=("8888" "5000")
ip=${ips[$1]}
port=${ports[$1]}
echo "当前选择服务器"$ip",端口"$port
Chain_SSR="OUTPUT"
docker stop redsocks 2>&1 >/dev/null
docker rm redsocks 2>&1 >/dev/null
docker run  -itd  --net=host  -e type=socks5  -e ip=$ip -e port=$port   --name=redsocks  edgecode-docker.pkg.coding.net/router/public/redsocks:V1.0
iptables -t nat -F	
iptables -t nat -A OUTPUT -d $ip  -p tcp -j   RETURN -m comment --comment 'socks5代理服务器放行'
if [ $1 -eq 0 ] ; then
	echo "正在重置网卡"	
	ifconfig enp2s0 down
	ifconfig enp2s0 hw ether "10:62:e5:06:97:b1"
	ifconfig enp2s0 up
	iptables -t nat -A OUTPUT  -p tcp -j REDIRECT --to-ports 12345 -m comment --comment 'redsocks全局SSR代理'
else
	iptables -t nat -A OUTPUT -d 100.12.0.0/16 -p tcp -j REDIRECT --to-ports 12345 -m comment --comment 'redsocks全局SSR代理'
	iptables -t nat -A OUTPUT -d 100.80.0.0/16 -p tcp -j REDIRECT --to-ports 12345 -m comment --comment 'redsocks全局SSR代理'
	iptables -t nat -A OUTPUT -d 100.81.0.0/16 -p tcp -j REDIRECT --to-ports 12345 -m comment --comment 'redsocks全局SSR代理'
	iptables -t nat -A OUTPUT -d 100.82.0.0/16 -p tcp -j REDIRECT --to-ports 12345 -m comment --comment 'redsocks全局SSR代理'
	iptables -t nat -A OUTPUT -d 100.86.0.0/16 -p tcp -j REDIRECT --to-ports 12345 -m comment --comment 'redsocks全局SSR代理'
	iptables -t nat -A OUTPUT -d 100.87.0.0/16 -p tcp -j REDIRECT --to-ports 12345 -m comment --comment 'redsocks全局SSR代理'
	iptables -t nat -A OUTPUT -d 100.88.0.0/16 -p tcp -j REDIRECT --to-ports 12345 -m comment --comment 'redsocks全局SSR代理'
	iptables -t nat -A OUTPUT -d 100.110.0.0/16 -p tcp -j REDIRECT --to-ports 12345 -m comment --comment 'redsocks全局SSR代理'
	iptables -t nat -A OUTPUT -d 100.119.0.0/16 -p tcp -j REDIRECT --to-ports 12345 -m comment --comment 'redsocks全局SSR代理'

	iptables -t nat -A OUTPUT -d 10.0.0.0/8 -p tcp -j REDIRECT --to-ports 12345 -m comment --comment 'redsocks全局SSR代理'
fi	
