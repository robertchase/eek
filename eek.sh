export EPASS=$(openssl enc -md md5 -nosalt -aes-256-cbc -a -in "$EEK_FILE")
alias eek='curl -Ls "$EEK_NET" | openssl enc -pass env:EPASS -d -aes-256-cbc -a | grep'
alias leek='cat "$EEK_LOCAL" | openssl enc -md md5 -pass env:EPASS -d -aes-256-cbc -a | grep'
alias leep='sh "${EEK_DIR:-${GIT:-$HOME/git}/eek}/leep.sh"'
alias leem='sh "${EEK_DIR:-${GIT:-$HOME/git}/eek}/leem.sh"'
alias akk='openssl enc -md md5 -pass env:EPASS -aes-256-cbc -a -in'
alias gauth='sh "${EEK_DIR:-${GIT:-$HOME/git}/eek}/gauth.sh"'
export PS1='eek$ '
