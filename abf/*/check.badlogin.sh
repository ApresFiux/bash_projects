#!/bin/bash


#Anti-DDOS for Centos Made By Kirill Kamaldinov


#check ? times
bcan=/scripts/check.badlogin
mail=headhood20@gmail.com
howman=$(cat /var/log/secure | grep Failed | sort | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' |sort | uniq -c | sort -n |tail -1 | awk '{print $1}')
whois=$(cat /var/log/secure | grep Failed | sort | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' |sort | uniq -c | sort -n |tail -1 | awk '{print $2}')

if [[ $howman -gt 7 ]]; then
		if [ ! -f $bcan/whoisip.art ]; then
			touch $bcan/whoisip.art
		fi
   		wrz=$(cat $bcan/whoisip.art)
			if [[ $whois != $wrz ]]; then
			curl -s ipinfo.com/"$whois"/region > $bcan/gregion.art
				if [ ! -f $bcan/gregion.art ]; then
				touch $bcan/gregion.art
				fi
				if [ ! -f $bcan/gcountry.art ]; then
				touch $bcan/gcountry.art
				fi
			sleep 0.5
			curl -s ipinfo.com/"$whois"/country > $bcan/gcountry.art
			sleep 0.5
			gregion=$(cat $bcan/gregion.art)
			gcountry=$(cat $bcan/gcountry.art)
			/usr/sbin/iptables -I INPUT -s $whois -j DROP
			echo "--ANTI DDOS-- IP: $whois - $gregion , $gcountry  were blocked after $howman bad logins." | /usr/sbin/sendmail -F ANTI-DDOS $mail
			blog=/var/log
				if [ ! -d $blog/secure.b ]; then
				mkdir $blog/secure.b
				fi  
			cp $blog/secure $blog/secure.b/secure-$(date +%F_%R)
			sdirc=$(ls $blog/secure.b | wc -l)
				if [[ $sdirc -gt 30 ]]; then
					tar -czvf $blog/secure.$(date +%F_%R).tar.gz $blog/secure.b/*
					rm -f $blog/secure.b/*
				fi
			>$blog/secure
			echo $whois > $bcan/whoisip.art
				if [[ ! -f $bcan/bcount.art ]]; then
				touch $bcan/bcount.art
				fi
			bcount=$(cat $bcan/bcount.art)
			expr $bcount + 1 > $bcan/bcount.art

				if [ $bcount -gt 750 ]; then
				iptables -F
				echo "Bcount has reached 750. all IP's were released" | /usr/sbin/sendmail -F Release-Anti-DDOS headhood20@gmail.com
				fi
		fi

else
#			bcount=$(cat $bcan/bcount.art)
#			expr $bcount + 1 > $bcan/bcount.art
 exit 0
fi
