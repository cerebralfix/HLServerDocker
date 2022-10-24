#! /bin/bash

# where the server is installed
HEADUS_HOME=/usr/local/hlserver

# where the code or license file is located
CODE=$HEADUS_HOME/hlmanager-code.txt
LICENSE=$HEADUS_HOME/hlmanager-license.txt

# PID for the server
HLSERVER_PID=0

# Executable
HLBIN=$HEADUS_HOME/hlserver
HLMAN=$HEADUS_HOME/hlmanager

# The Config File to use
HLCONF=$HEADUS_HOME/hlserver.conf

# Log Settings and location
HLLOG_NUM=2
HLLOG_DAYS=7
HLLOG_NAME=hlserver-%d.log

# Launch Server, retain proccess ID
if [! -f "$HLCONF" ]
    $HLBIN -l,$HLLOG_NUM,$HLLOG_DAYS,$HLLOG_NAME & 
    HLSERVER_PID=$!
else
    $HLBIN -c,$HLCONF -l,$HLLOG_NUM,$HLLOG_DAYS,$HLLOG_NAME & 
    HLSERVER_PID=$!
fi

# Make sure the server has started.
sleep 3

if [ ! -f "$CODE" ] || [ ! -f "$HLCONF" ]; then
    echo "No HLCode generated, generating new HL Code";

    # Start the manager
    ./hlmanager &
    HLMANAGER_PID=$1 &
    sleep 3

    echo "Email the following code to your vendor to get your license keys:"
    cat /tmp/hlmanager-code.txt
    cp /tmp/hlmanager-code.txt $CODE
    echo "Code is stored here: $CODE"

    kill -15 $HLMANAGER_PID
fi

if [ -f "$LICENSE" ]; then
    echo "adding licenses"
    while read key; do 
        echo $key | $HLMAN add;
    done < $LICENSE

    $HLMAN reload
fi

wait "$HLSERVER_PID"