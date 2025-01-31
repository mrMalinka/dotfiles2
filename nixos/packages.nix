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

	programs.steam.enable = true;

	environment.systemPackages = with pkgs; [
		home-manager
	];
}
