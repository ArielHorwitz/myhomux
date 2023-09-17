#!/bin/bash

case $1 in
    base ) polybar-msg action kmd hook 0 && /usr/bin/iukbtw/gamma;;
    text ) polybar-msg action kmd hook 1 && /usr/bin/iukbtw/gamma green;;
    *    ) echo "No such layer" >&2;;
esac
