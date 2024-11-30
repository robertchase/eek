#!/usr/bin/env bash
KEY=${KEY:-pass}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export PYTHONPATH="$DIR"

MATCH=$(cat "$EEK_LOCAL" | openssl enc -md md5 -pass env:EPASS -d -aes-256-cbc -a | grep $*)
if [ -z "$MATCH" ]; then
    echo 'no match'
    exit
fi

COUNT=$(echo "$MATCH" | wc -l)
if [ $COUNT -gt 1 ]; then
    echo "$MATCH" | python3 -m tokenize | awk '{printf "[%s] %s\n", NR, $0}'
    read -r line

    if [ -z "$line" ]; then
        echo 'no choice'
        exit
    elif [ $line -gt $COUNT ]; then
        echo 'no line matched'
        exit
    fi

    MATCH=$(echo "$MATCH" | head -$line | tail -1)
fi

args=$(echo "$MATCH" | python3 -m tokenize)
value=$(echo "$MATCH" | python3 -m tokenize -k $KEY | tr -d '\n')
if [ -z "$value" ]; then
    echo "no '$KEY' found for '$args'"
    exit
fi

echo "$MATCH" | python3 -m tokenize -k $KEY | tr -d '\n' | pbcopy
echo "copied '$KEY' to clipboard for '$args'"
