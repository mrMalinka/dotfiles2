{ config, pkgs, inputs, ... }:

{
  imports = [ ./hardware-configuration.nix ./packages.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    interfaces."enp42s0".wakeOnLan.enable = true;
  };

  hardware.bluetooth.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  /* services.tor = {
     		enable = true;
     		client.enable = true;
     		settings = {
      			SOCKSPort = [9050];
      			ControlPort = 9051;
     		};
      	};
  */

  # docker setup
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      data-root = "";
    };
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  users.extraGroups.docker.members = [ "mrmalinka" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

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
    packages = with pkgs; [ ];
  };

  # cursor
  environment.systemPackages =
    [ inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default ];

  system.stateVersion = "24.11";
}
