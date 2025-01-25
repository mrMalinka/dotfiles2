{ config, pkgs, inputs, ... }:

{
	imports = [
		./hardware-configuration.nix
		#inputs.home-manager.nixosModules.default
		./packages.nix
		./screenshare.nix
	];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking = {
		hostName = "nixos";
		networkmanager.enable = true;
		interfaces."enp42s0".wakeOnLan.enable = true;
	};

	hardware.bluetooth.enable = true;
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	# locales
	time.timeZone = "Europe/Warsaw";
	i18n.defaultLocale = "en_US.UTF-8";
	i18n.extraLocaleSettings = {
		LC_ADDRESS = "pl_PL.UTF-8";
		LC_IDENTIFICATION = "pl_PL.UTF-8";
		LC_MEASUREMENT = "pl_PL.UTF-8";
		LC_MONETARY = "pl_PL.UTF-8";
		LC_NAME = "pl_PL.UTF-8";
		LC_NUMERIC = "pl_PL.UTF-8";
		LC_PAPER = "pl_PL.UTF-8";
		LC_TELEPHONE = "pl_PL.UTF-8";
		LC_TIME = "pl_PL.UTF-8";
	};

	users.users.mrmalinka = {
		isNormalUser = true;
		description = "mrmalinka";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [];
	};

	# cursor
	environment.systemPackages = [
		inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
	];

	#home-manager = {
	#  extraSpecialArgs = { inherit inputs; };
	#  users = {
	#    "mrmalinka" = import ./home.nix;
	#  };
	#};

	system.stateVersion = "24.11";
}
