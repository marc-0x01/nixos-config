#!/bin/bash

out=$(m shutdown)
if [ $? -ne 0 ];
then
    exit 1
fi

exit 0
