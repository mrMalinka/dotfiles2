{
	description = "main flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";

		#home-manager = {
		#  url = "github:nix-community/home-manager";
		#  inputs.nixpkgs.follows = "nixpkgs";
		#};
	};

	outputs = { self, nixpkgs, ... }@inputs: {
		nixosConfigurations = {
			default = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				specialArgs = {inherit inputs;};
				modules = [
					./configuration.nix
					#inputs.home-manager.nixosModules.default
				];
			};
		};
	};
}

