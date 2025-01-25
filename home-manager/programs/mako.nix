{ lib, ... }:
 
let
    colors = import ./colors.nix { inherit lib; };
    palette = colors.options.globalTheme.colors.default;
in {

home.file.".config/mako/config" = { text = ''
sort=-time
layer=overlay

background-color=${palette.background}

width=300
height=110

border-size=2
border-color=${palette.border}
border-radius=10

margin=15

icons=1
font=0xProto Nerd Font Propo 14

default-timeout=6000

on-button-left=dismiss
on-notify=exec mpg123 ~/.config/notif.mp3

[urgency=high]
default-timeout=0
'';
};

}
