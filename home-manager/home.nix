{ config, pkgs, ... }:

{
	imports = [ ./programs/packages.nix ];
	home.username = "mrmalinka";
	home.homeDirectory = "/home/mrmalinka";

	gtk = {
		enable = true;
		
		cursorTheme.package = pkgs.rose-pine-cursor;
		cursorTheme.name = "BreezeX-RosePineDawn-Linux";

		theme.package = pkgs.adw-gtk3;
		theme.name = "adw-gtk3";
	};
	qt = {
		enable = true;
		platformTheme.name = "gtk";
		style.name = "adwaita-dark";
	};

	fonts.fontconfig = {
		enable = true;
		defaultFonts.monospace = [ "0xProto Nerd Font Mono" ];
	};


	home.sessionVariables = {
		EDITOR = "nvim";
	};
	home.stateVersion = "24.11";
	# let home manager manage itself
	programs.home-manager.enable = true;
}
