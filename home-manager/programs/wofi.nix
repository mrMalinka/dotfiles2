{ lib, ... }:
 
let
    colors = import ./colors.nix { inherit lib; };
    palette = colors.options.globalTheme.colors.default;
in {
	programs.wofi = {
		enable = true;

		style = ''
* {
	font-family: '0xProto Nerd Font Propo';
	font-size: 16px;
	outline: none;
	border: none;
	text-shadow: none;
	background-color: transparent;
}

window {
	all: unset;
	padding: 20px;
	border-radius: 10px;

	background-color: alpha(${palette.background}, 0.7);
}

#inner-box {
	margin: 2px;
	padding: 5px;
}

#outer-box {
	border-radius: 10px;
}

#scroll {
	margin: 0px;
	padding: 30px;
	border: none;
}

#input {
	all:unset;

	margin-left:20px;
	margin-right:20px;
	margin-top:20px;

	padding: 20px;

	border-radius: 10px;
	background: ${palette.background};
	color: ${palette.font};
}

#text {
	margin: 5px;
	border: none;
	color: ${palette.font};
	outline: none;
}

#entry {
	border: none;
	border-radius: 10px;

	margin: 2px;

	transition: all 0.1s ease-in-out;
}
#entry:selected {
	background: ${palette.background};
}
#entry:selected #text {
	color: ${palette.color3};
}
'';
	
		settings = {
			"allow_images" = "true";
			"show" = "run";
			"width" = "700";
			"height" = "800";
			"always_parse_args" = "true";
			"show_all" = "true";
			"term" = "alacritty";
			"hide_scroll" = "true";
			"print_command" = "true";
			"insensitive" = "true";
			"columns" = "1";
		};
	};
}
