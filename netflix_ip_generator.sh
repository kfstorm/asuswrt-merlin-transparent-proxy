#!/bin/bash
# Gather Netflix and Amazon AWS IP ranges and put them into single file

set -ex
if [ -e router/opt/etc/getflix.txt ] ; then rm router/opt/etc/getflix.txt ; fi
if [ -e getflix.tmp ] ; then rm getflix.tmp ; fi
if [ -e nflix.zip ] ; then rm nflix.zip ; fi
# This command finds the ASNUMs owned by netflix
curl -s https://geolite.maxmind.com/download/geoip/database/GeoLite2-ASN-CSV.zip >nflix.zip
for as in $(unzip -p nflix.zip `unzip -l nflix.zip |grep -e GeoLite2-ASN-Blocks-IPv4.csv | sed 's/^.\{30\}//g'` | grep -i netflix | cut -d"," -f2 | sort -u)
    do
    whois -h whois.radb.net -- '-i origin AS'$as | grep -Eo "([0-9.]+){4}/[0-9]+" | tee netflix_ranges.txt >> getflix.tmp
done

# Get the Amazon AWS ip range list
curl -s https://ip-ranges.amazonaws.com/ip-ranges.json |grep ip_prefix |cut -d"\"" -f4 >> getflix.tmp

# unify both the IP address ranges
cat getflix.tmp | sort -u > router/opt/etc/getflix.txt
#tidy the tempfiles
rm nflix.zip
rm getflix.tmp
rm netflix_ranges.txt
