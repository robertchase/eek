#!/usr/bin/env bash
KEY=${KEY:-pass}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export PYTHONPATH="$DIR"

MATCH=$(leek $*)
if [ -z "$MATCH" ]; then
    echo 'no match'
    return
fi

COUNT=$(echo "$MATCH" | wc -l)
if [ $COUNT -gt 1 ]; then
    echo "$MATCH" | python -m tokenize | awk '{printf "[%s] %s\n", NR, $0}'
    read -r line

    if [ -z "$line" ]; then
        echo 'no choice'
        return
    elif [ $line -gt $COUNT ]; then
        echo 'no line matched'
        return
    fi

    MATCH=$(echo "$MATCH" | head -$line | tail -1)
fi

args=$(echo "$MATCH" | python -m tokenize a)
value=$(echo "$MATCH" | python -m tokenize -k $KEY | tr -d '\n')
if [ -z "$value" ]; then
    echo "no '$KEY' found for '$args'"
    return
fi

echo "$MATCH" | python -m tokenize -k $KEY | tr -d '\n' | pbcopy
echo "copied '$KEY' to clipboard for '$args'"
