#!/bin/bash

dmenu_opts="-c -W 0.33 -B 2"  # Default styling options
systemd=false

function usage {
    echo "Usage: $0 [option]"
    echo "  -h, --help   Display this help and exit"
    echo "  --systemd    Adapt the system commands to a systemd based distribution"
}

if [[ ($* == "--help") ||  $* == "-h" ]]; then
    usage
    exit 0
fi

while [[ $# -gt 0 ]]; do
    case $1 in
        --sytemd)
        systemd=true
        ;;
    *)
        echo "Invalid option: $1"
        usage
        exit 1
        ;;
    esac
    shift
done

# NOTE: 'loginctl' is used as a provider where elogind is installed, on systemd
# based distributions 'loginctl' just controls the systemd login manager.
if [[ $systemd == true ]]; then
    provider=systemctl
else
    provider=loginctl
fi

function powermenu {
    options="sleep\nshutdown\nreboot\nlogout\ncancel"
    # NOTE: The 'bemenu' command can be supplemented with rofi, wofi or any
    # dmenu compatible application launcher.
    selected=$(echo -e $options | bemenu $dmenu_opts -l 5 -p powermenu)
    if [[ $selected == "shutdown" ]]; then
        confirm=$(
            echo -e "Yes, $selected\nNo, cancel" |
            bemenu $dmenu_opts -l 2 -p "Are you sure?"
        )
        if [[ $confirm == "Yes, $selected" ]]; then
            $provider poweroff
        else
            return
        fi
    elif [[ $selected == "reboot" ]]; then
        confirm=$(
            echo -e "Yes, $selected\nNo, cancel" |
            bemenu $dmenu_opts -l 2 -p "Are you sure?"
        )
        if [[ $confirm == "Yes, $selected" ]]; then
            $provider reboot
        else
            return
        fi
    elif [[ $selected == "sleep" ]]; then
        confirm=$(
            echo -e "Hibernate\nSuspend" |
            bemenu $dmenu_opts -l 2 -p "Chose sleep method"
        )
        if [[ $confirm == "Hibernate" ]]; then
            $provider hibernate
        elif [[ $confirm == "Suspend" ]]; then
            $provider suspend
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
