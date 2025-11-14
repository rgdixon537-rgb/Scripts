# Source - https://stackoverflow.com/a
# Posted by Brad Parks, modified by community. See post 'Timeline' for change history
# Retrieved 2025-11-14, License - CC BY-SA 3.0
#! /usr/local/bin/sh
PORT=$1
HOST=$2
TIMEOUT_IN_SEC=${3:-1}
VALUE_IF_OPEN=${4:-"OPEN"}
VALUE_IF_CLOSED=${5:-"CLOSED"}

function eztern()
{
  if [ "$1" == "$2" ]
  then
    echo $3
  else
    echo $4
  fi
}

# cross platform timeout util to support mac mostly
# https://gist.github.com/jaytaylor/6527607
function eztimeout() { perl -e 'alarm shift; exec @ARGV' "$@"; }

function testPort()
{
  OPTS=""

  # find out if port is open using telnet
  # by saving telnet output to temporary file
  # and looking for "Escape character" response
  # from telnet
  FILENAME="/tmp/__port_check_$(uuidgen)"
  RESULT=$(eztimeout $TIMEOUT_IN_SEC telnet $HOST $PORT &> $FILENAME; cat $FILENAME | tail -n1)
  rm -f $FILENAME;
  SUCCESS=$(eztern "$RESULT" "Escape character is '^]'." "$VALUE_IF_OPEN" "$VALUE_IF_CLOSED")

  echo "$SUCCESS"
}

testPort 

