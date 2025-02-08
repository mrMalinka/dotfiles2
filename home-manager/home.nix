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
		theme.name = "adw-gtk3-dark";
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

	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [
			xdg-desktop-portal-gtk
			xdg-desktop-portal-wlr
			xdg-desktop-portal-hyprland
		];
		configPackages = with pkgs; [
			xdg-desktop-portal-gtk
			xdg-desktop-portal-hyprland
			xdg-desktop-portal-wlr
		];
	};

	home.sessionVariables = {
		EDITOR = "nvim";
	};
	home.stateVersion = "24.11";
	# let home manager manage itself
	programs.home-manager.enable = true;
}
