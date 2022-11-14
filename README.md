# Wifirst - Les Estudines Rennes

## Why ?
Dumb devices simply cannot connect to the Wifirst network. This is a problem for students who want to use their own devices.
And we don't have a RJ45 port available.
Futhermore, we have to re-login every week, making it tedious when internet suddenly stops working.

## How ?
I had to reverse engineer the Wifirst login process. It was not very hard. In fact, there are not check other than a simple regex on the mail address.

### Usage
Following commands / packages are for OpenWrt. You can find the equivalent for your distribution.

```sh
opkg update
opkg install wget-ssl
wget https://raw.githubusercontent.com/P0SlX/Wifirst-Les-Estudines/main/run.sh -O /root/run.sh
chmod +x /root/run.sh
```

Edit `/etc/config/dhcp` and add the following lines:
**Edit IPs with yours (ping the domain to get them)**
```
config domain
        option name 'www.wifirst.net'
        option ip '<ip>'

config domain
        option name 'portal-front.wifirst.net'
        option ip '<ip>'

config domain
        option name 'portal.wifirst.net'
        option ip '<ip>'

config domain
        option name 'wireless.wifirst.net'
        option ip '<ip>'

config domain
        option name 'selfcare.wifirst.net'
        option ip '<ip>'
```

Restart DHCP:
```sh
/etc/init.d/dnsmasq restart
```

Add crontab entry to run the script every 5 minutes
```sh
crontab -e 
-> */5 * * * * /bin/sh /root/run.sh

/etc/init.d/cron restart
```

Have fun.