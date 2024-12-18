#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export PYTHONPATH=$DIR

MATCH=$(cat "$EEK_LOCAL" | openssl enc -md md5 -pass env:EPASS -d -aes-256-cbc -a | grep $*)
if [ -z "$MATCH" ]; then
    echo 'no match'
    exit
fi
echo "$MATCH" | while read -r line
do
    echo $line | python3 -m tokenize
done
