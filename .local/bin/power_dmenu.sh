#!/bin/bash

# 'loginctl' command requires elogind to be installed.
# The 'bemenu' command can be supplemented with rofi, wofi or any dmenu
# compatible application launcher.

dmenu_opts="-c -W 0.33 -B 2"  # Default styling options

function powermenu {
    options="sleep\nshutdown\nreboot\nlogout\ncancel"
    selected=$(echo -e $options | bemenu $dmenu_opts -l 5 -p powermenu)
    if [[ $selected == "shutdown" ]]; then
        confirm=$(
	    echo -e "Yes, $selected\nNo, cancel" |
	    bemenu $dmenu_opts -l 2 -p "Are you sure?"
        )
        if [[ $confirm == "Yes, $selected" ]]; then
            loginctl poweroff
        else
            return
        fi
    elif [[ $selected == "reboot" ]]; then
        confirm=$(
	    echo -e "Yes, $selected\nNo, cancel" |
	    bemenu $dmenu_opts -l 2 -p "Are you sure?"
        )
        if [[ $confirm == "Yes, $selected" ]]; then
            loginctl reboot
        else
            return
        fi
    elif [[ $selected == "sleep" ]]; then
        confirm=$(
	    echo -e "Hibernate\nSuspend" |
	    bemenu $dmenu_opts -l 2 -p "Chose sleep method"
        )
        if [[ $confirm == "Hibernate" ]]; then
            loginctl hibernate
        elif [[ $confirm == "Suspend" ]]; then
            loginctl suspend
        else
            return
        fi
    elif [[ $selected == "logout" ]]; then
        loginctl terminate-session ${XDG_SESSION_ID-}
    elif [[ $selected == "cancel" ]]; then
        return
    fi
}
powermenu
