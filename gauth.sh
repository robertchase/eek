#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export PYTHONPATH=$DIR

[ ! -z "$ENC_FILE" ] && PFILE="-pass file:$ENC_FILE"

DATA=$(openssl enc -md md5 $PFILE -d -aes-256-cbc -a -in "$GAUTH_LOCAL")

echo "$DATA" | python3 -m totp
read -r line
if [ ! -z $line ]; then
    echo "$DATA" | python3 -m totp --choice $line | tr -d '\n' | pbcopy
    echo "copied to clipboard"
fi
