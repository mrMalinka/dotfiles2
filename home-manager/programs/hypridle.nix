{ ... }:
# this is not included in packages.nix since there is no programs.hypridle option
# ill keep it around for if it ever does appear
{
	programs.hypridle = {
		enable = true;
		settings = {
			listener = {
				timeout = 150;
				on-timeout = "hyprlock";
			};
		};
	};
}
