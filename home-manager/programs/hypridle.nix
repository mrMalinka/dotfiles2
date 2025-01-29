{ ... }:

{

home.file.".config/hypr/hypridle.conf".text = ''
general {
    #ignore_dbus_inhibit = true
    #ignore_systemd_inhibit = true
}

listener {
    timeout = 150
    on-timeout = hyprlock
}
'';

}
