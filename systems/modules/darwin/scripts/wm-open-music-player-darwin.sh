#!/bin/bash

out=$(alacritty -e ncspot)
if [ $? -ne 0 ];
then
    exit 1
fi

exit 0