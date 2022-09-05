#!/bin/sh
ips=("127.0.0.1"   "59.36.22.22")
ports=("8888" "8888")
ip=${ips[$1]}
port=${ports[$1]}
echo "当前选择服务器"$ip",端口"$port
docker stop redsocks 2>/dev/null
docker rm redsocks 2>/dev/null
docker run  -itd  --net=host  -e type=socks5  -e ip=$ip -e port=$port   --name=redsocks  redsocks
iptables -F -t nat
iptables -t nat -A OUTPUT -d $ip  -p tcp -j   RETURN
iptables -t nat -A OUTPUT -d 10.203.0.0/16 -p tcp -j REDIRECT --to-ports 12345
iptables -t nat -A OUTPUT -d 10.202.0.0/16 -p tcp -j REDIRECT --to-ports 12345
iptables -t nat -A OUTPUT -d 10.207.0.0/16 -p tcp -j REDIRECT --to-ports 12345
