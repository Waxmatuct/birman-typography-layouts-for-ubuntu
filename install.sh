#!/bin/bash

BASE=$(dirname "$0")

out=$(grep -e "typo-birman-en" /usr/share/X11/xkb/symbols/us)
if [ -z "$( grep -e "typo-birman-en" /usr/share/X11/xkb/symbols/us )" ]; then
    sudo bash -c "cat $BASE/symbols/typo-birman-en >> /usr/share/X11/xkb/symbols/us"
fi
if [ -z "$( grep -e "typo-birman-ru" /usr/share/X11/xkb/symbols/ru )" ]; then
    sudo bash -c "cat $BASE/symbols/typo-birman-ru >> /usr/share/X11/xkb/symbols/ru"
fi

# Edit /usr/share/X11/xkb/rules/evdev.lst

sudo sed -i -E 's/\s*typo-birman.*//g' /usr/share/X11/xkb/rules/evdev.lst
sudo sed -i -E 's/(! variant)/\1\n  typo-birman-en         us: English (Typographic by Ilya Birman)\n  typo-birman-ru         ru: Russian (Typographic by Ilya Birman)/g' /usr/share/X11/xkb/rules/evdev.lst

# Edit /usr/share/X11/xkb/rules/evdev.xml

sudo "$BASE/helper/xmladd.py" /usr/share/X11/xkb/rules/evdev.xml "$BASE/rules/variant_en" "$BASE/rules/variant_ru" /tmp/evdev.xml
sudo rm /usr/share/X11/xkb/rules/evdev.xml
sudo mv /tmp/evdev.xml /usr/share/X11/xkb/rules/evdev.xml

