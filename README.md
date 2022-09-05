参考：https://github.com/munkyboy/docker-redsocks 项目    
使用方式：
socks5:    docker run  -itd  --net=host  -e type=socks5  -e ip=192.168.11.1 -e port=8888   --name=redsocks  redsocks
socks4:    docker run  -itd  --net=host  -e type=socks5  -e ip=192.168.11.1 -e port=8888   --name=redsocks  redsocks
http:      docker run  -itd  --net=host  -e type=http-relay  -e ip=192.168.11.1 -e port=8888   --name=redsocks  redsocks
https:     docker run  -itd  --net=host  -e type=http-connect  -e ip=192.168.11.1 -e port=8888   --name=redsocks  redsocks
