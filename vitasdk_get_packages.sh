#!/bin/bash
# Alternate VitaSDK package installer by Yoti
curl --silent http://dl.vitasdk.org/ | grep -o '".*.tar.xz"'  | sed 's/"//g' > packages.txt
for line in $(cat packages.txt); do curl -L http://dl.vitasdk.org/$line | tar -C $VITASDK/arm-vita-eabi -Jxvf -; done
rm -f packages.txt
