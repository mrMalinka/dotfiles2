# NOT FUNCTIONAL
{ config, lib, pkgs, ... }:

let
  colors = import ./colors.nix { inherit lib; };
  palette = colors.options.globalTheme.colors.default;
  rfs = str: builtins.substring 1 (builtins.stringLength str - 1) str;
in {
  home.activation.setVesktopColor = lib.hm.dag.entryAfter ["writeBoundary"] ''
    # define the path to the json file and the color
    settings_file="$HOME/.config/vesktop/settings/settings.json"
    color="${rfs palette.color1}"

    # create the directory and an empty JSON file if it doesn't exist
    if [ ! -f "$settings_file" ]; then
      mkdir -p "$(dirname "$settings_file")"
      echo '{}' > "$settings_file"
    fi

    # use jq to update the color attribute in the json file
    ${pkgs.jq}/bin/jq '.plugins.ClientTheme.color = "'"$color"'"' "$settings_file" > "$settings_file.tmp"
    mv "$settings_file.tmp" "$settings_file"
  '';
}
