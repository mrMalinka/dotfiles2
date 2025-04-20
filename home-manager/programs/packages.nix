{ pkgs, ... }:

{
	nixpkgs.config.allowUnfree = true;

	home.packages = with pkgs; [
		# essential
		firefox # browser
		vesktop # discord
		vscode-fhs # vsc wrapped for nix compat
		neovim # main text editor
		prismlauncher # mincraft

		# other
		go # the best language ever
		wails # go app framework
		tor-browser # :3
		heroic # games
		baobab # disk space visualizer
		gimp # image editor
		pinta # simpler image editor
		vlc # media player
		gnupg # gpg
		jdk17 # mincraf
		gradle # also micraft
		unzip # unzip file
		jetbrains.idea-community-bin # also micrf

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
		shotwell # image viewer
		wl-clipboard-rs # clipboard utils (in rust btw)
		grim # screenshot tool
		xdragon # file drag out of term
		ffmpeg # working with videos cli

		# fun
		cava # audio visualizer
		cmatrix # matrix effect
		cbonsai # bonsai tree
		pipes-rs # pipe screensaver
		figlet # big text
		ollama # ai
		monero-gui # dolla dolla ? !? !?

		# kinda dependencies
		jq # json cli (for waybar media player)
		git # git
		lua # lua (waybar media player)
		gcc # for faster nix shell
		python312 # python
		imagemagick # pywal backend
		slurp # screenshot
		mpg123 # mp3 player cli (waybar media player)
		tor # tor binary

		# for wails app:
		gtk3
		webkitgtk
		pkg-config
		gtk3.dev
		webkitgtk.dev
		glib
		(writeShellScriptBin "dwails" ''
			export XDG_DATA_DIRS="${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:${pkgs.glib}/share/gsettings-schemas/${pkgs.glib.name}:$XDG_DATA_DIRS"
			export GI_TYPELIB_PATH="${pkgs.gtk3}/lib/girepository-1.0:${pkgs.webkitgtk}/lib/girepository-1.0:$GI_TYPELIB_PATH"
			export LD_LIBRARY_PATH="${pkgs.gtk3}/lib:${pkgs.webkitgtk}/lib:$LD_LIBRARY_PATH"
			exec ${pkgs.wails}/bin/wails "$@"
		'')
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
		./walpset.nix # custom
	];
}
