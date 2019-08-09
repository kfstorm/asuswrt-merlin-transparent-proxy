#!/bin/sh

/opt/etc/clean_iptables_rule.sh

echo '[0m[33mApply iptables rule ...[0m'

if iptables -t nat -C PREROUTING -p tcp -j V2RAY 2>/dev/null; then
    exit 0
fi

iptables -t nat -N V2RAY 2>/dev/null

iptables -t nat -A V2RAY -p tcp -m set --match-set CHINAIPS dst -j RETURN
iptables -t nat -A V2RAY -p tcp -m set --match-set CHINAIP dst -j RETURN
iptables -t nat -A V2RAY -p tcp -j REDIRECT --to-ports 1080

iptables -t nat -A PREROUTING -p tcp -j V2RAY

echo '[0m[33mApply iptables rule done.[0m'
