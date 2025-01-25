{ lib, ... }:

let
	colors = import ./colors.nix { inherit lib; };
	palette = colors.options.globalTheme.colors.default;
	# remove first letter (usually a # in a hex code)
	rfs = str: builtins.substring 1 (builtins.stringLength str - 1) str;
in {
	programs.hyprlock = {
		enable = true;

		settings = {
			background = {
				"monitor" = "";
				"path" = "/home/mrmalinka/.config/wallpaper.png";

				"blur_passes" = 2;
				"blur_size" = 3;

				"contrast" = 1.4;
			};

			label = [
				{
					"monitor" = "";
					"font_family" = "0xProto Nerd Font Propo";
					"font_size" = "44";
					"color" = "rgba(${rfs palette.font}ff)";

					"text" = "$TIME";
					"position" = "0, 500";

					"halign" = "center";
					"valign" = "center";
				}
				{
					"monitor" = "";
					"font_family" = "0xProto Nerd Font Propo";
					"font_size" = 20;
					"color" = "rgba(${rfs palette.font}ff)";

					"text" = "hey $USER";
					"position" = "0, 40";

					# this is supposed to be default?
					"halign" = "center";
					"valign" = "center";
				}
			];

			input-field = {
				"monitor" = "";
				"font_family" = "0xProto Nerd Font Propo";
				"fade_on_empty" = false;

				"size" = "250, 50";
				"position" = "0, -40";

				"inner_color" = "rgba(${rfs palette.background}bf)";
				"outer_color" = "rgba(${rfs palette.border}ff)";
				"font_color" = "rgba(${rfs palette.font}ff)";
				"check_color" = "rgba(${rfs palette.color12}ff)";

				"dots_size" = 0.2;
				"dots_spacing" = 1.0;

				"rounding" = 10;
				"outline_thickness" = 2;

				"placeholder_text" = "password";
				"fail_text" = "wrong  $ATTEMPTS";
			};
		};
	};
}
