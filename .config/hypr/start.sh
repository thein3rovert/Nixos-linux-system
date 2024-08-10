#!/usr/bin/env bash

# intializing wallpaper daemon
swww init &
swww img ~/Wallpapers/eat-sleep.png &

# adding network manager
nm-applet --indicator &

# add the way bar
waybar &
# dunst
dunst
