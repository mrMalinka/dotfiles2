{ pkgs, ... }:

{
	nixpkgs.config.allowUnfree = true;

	home.packages = with pkgs; [
		
	# HERE

		# essential
		firefox # browser
		vesktop # discord
		vscode-fhs # vsc wrapped for nix compat
		neovim # main text editor

		# other
		tor-browser # :3
		heroic # games
		baobab # disk space visualizer
		gimp # image editor
		vlc # media player

		# rice
		pywal16 # theme generator from wallpaper
		pywalfox-native # pywal/firefox compat
		hypridle # hyprlock on idle
		waybar # top bar
		swww # wallpaper
		hyprcursor # cursor
		mako # notification daemon

		# utils
		playerctl # media player ctl
		bluez # bluetooth cli
		zoxide # smart cd
		btop # resource monitor
		blueman # bluetooth gui
		feh # image viewer
		wl-clipboard-rs # clipboard utils (in rust btw)
		grim # screenshot tool

		# fun
		cava # audio visualizer
		cmatrix # matrix effect
		cbonsai # bonsai tree
		pipes-rs # pipe screensaver
		figlet # big text

		# kinda dependencies
		jq # json cli (for waybar media player)
		git # git
		lua # lua (waybar media player)
		python312 # python
		imagemagick # pywal backend
		slurp # screenshot
		mpg123 # mp3 player cli (waybar media player)

		# (pkgs.writeShellScriptBin "my-hello" ''
		#   echo "Hello, ${config.home.username}!"
		# '')
	];

	imports = [
		./starship.nix
		./alacritty.nix
		./cava.nix
		./fastfetch.nix

		./hyprland.nix
		./hypridle.nix # custom
		./hyprlock.nix

		./mako.nix # custom
		./nvim.nix # custom
		./waybar.nix # custom
		./wofi.nix

		./bashrc.nix # custom
	];
}
