{ config, lib, ... }:

{
	programs.fastfetch = {
		enable = true;
		settings = {
			logo = {
				source = "${config.home.homeDirectory}/.config/fastfetch/nixos.txt";
				color = { "1" = "35"; "2" = "36"; };
				padding = {
					top = 2;
					left = 2;
					right = 3;
				};
			};
			display.separator = " ";
			modules = [
				"break"
				{
					type = "title";
					color = "39"; # doesnt actually work i think
				}
				"break"
				{
					type = "os";
					format = "{pretty-name}";
					key = " ";
					keyColor = "35";
				}
				{
					type = "cpu";
					format = "{name}";
					key = " ";
					keyColor = "35";
				}
				{
					type = "gpu";
					format = "{name}";
					key = "󰢮 ";
					keyColor = "35";
				}
				{
					type = "display";
					format = "{preferred-width}x{preferred-height} @ {refresh-rate}Hz";
					key = "󰍹 ";
					keyColor = "35";
				}
				{
					type = "wm";
					format = "{pretty-name} {version}";
					key = " ";
					keyColor = "35";
				}
				{
					type = "terminal";
					key = " ";
					keyColor = "35";
				}
				"break"
				"colors"
				"break" # extra line because pretty
			];
		};
	};

#home.file.".config/fastfetch/nixos.txt".text = ''
#     ▟█▖    ▝█▙ ▗█▛
#  ▗▄▄▟██▄▄▄▄▄▝█▙█▛  ▖
#  ▀▀▀▀▀▀▀▀▀▀▀▘▝██  ▟█▖
#     ▟█▛       ▝█▘▟█▛
#▟█████▛          ▟█████▛
#   ▟█▛▗█▖       ▟█▛
#  ▝█▛  ██▖▗▄▄▄▄▄▄▄▄▄▄▄
#   ▝  ▟█▜█▖▀▀▀▀▀██▛▀▀▘
#     ▟█▘ ▜█▖    ▝█▛
#'';

#home.file.".config/fastfetch/nixos.txt".text = ''
#    ⠈⢿⣷⡀ ⠈⢿⣷⣄⣾⡿⠃
#  ⢀⣶⣶⣾⣿⣿⣶⣶⣮⣻⣿⣿⠁ ⢠⡀
#     ⣩⣭⡍    ⢻⣿⣆⢠⣿⡗
#⢠⣤⣤⣤⣴⣿⠟      ⠹⣳⣿⣿⣤⣤⡄
#⠘⠛⠛⣿⣿⢯⣦      ⣰⣿⠟⠛⠛⠛⠃
#  ⢼⣿⠋⠹⣿⣧⢀⣀⣀⣀⣜⣛⣋⣀⣀⡀
#  ⠈⠃ ⢀⣾⣿⣷⡻⠿⠿⢿⣿⡿⠿⠿⠁
#    ⢠⣾⡿⠙⢿⣷⡀ ⠈⢿⣷⡄
#'';

home.file.".config/fastfetch/nixos.txt".text = ''
 $1     ⣀⡀  $2⣀⣀⡀ ⢀⣀
 $1    ⠈⢿⣷⡀ $2⠈⢿⣷⣄⣾⡿⠃
 $1  ⢀⣶⣶⣾⣿⣿⣶⣶⣮$2⣻⣿⣿⠁ $1⢠⡀
 $2     ⣩⣭⡍    ⢻⣿⣆$1⢠⣿⡗
 $2⢠⣤⣤⣤⣴⣿⠟      ⠹$1⣳⣿⣿⣤⣤⡄
 $2⠘⠛⠛⣿⣿⢯$1⣦      ⣰⣿⠟⠛⠛⠛⠃
 $2  ⢼⣿⠋$1⠹⣿⣧$2⢀⣀⣀⣀⣜⣛⣋⣀⣀⡀
 $2  ⠈⠃ $1⢀⣾⣿⣷$2⡻⠿⠿⢿⣿⡿⠿⠿⠁
 $1    ⢠⣾⡿⠙⢿⣷⡀ $2⠈⢿⣷⡄
 $1     ⠉⠁ ⠈⠉⠉  $2⠈⠉
'';

}
