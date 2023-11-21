#!/bin/bash

out=$(/usr/bin/open -a "Firefox")
if [ $? -ne 0 ];
then
    exit 1
fi

exit 0
