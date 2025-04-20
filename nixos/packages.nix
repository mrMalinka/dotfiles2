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

	# steam setup since it might need sudo
	programs.steam.enable = true;
	programs.steam.gamescopeSession.enable = true;
	programs.gamemode.enable = true;

	environment.systemPackages = with pkgs; [
		mangohud # steam related
		home-manager
	];
}
