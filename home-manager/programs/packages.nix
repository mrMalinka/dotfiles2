{ pkgs, ... }:

{
	#nixpkgs.config.allowUnfree = true;
	home.packages = with pkgs; [
		# essential
		firefox # browser
		vesktop # discord
		prismlauncher # modpacks and shiz

		# other
		tor-browser # :3
		heroic # games
		baobab # disk space visualizer
		gimp # image editor

		# rice
		yadm # dotfile manager
		pywalfox-native # pywal/firefox compat

		# utils
		playerctl # media player ctl
		bluez # bluetooth cli
		zoxide # smart cd
		btop # resource monitor
		blueman # bluetooth gui

		# fun
		cava # audio visualizer
		cmatrix # matrix effect
		cbonsai # bonsai tree
		pipes-rs # pipe screensaver
		figlet # big text

		# (pkgs.writeShellScriptBin "my-hello" ''
		#   echo "Hello, ${config.home.username}!"
		# '')
	];

	# currently unsupported: hypridle, mako
	# not included by choice: nvim
	imports = [
		./starship.nix
		./alacritty.nix
		./cava.nix
		./fastfetch.nix
		./hyprland.nix
		./hyprlock.nix
		./waybar.nix
	];
}
