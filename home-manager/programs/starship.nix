{ lib, ... }:

let
	colors = import ./colors.nix { inherit lib; };
	palette = colors.options.globalTheme.colors.default;
in {
	programs.starship = {
		enable = true;
		settings = {
			format = "[╭─](${palette.color2})$os$username[](fg:${palette.color2} bg:${palette.color4})$directory[](fg:${palette.color4} bg:${palette.color6})$time[](${palette.color6})$line_break[╰─](${palette.color2})$character";

			os = {
				disabled = false;
				style = "bg:${palette.color2}";
				symbols = {
					Arch = "󰣇";
					NixOS = "󱄅";
				};
			};

			username = {
				show_always = true;
				style_user = "bg:${palette.color2}";
				style_root = "bg:${palette.color2}";
				format = "[ $user ]($style)";
			};

			directory = {
				style = "bg:${palette.color4}";
				format = "[ $path ]($style)";
				truncation_length = 4;
				truncation_symbol = "…/";
			};

			time = {
				disabled = false;
				style = "bg:${palette.color6}";
				format = "[ $time ]($style)";
				time_format = "%R"; # hour:minute format
			};

			character = {
				success_symbol = "[❯](bold white)";
				error_symbol = "[❯](bold white)";
			};
		};
	};
}

