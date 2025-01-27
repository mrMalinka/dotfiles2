{ pkgs, ... }:

{
	nixpkgs.config.allowUnfree = true;

	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	};

	services.hardware.openrgb.enable = true; # openrgb

	fonts.packages = with pkgs; [
		nerd-fonts._0xproto
	];

	environment.systemPackages = with pkgs; [
		home-manager

		# essential
		alacritty # main terminal emulator
		neovim # main text editor
		wofi # app launcher

		# rice
		hypridle # hyprlock on idle
		hyprlock # screen locker
		waybar # top bar
		swww # wallpaper
		hyprcursor # cursor
		pywal16 # theme generator from wallpaper
		#starship # prompt
		mako # notification daemon

		# utils
		wl-clipboard-rs # clipboard utils (in rust btw)
		grim # screenshot tool

		# fun
		fastfetch # i use nixos btw

		# kinda dependencies
		jq # json cli (for waybar media player)
		git # git
		lua # lua (waybar media player)
		python312 # python
		imagemagick # pywal backend
		slurp # screenshot
		unzip # for mason nvim
		mpg123 # mp3 player cli (waybar media player)

		# neovim plugin dependencies
		vscode-langservers-extracted # css ls
		nodejs # npm
		lua-language-server # lua_ls
		python312Packages.python-lsp-server # pylsp
	];
}
