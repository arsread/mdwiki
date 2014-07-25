#Set up Ubuntu 14.04 Server

##Netwoks
1. Config /etc/network/interface.  
   Here's a [sample file](files/conf/interface).
2. Start up wlan0:
```bash
sudo ifup wlan0
```

##Install vim, zsh, tmux, git  
Refer to the part in my wiki on [set up Ubuntu 12.04](ubuntu12.md#install_git,_vim,_tmux_and_omyzsh).

##Dynamic DNS
I currently use [花生壳](http://hsk.oray.com/) to build up dynamic ddns. Dowload the phddns file and install it:
```bash
./configure
make
```
Then check *src/phddns*. If it works, you can create its startup on boot. For me, my service script is simply:
```bash
#!/bin/sh
# Starts and stops phddns  
case "$1" in
start)
	/opt/phddns/src/phddns > /dev/null &
;;
stop)
;;
esac
```

##VPN
To set up a VPN server, I followed [this documentation](https://help.ubuntu.com/community/L2TPServer).

1. Install xl2tpd openswan ppp:
```bash
sudo apt-get install xl2tpd openswan ppp
```

2. Configure the following files (samples in my case):
  - /etc/ipsec.conf
  ```
config setup
        nat_traversal=yes
        virtual_private=%v4:10.0.0.0/8,%v4:192.168.0.0/16,%v4:172.16.0.0/12,%v4:!10.152.2.0/24
        #contains the networks that are allowed as subnet= for the remote client. In other words, the address ranges that may live behind a NAT router through which a client connects.
        oe=off
        protostack=netkey  
conn L2TP-PSK-NAT
        rightsubnet=vhost:%priv
        also=L2TP-PSK-noNAT  
conn L2TP-PSK-noNAT
        authby=secret
        pfs=no
        auto=add
        keyingtries=3
        rekey=no
        # Apple iOS doesn't send delete notify so we need dead peer detection
        # to detect vanishing clients
        dpddelay=30
        dpdtimeout=120
        dpdaction=clear
        # Set ikelifetime and keylife to same defaults windows has
        ikelifetime=8h
        keylife=1h
        type=transport
        # Replace IP address with your local IP (private, behind NAT IP is okay as well)
        left=192.168.0.7
        # For updated Windows 2000/XP clients,
        # to support old clients as well, use leftprotoport=17/%anyhjjkk
        leftprotoport=17/%any
        right=%any
        rightprotoport=17/%any
        #force all to be nat'ed. because of iOS
        forceencaps=yes
  ```
  - The startup script in /etc/init.d/
  ```bash
case "$1" in
start)
echo "Starting my Ipsec VPN"
iptables  -t nat   -A POSTROUTING -o eth0 -s 10.152.2.0/24 -j MASQUERADE
echo 1 > /proc/sys/net/ipv4/ip_forward
for each in /proc/sys/net/ipv4/conf/*
do
        echo 0 > $each/accept_redirects
        echo 0 > $each/send_redirects
done
/etc/init.d/ipsec start
/etc/init.d/xl2tpd start
;;
stop)
echo "Stopping my Ipsec VPN"
iptables --table nat --flush
echo 0 > /proc/sys/net/ipv4/ip_forward
/etc/init.d/ipsec stop
/etc/init.d/xl2tpd stop
;;
restart)
echo "Restarting my Ipsec VPN"
iptables  -t nat   -A POSTROUTING -o eth0 -s 10.152.2.0/24 -j MASQUERADE
echo 1 > /proc/sys/net/ipv4/ip_forward
for each in /proc/sys/net/ipv4/conf/*
do
        echo 0 > $each/accept_redirects
        echo 0 > $each/send_redirects
done
/etc/init.d/ipsec restart
/etc/init.d/xl2tpd restart  
;;
  *)
 echo "Usage: /etc/init.d/ipsec.vpn  {start|stop|restart}"
 exit 1
  ;;
esac
  ```
  - /etc/ipsec.secret
  ```
   %any: PSK "some key here"
  ```
  - /etc/xl2tpd/xl2tpd.conf
  ```
[global]
ipsec saref = no  
[lns default]
ip range = 10.152.2.2-10.152.2.254
local ip = 10.152.2.1
require chap = yes
refuse pap = yes
require authentication = yes
ppp debug = yes
pppoptfile = /etc/ppp/options.xl2tpd
length bit = yes
  ```
  - /etc/ppp/options.xl2tpd
  ```
refuse-mschap-v2
refuse-mschap
ms-dns 8.8.8.8
ms-dns 8.8.4.4
asyncmap 0
auth
crtscts
idle 1800
mtu 1200
mru 1200
lock
hide-password
local
#debug
name l2tpd
proxyarp
lcp-echo-interval 30
lcp-echo-failure 4
  ```
  - In /etc/ppp/chap-secrets, set the users and passwords:
  ```
user1 l2tpd chooseagoodpassword *
  ```
  - In /etc/sysctl.conf
  ```bash
  net.ipv4.ip_forward=1
  ```       
- Add following lines to run when boot up, using either rc.local or service:
  ```bash
# Disable send redirects
echo 0 > /proc/sys/net/ipv4/conf/all/send_redirects
echo 0 > /proc/sys/net/ipv4/conf/default/send_redirects
echo 0 > /proc/sys/net/ipv4/conf/eth0/send_redirects
echo 0 > /proc/sys/net/ipv4/conf/lo/send_redirects
echo 0 > /proc/sys/net/ipv4/conf/wlan0/send_redirects  
# Disable accept redirects
echo 0 > /proc/sys/net/ipv4/conf/all/accept_redirects
echo 0 > /proc/sys/net/ipv4/conf/default/accept_redirects
echo 0 > /proc/sys/net/ipv4/conf/eth0/accept_redirects
echo 0 > /proc/sys/net/ipv4/conf/lo/accept_redirects
echo 0 > /proc/sys/net/ipv4/conf/wlan0/accept_redirects  
iptables -t nat -A POSTROUTING -j MASQUERADE
iptables -I FORWARD -p tcp --syn -i ppp+ -j TCPMSS --set-mss 1356
  ```

##Nginx, myhomepage, MDWiki, and Octopress
###Nginx
Install it using apt-get
```bash
sudo apt-get install nginx
```
Then config */etc/nginx/sites-enabled/default*, which in my case:
```
server {
        listen 80;  
        root /home/arsread/homepage/;
        index index.html index.htm;  
        location /wiki {
                alias /home/arsread/mdwiki/;
                #index index.html;
        }  
        location /blog {
                root /home/arsread/myblog/public/;
                #index index.html;
        }
        ......
}
```

##Laptop mode
Laptop mode is a tool in Ubuntu allowing lower battery consumption. Install it by:
```bash
sudo add-apt-repository ppa:webupd8team/unstable
sudo apt-get update
sudo apt-get install laptop-mode-tools
```
And remember to enable following options in */etc/laptop-mode/laptop-mode.conf*:
```
ENABLE_LAPTOP_MODE_ON_AC=1
ENABLE_LAPTOP_MODE_ON_BATTERY = 1
```
Then restart the service.

##Rtcwake and crontab
To be completed...
