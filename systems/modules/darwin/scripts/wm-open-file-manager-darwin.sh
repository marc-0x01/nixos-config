#!/bin/bash

out=$(/usr/bin/open -R ~/)
if [ $? -ne 0 ];
then
    exit 1
fi

exit 0