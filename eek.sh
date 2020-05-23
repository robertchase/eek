DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
FILENAME=$(basename "${BASH_SOURCE[0]}")
LINKNAME=$(readlink "$DIR/$FILENAME")  # resolve symlink
DIR=$(dirname "$LINKNAME")

function eek-setup {
    export EPASS=$(openssl enc -nosalt -aes-256-cbc -a -in "$EEK_FILE")
    alias eek='curl -Ls "$EEK_NET" | openssl enc -pass env:EPASS -d -aes-256-cbc -a | grep'
    alias leek='cat "$EEK_LOCAL" | openssl enc -pass env:EPASS -d -aes-256-cbc -a | grep'
    alias leep='source "$DIR"/leep.sh'
    alias leem='source "$DIR"/leem.sh'
    alias akk='openssl enc -pass env:EPASS -aes-256-cbc -a -in'
    export PS1='eek$ '
}
