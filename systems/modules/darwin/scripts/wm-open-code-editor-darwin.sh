#!/bin/bash

out=$(/usr/bin/open -a "qutebrowser" --args --target window http://vscode.dev)
if [ $? -ne 0 ];
then
    exit 1
fi

exit 0