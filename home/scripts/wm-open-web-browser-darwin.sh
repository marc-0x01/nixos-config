#!/bin/bash

out=$(/usr/bin/open -a "qutebrowser")
if [ $? -ne 0 ];
then
    exit 1
fi

exit 0
