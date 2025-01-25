{ lib, ... }:

let
  colors = import ./colors.nix { inherit lib; };
  palette = colors.options.globalTheme.colors.default;
in {
	programs.cava = {
		enable = true;
		settings = {
			general = {
				framerate = 144;

				bar_width = 3;
				bar_spacing = 1;
				sleep_timer = 30;
			};

			input = {
				method = "pipewire";
				source = "auto";
			};

			color = {
				gradient = 1;
				gradient_color_1 = "'${palette.color1}'";
				gradient_color_2 = "'${palette.color2}'";
				gradient_color_3 = "'${palette.color3}'";
				gradient_color_4 = "'${palette.color4}'";
				gradient_color_5 = "'${palette.color5}'";
				gradient_color_6 = "'${palette.color6}'";
			};

			smoothing.noise_reduction = 50;
		};
	};
}
