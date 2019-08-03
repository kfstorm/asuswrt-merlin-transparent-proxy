#!/bin/sh

echo '[0m[33mClean iptables rule ...[0m'

while iptables -t nat -C PREROUTING -p tcp -j V2RAY 2>/dev/null; do
    iptables -t nat -D PREROUTING -p tcp -j V2RAY
done

iptables -t nat -F V2RAY 2>/dev/null          # flush
iptables -t nat -X V2RAY 2>/dev/null          # --delete-chain

echo '[0m[33mClean iptables rule done.[0m'
