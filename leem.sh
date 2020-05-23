#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export PYTHONPATH=$DIR

MATCH=$(leek $*)
if [ -z "$MATCH" ]; then
    echo 'no match'
    return
fi
echo "$MATCH" | while read -r line
do
    echo "$(python -m tokenize)\n"
done
