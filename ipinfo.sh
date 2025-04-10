#!/bin/bash
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
BLUE=$(tput setaf 4)
STAND=$(tput sgr 0)
BOLD=$(tput bold)


echo -e "
   ╻   ┏━┓   ╻   ┏┓╻   ┏━╸   ┏━┓
   ┃   ┣━┛   ┃   ┃┗┫   ┣╸    ┃ ┃
   ╹   ╹     ╹   ╹ ╹   ╹     ┗━┛ " | lolcat -p 0.7
echo -e "                       by-$BOLD rouze$STAND"
echo -e "$BLUE IP / Website information$STAND"
echo -e " Hope you found something. Have a nice day."

echo ""



sub="$1"
web="$2"

if [ -z $sub ]; then
    echo " -m my ip"
    echo " -t website"
    echo "exp:"
    echo "$0 -m"
    echo "$0 -t www.example.com"
    exit
fi


if [ $sub == "-m" ];then
    publice=`timeout 10 curl -s checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'`
    echo ""
    echo " your ip :" $publice
    echo ""
    #infoip=`timeout 10 curl -s "http://api.ipinfodb.com/v3/ip-city/?key=1fa9974bd83bf097abf947ee11f9ed697fb3f108db13dfe9d7a48b63a7d197b0&format=json&ip=$publice"`
    #echo $infoip | tr -d '"{}' | tr ',' '\n'
    curl -sk curl -sk https://ipinfo.io/${publice} | grep ':' | tr -d '",' | head -n 8
    echo ""
    whois $publice | grep -E "address:|mnt-by:|country:|created:|last-modified:|inetnum:|netname:|descr:"
    echo ""
    name=`hostname`
    echo "Nice to meet you "$name ". Good Luck."
    exit
fi


if [ $sub == "-t" ];then
    if [ -z $web ]; then
        echo "website is blank. input website"
        echo "$0 -t www.example.com"
        exit
    fi
    echo ""
    publice=`timeout 20 ping $web -c 1 | head -n1 | cut -d '(' -f2 | cut -d ')' -f1`
    server=`timeout 10 curl -sk -I https://${web} | grep Server | cut -d ':' -f2`
    echo -e " website : $web"
    echo -e " ip      : $publice"
    echo -e " server  :$server"
    echo ""
    #infoip=`timeout 20 curl -s "http://api.ipinfodb.com/v3/ip-city/?key=1fa9974bd83bf097abf947ee11f9ed697fb3f108db13dfe9d7a48b63a7d197b0&format=json&ip=$publice"`
    #echo $infoip | tr -d '"{}' | tr ',' '\n'
    curl -sk curl -sk https://ipinfo.io/${publice} | grep ':' | tr -d '",' | head -n 9
    echo ""
    timeout 20 whois $publice -a | grep -E "address:|mnt-by:|country:|created:|last-modified:|inetnum:|netname:|descr:"
    echo ""
    name=`hostname`
    echo "Nice to meet you "$name ". Good Luck."
    exit
fi
