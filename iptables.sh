#!/bin/sh
ips=("100.110.17.166"  "59.36.221.219")
ports=("8888" "5001")
ip=${ips[$1]}
port=${ports[$1]}
echo "当前选择服务器"$ip",端口"$port
echo "正在检测服务器状态"
docker stop redsocks 2>/dev/null
docker rm redsocks 2>/dev/null
docker run  -itd  --net=host  -e type=socks5  -e ip=$ip -e port=$port   --name=redsocks  edgecode-docker.pkg.coding.net/router/public/redsocks:V1.0
iptables -F -t nat
iptables -t nat -A OUTPUT -d $ip  -p tcp -j   RETURN

iptables -t nat -A OUTPUT 100.12.0.0/16 -p tcp -j REDIRECT --to-ports 12345 
iptables -t nat -A OUTPUT 100.80.0.0/16 -p tcp -j REDIRECT --to-ports 12345
iptables -t nat -A OUTPUT 100.81.0.0/16 -p tcp -j REDIRECT --to-ports 12345
iptables -t nat -A OUTPUT 100.82.0.0/16 -p tcp -j REDIRECT --to-ports 12345
iptables -t nat -A OUTPUT 100.86.0.0/16 -p tcp -j REDIRECT --to-ports 12345
iptables -t nat -A OUTPUT 100.88.0.0/16 -p tcp -j REDIRECT --to-ports 12345

iptables -t nat -A OUTPUT 10.116.0.0/16 -p tcp -j REDIRECT --to-ports 12345
iptables -t nat -A OUTPUT 10.119.0.0/16 -p tcp -j REDIRECT --to-ports 12345
iptables -t nat -A OUTPUT 10.216.0.0/16 -p tcp -j REDIRECT --to-ports 12345
iptables -t nat -A OUTPUT 10.218.0.0/16 -p tcp -j REDIRECT --to-ports 12345
iptables -t nat -A OUTPUT 10.240.0.0/16 -p tcp -j REDIRECT --to-ports 12345
iptables -t nat -A OUTPUT 10.246.0.0/16 -p tcp -j REDIRECT --to-ports 12345




