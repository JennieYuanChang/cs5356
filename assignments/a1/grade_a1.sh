#!/bin/bash
USAGE="A cute little grading script for Assignment 1.\n\
Call the script like, \n\n\
$ bash $0 <netid>\n\n\
If the output is '<netid> Success', then you are good!\n"
set -e
if [ $# -lt 1 ]; then
    echo -e $USAGE
    exit -1
fi

giturl='https://raw.githubusercontent.com/CT-CS5356-Fall2017/cs5356/master/README.md'
function get_url() {
    netid="$1"
    curl --silent $giturl | grep "$netid" | cut -d '-' -f 2 | tr -d ' '
}

netid="$1"
url=$(get_url $netid)
echo "URL found form GitHub: $url"


function connection_check() {
    url=$1
    if curl --silent --fail -r 0-10 "$url"; then
        echo "Connection Succeeded" >&2
    else
        echo "Could not reach: $url" >&2
        exit -1
    fi
}


ret=$(connection_check $url)
if [ "$ret" == "$netid" ]; then
    echo "Congrats! Everything works fine."
else
    echo "The netid in the server ($ret) and in the github ($netid) does not match"
fi
set +e
