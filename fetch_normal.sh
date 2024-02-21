#!/bin/bash
TARGET="/robots.txt"
REGEXP="furaffinity|furry"
HOST="furaffinity.net"
USER_AGENT="mozilla/5.0"

IFS="
"
TEMPFILE=$( mktemp ) ||
	exit $?
cd $( mktemp --directory ) ||
	exit $?

for ipaddr in $( cat - ) ; do
	wget --quiet --output-document=$TEMPFILE --user-agent=$USER_AGENT --header="Host: $HOST" "http://$ipaddr/$target" ||
		continue

	grep --quiet --extended-regex --ignore-case --regexp="$REGEXP" $TEMPFILE &&
		printf "$ipaddr TRUE \r\n"
done
exit 0


