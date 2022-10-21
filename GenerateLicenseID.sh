#! /bin/bash

# where the code or license file is located
CODE=hlmanager-code.txt
LICENSE=hlmanager-license.txt

# Launch Server
./hlserver & sleep 10

if [ -f "$LICENSE" ]; then
    echo "adding licenses"
    while read key; do 
        echo $key | ./hlmanager add;
    done < $LICENSE
fi

if [ ! -f "$CODE" ]; then
    echo "No HLCode generated, generating new HL Code";
    ./hlmanager & sleep 10
    cat /tmp/hlmanager-code.txt
    cp /tmp/hlmanager-code.txt $CODE
fi
