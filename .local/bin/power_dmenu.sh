#!/bin/bash

dmenu_opts="-c -W 0.33 -B 2"  # Default styling options
systemd=false

function usage {
    echo "Usage: $0 [option]"
    echo "  -h, --help   Display this help and exit"
    echo "  --systemd    Adapt the system commands to a systemd based distribution"
}

# Parse command-line options
while [[ $# -gt 0 ]]; do
    case $1 in
        --systemd)
        systemd=true
        ;;
    -h|--help)
        usage
        exit 0
        ;;
    *)
        echo "Invalid option: $1"
        usage
        exit 1
        ;;
    esac
    shift
done

function handle_power_action {
    local action="$1"

    # Check if the action is empty
    if [ -z "$action" ]; then
        return
    fi

    if [[ $action == "hibernate" || $action == "suspend" ]]; then
        # Skip confirmation
        $provider "$action"
    else
        confirm=$(
            echo -e "Yes, $action\nNo, cancel" |
            bemenu $dmenu_opts -l 2 -p "Are you sure?"
        )

        if [[ $confirm == "Yes, $action" ]]; then
            $provider "$action"
        fi
    fi
}

# NOTE: 'loginctl' is used as a provider where elogind is installed, on systemd
# based distributions 'loginctl' just controls the systemd login manager.
if [[ $systemd == true ]]; then
    provider=systemctl
else
    provider=loginctl
fi

function powermenu {
    local options=("sleep" "shutdown" "reboot" "logout" "cancel")
    local selected=$(printf "%s\n" "${options[@]}" | bemenu $dmenu_opts -l 5 -p powermenu)

    case $selected in
        "shutdown"|"reboot")
            handle_power_action "$selected"
            ;;
        "sleep")
            local sleep_method=$(
                echo -e "hibernate\nsuspend" |
                bemenu $dmenu_opts -l 2 -p "Choose sleep method"
            )

            handle_power_action "$sleep_method"
            ;;
        "logout")
            # NOTE: Both providers have the 'terminate-session' option
            loginctl terminate-session ${XDG_SESSION_ID-}
            ;;
        "cancel")
            return
            ;;
    esac
}
powermenu
