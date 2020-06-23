alias eek-setup="source ${EEK_DIR:-${GIT:-$HOME/git}/eek}/eek.sh"
alias genpass="docker run --rm -it -v=${GIT:-$HOME/git}:/opt/git -w /opt/git/eek base-python python genpass.py"
