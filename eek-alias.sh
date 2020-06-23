alias eek-setup="source ${EEK_DIR:-${GIT:-$HOME/git}/eek}/eek.sh"
alias genpass="docker run --rm -it -v=${EEK_DIR:-${GIT:-$HOME/git}/eek}:/opt/eek -w /opt/eek base-python python genpass.py"
