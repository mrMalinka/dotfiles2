{ lib, ... }:
 
let
	colors = import ./colors.nix { inherit lib; };
	palette = colors.options.globalTheme.colors.default;
in {

home.file.".config/waybar/style.css".text = ''
* {
	font-size: 19px;
	font-family: "0xProto Nerd Font Propo";
}

window#waybar {
	all:unset;
}

#power-container,
#media-player,
.module {
	all:unset;

	background: alpha(${palette.background}, 0.6);
	color: ${palette.color7};

	margin: 8px 5px 0px;
	padding: 7px 15px;

	border: solid 2px alpha(${palette.color11}, 0.2);
	border-radius: 10px;

	transition: all 0.1s ease-in-out;
}
#workspaces button:hover,
.module:hover:not(#workspaces) {
	background-color: alpha(${palette.background}, 0.95);
	color: ${palette.color15};
}

#custom-sleep,
#custom-lock,
#custom-shutdown,
#custom-play-button,
#custom-next-track,
#custom-previous-track,
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
	color: alpha(${palette.background}, 0.8);

	transition: all 0.1s ease-in-out;
}
#workspaces button.active {
	color: alpha(${palette.color6}, 0.75);
}
'';

home.file.".config/waybar/config".text = ''
{
	"layer": "top",
	"position": "top",
	"reload_style_on_change": true,

	"margin": 0,

	"modules-left": [
		"group/media-player",
		"memory",
		"bluetooth"
	],
	"modules-center": [
		"hyprland/workspaces"
	],
	"modules-right": [
		"clock#date",
		"clock#hour",
		"group/power-container"
	],



	"group/media-player": {
		"modules": [
			"custom/previous-track",
			"custom/play-button",
			"custom/next-track",
			"custom/progress-bar"
		],
		"orientation": "horizontal"
	},
	"custom/previous-track": {
		"format": "󰒮",
		"tooltip": false,
		"on-click": "playerctl previous"
	},
	"custom/play-button": {
		"exec": "/home/mrmalinka/.config/waybar/scripts/play-button.sh",
		"interval": 1,
		"return-type": "json",
		"on-click": "playerctl play-pause"
	},
	"custom/next-track": {
		"format": "󰒭",
		"tooltip": false,
		"on-click": "playerctl next"
	},
	"custom/progress-bar": {
		"exec": "/home/mrmalinka/.config/waybar/scripts/progress-bar-launcher.sh",
		"return-type": "json",
		"interval": 1,
		"on-scroll-up": "playerctl position 3+",
		"on-scroll-down": "playerctl position 3-"
	},

	"memory": {
		"interval": 3,
		"tooltip": false,
		"format": "{used} GiB "
	},
	"bluetooth": {
		"format": "off 󰂲",
		"format-on": "on 󰂯",
		"format-connected": "conn 󰂱",
		"format-connected-battery": "{device_battery_percentage}% 󰥉",

		"on-click": "bluetoothctl -- connect 40:58:99:1D:C3:61",
		"on-scroll-up": "bluetoothctl power on",
		"on-scroll-down": "bluetoothctl power off"
	},


	"hyprland/workspaces": {
		"format": "{icon}",
		"format-icons": {
			"active": "",
			"default": "",
			"empty": ""
		},
		"persistent-workspaces": {
			"*": [ 1,2,3 ]
		}
	},


	"clock#date": {
		"interval": 30,
		"tooltip": false,
		"format": "{:%a %m-%d}"
	},
	"clock#hour": {
		"interval": 10,
		"tooltip": false
	},
	"group/power-container": {
		"modules": [
			"custom/lock",
			"custom/sleep",
			"custom/shutdown"
		],
		"orientation": "horizontal"
	},
	"custom/lock": {
		"format": "󰌾",
		"tooltip": false,
		"on-click": "hyprlock"
	},
	"custom/sleep": {
		"format": "󰤄",
		"tooltip": false,
		"on-click": "systemctl sleep && hyprlock"
	},
	"custom/shutdown": {
		"format": "",
		"tooltip": false,
		"on-click": "systemctl poweroff"
	}
}
'';

home.file.".config/waybar/scripts/play-button.sh" = { text = ''
status=$(playerctl status -f "{{ uc(status) }}")

if [ $? -ne 0 ]; then
	echo '{"text": ""}' | jq --unbuffered --compact-output .
	exit
fi

if [ "$status" == "PLAYING" ]; then
	echo '{"text": ""}' | jq --unbuffered --compact-output .
elif [ "$status" == "PAUSED" ]; then
	echo '{"text": ""}' | jq --unbuffered --compact-output .
elif [ "$status" == "STOPPED" ]; then
	echo '{"text": ""}' | jq --unbuffered --compact-output .
else
	echo '{"text": ""}' | jq --unbuffered --compact-output .
fi
'';

executable = true;
};

home.file.".config/waybar/scripts/progress-bar-launcher.sh" = { text = ''
lua /home/mrmalinka/.config/waybar/scripts/progress-bar.lua
'';

executable = true;
};

home.file.".config/waybar/scripts/progress-bar.lua".text = ''
local barLength = 12
local full = "█"
local empty = " "


local function execCommand(command)
    local handle = io.popen(command)
    local result = handle:read("*a")
    handle:close()
    return result
end
local function round(num)
    return math.floor(num + 0.5)
end

local currentTrackPosition = tonumber(execCommand("playerctl metadata --format \" {{ position }}\""))
local trackLength = tonumber(execCommand("playerctl metadata --format \" {{ mpris:length }}\""))

if not currentTrackPosition then
	print("{\"text\":\"nothing playing\"}")
	return
end

local needToFill
if trackLength ~= 0 then
	needToFill = round((currentTrackPosition / trackLength) * barLength)
else
	needToFill = 0
end

local filledPart = string.rep(full, needToFill)
local emptyPart = string.rep(empty, barLength - needToFill)

print(string.format("{\"text\":\"%s\"}", filledPart .. emptyPart))
'';

}
