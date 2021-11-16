#!/bin/sh
. $HOME/.zprofile

xsetroot -cursor_name ptr_left

# key repeat rate
xset r rate 200 30

# logoff after 3 minutes
xset s 180 5

XSECURELOCK_SHOW_HOSTNAME=0 \
XSECURELOCK_FONT="Iosevka Nerd Font:pixelsize=13:antialias=true:autohint=true" \
xss-lock -n /usr/lib/xsecurelock/dimmer -l -- xsecurelock &

# set tapping on touchpad
#xinput set-prop 16 315 1

# enable natural scrolling
# xinput set-prop 16 297 1

# reload Xresources
xrdb ~/.Xresources

setxkbmap pl -option caps:super

if [ ! -e "$HOME/.env/.var/plain_wallpaper" ]; then
    if [ -e "$HOME/.wall.png" ]; then
        feh --bg-fill $HOME/.wall.png
    elif [ -e "$HOME/.wall.jpg" ]; then
        feh --bg-fill $HOME/.wall.jpg
    fi
else
    : ${BGCOLOR:="#131313"}
    [ -e "$HOME/.env/.var/color" ] && BGCOLOR="`cat $HOME/.env/.var/color`"
    xsetroot -bg "$BGCOLOR" -cursor_name ptr_left
fi

: ${WM:=qtile}
[ -e $HOME/.env/.var/wm ] && WM=`cat $HOME/.env/.var/wm`

[ $WM = "berry" ] && sxhkd -c $HOME/.config/berry/sxhkdrc &

#MONITORS=`xrandr --listactivemonitors`

# TODO: Check if dock is present and has displays
# if [ "`echo $MONITORS | grep -E -c 'DP2-1|DP2-2'`" = "2" ]; then
#if [ "`lspci | grep -Ec BCM57762`" = "1" ]; then
#    export DOCK_MONITORS=0
#else
#    export DOCK_MONITORS=1
#fi
#
#if [ "`echo $MONITORS | grep -E -c 'HDMI1'`" = "1" ]; then
#    export HOME_MONITORS=0
#else
#    export HOME_MONITORS=1
#fi

# xrandr --output DP2-1 --primary --pos 0x0 --output DP2-2 --left-of DP2-1 --output eDP1 --right-of DP2-1
#xrandr --output DP2-2 --left-of DP2-1 --output eDP1 --right-of DP2-1
#if [ $DOCK_MONITORS = 0 ]; then
#    xrandr --output DP2-2 --primary --pos 0x0 --output DP2-1 --left-of DP2-2 --output eDP1 --right-of DP2-2
#elif [ $HOME_MONITORS = 0 ]; then
#    xrandr --output HDMI1 --primary --pos 0x0 --output eDP1 --right-of HDMI1
#fi

ACTIVEMONITORS=`xrandr --listactivemonitors | awk 'NR>1 {print $4}'`

if [ "`echo $ACTIVEMONITORS | grep -c 'HDMI1'`" = "1" ]; then
    export HDMIACTIVE=0
    xrandr --output HDMI1 --primary --pos 0x0 --output eDP1 --right-of HDMI1
else
    export HDMIACTIVE=1
fi

xbindkeys &

exec $WM
