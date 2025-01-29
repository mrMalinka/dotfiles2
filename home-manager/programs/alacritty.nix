{ lib, config, ... }:

let
	#colors = import ./colors.nix { inherit lib; };
	#palette = colors.options.globalTheme.colors.default;

	#homeDir = config.home.homeDirectory; # dynamically gets the user home directory
	#walColorsPath = "${homeDir}/.cache/wal/colors-alacritty.toml";
	walColorsPath = "~/.cache/wal/colors-alacritty.toml";
in {
	programs.alacritty = {
		enable = true;
		settings = {
			general.import = ["${walColorsPath}"];

			font = {
				size = 13.0;
				normal = {
					family = "0xProto Nerd Font Mono";
					style = "Regular";
				};
				italic = {
					family = "0xProto Nerd Font Mono";
					style = "Italic";
				};
				bold = {
					family = "0xProto Nerd Font Mono";
					style = "Bold";
				};
			};

			window = {
				opacity = 0.81;
				decorations = "None";
				dynamic_title = false;

				padding.x = 5;
				padding.y = 4;
			};
		};
	};
}
