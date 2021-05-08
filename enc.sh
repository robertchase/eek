#! /bin/sh

if [ $# = 0 ]; then
  echo "usage: `basename "$0"` file..."
else
    if [ ! -z "$ENC_FILE" ]; then
      PFILE="-pass file:$ENC_FILE"
    fi

    for FILE in "$@"
    do
        if [  -d "$FILE" ]; then
          >&2 echo "'$FILE' is a directory; skipping"
          continue
        fi
        if [  ! -f "$FILE" ]; then
          >&2 echo "file '$FILE' does not exist; skipping"
          continue
        fi
        case "$FILE" in
          *.enc)
            openssl enc $PFILE -d -aes-256-cbc -a -in "$FILE" -out "$(basename "$FILE" .enc)"
            ;;
          *)
            openssl enc $PFILE -aes-256-cbc -a -in "$FILE" -out "$FILE.enc"
            ;;
        esac
    done
fi
