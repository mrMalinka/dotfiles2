{ pkgs, ... }:

{
	nixpkgs.config.allowUnfree = true;

	home.packages = with pkgs; [
		# essential
		firefox # browser
		vesktop # discord
		vscode-fhs # vsc wrapped for nix compat
		neovim # text editor
		prismlauncher # mincraft

		# other
		go # peak
		godot_4 # game enguh
		wails # go app framework
		tor-browser # :3
		heroic # games
		baobab # disk space visualizer
		gimp # image editor
		pinta # simpler image editor
		vlc # media player
		gnupg # encryption
		jdk17 # mincraf
		gradle # also micraft
		unzip # unzip file
		jetbrains.idea-community-bin # also micrf
		obs-studio # recording
		kicad # pcb design

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
		qemu # vm thing brrr
		wget # download tihng

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
		bc # calculator for fftrim alias in bashrc

		# for wails app:
		gtk3
		pkg-config
		gtk3.dev
		glib
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
		#./vesktoptheme.nix # custom
	];
}
