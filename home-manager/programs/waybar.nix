{ config, lib, ... }:
 
let
	colors = import ./colors.nix { inherit lib; };
	palette = colors.options.globalTheme.colors.default;

	homeDir = "${config.home.homeDirectory}";
in {
	programs.waybar = {
		enable = true;

		style = ''
@import url('${homeDir}/.cache/wal/colors-waybar.css');

* {
	font-size: 19px;
	font-family: "0xProto Nerd Font Propo";
}

window#waybar {
	all:unset;
}

#power-container;
#media-player;
.module {
	all:unset;

	background: alpha(@background; 0.6);
	color: @color7;

	margin: 8px 5px 0px;
	padding: 7px 15px;

	border: solid 2px alpha(@color11; 0.2);
	border-radius: 10px;

	transition: all 0.1s ease-in-out;
}
#workspaces button:hover;
.module:hover:not(#workspaces) {
	background-color: alpha(@background; 0.95);
	color: @color15;
}

#custom-sleep;
#custom-lock;
#custom-shutdown;
#custom-play-button;
#custom-next-track;
#custom-previous-track;
#custom-progress-bar {
	all:unset;
	padding: 4px 10px;
	border-radius: 10px;

	transition: all 0.1s ease-in-out;
}

#workspaces button {
	all:unset;
	
	border-radius: 10px;
	padding: 0px 8px;
	color: alpha(@background; 0.8);

	transition: all 0.1s ease-in-out;
}
#workspaces button.active {
	color: alpha(@color6; 0.75);
}
'';
		# i have no idea why but it has to be like this:
		# settings (list of bars) > bar > actual settings
		settings = [
			{
				mainBar = {
					"layer" = "top";
					"position" = "top";
					"reload_style_on_change" = true;

					"margin" = 0;

					"modules-left" = [
						"group/media-player"
						"memory"
						"bluetooth"
					];
					"modules-center" = [
						"hyprland/workspaces"
					];
					"modules-right" = [
						"clock#date"
						"clock#hour"
						"group/power-container"
					];


					"group/media-player" = {
						"modules" = [
							"custom/previous-track"
							"custom/play-button"
							"custom/next-track"
							"custom/progress-bar"
						];
						"orientation" = "horizontal";
					};
					"custom/previous-track" = {
						"format" = "󰒮";
						"tooltip" = false;
						"on-click" = "playerctl previous";
					};
					"custom/play-button" = {
						"exec" = "/${homeDir}/.config/waybar/scripts/play-button.sh";
						"interval" = 1;
						"return-type" = "json";
						"on-click" = "playerctl play-pause";
					};
					"custom/next-track" = {
						"format" = "󰒭";
						"tooltip" = false;
						"on-click" = "playerctl next";
					};
					"custom/progress-bar" = {
						"exec" = "/${homeDir}/.config/waybar/scripts/progress-bar-launcher.sh";
						"return-type" = "json";
						"interval" = 1;
						"on-scroll-up" = "playerctl position 3+";
						"on-scroll-down" = "playerctl position 3-";
					};


					"memory" = {
						"interval" = 3;
						"tooltip" = false;
						"format" = "{used} GiB ";
					};
					"bluetooth" = {
						"format" = "off 󰂲";
						"format-on" = "on 󰂯";
						"format-connected" = "conn 󰂱";
						"format-connected-battery" = "{device_battery_percentage}% 󰥉";

						"on-click" = "bluetoothctl -- connect 40:58:99:1D:C3:61";
						"on-scroll-up" = "bluetoothctl power on";
						"on-scroll-down" = "bluetoothctl power off";
					};


					"hyprland/workspaces" = {
						"format" = "{icon}";
						"format-icons" = {
							"active" = "";
							"default" = "";
							"empty" = "";
						};
						"persistent-workspaces" = {
							"*" = [ 1 2 3 ];
						};
					};


					"clock#date" = {
						"interval" = 30;
						"tooltip" = false;
						"format" = "{:%a %m-%d}";
					};
					"clock#hour" = {
						"interval" = 10;
						"tooltip" = false;
					};
					"group/power-container" = {
						"modules" = [
							"custom/lock"
							"custom/sleep"
							"custom/shutdown"
						];
						"orientation" = "horizontal";
					};
					"custom/lock" = {
						"format" = "󰌾";
						"tooltip" = false;
						"on-click" = "hyprlock";
					};
					"custom/sleep" = {
						"format" = "󰤄";
						"tooltip" = false;
						"on-click" = "systemctl sleep";
					};
					"custom/shutdown" = {
						"format" = "";
						"tooltip" = false;
						"on-click" = "systemctl poweroff";
					};

				};
			}
		];
	};
}
