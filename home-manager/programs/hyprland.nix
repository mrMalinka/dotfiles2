{ lib, ... }:

let
	colors = import ./colors.nix { inherit lib; };
	palette = colors.options.globalTheme.colors.default;
	# remove first letter (usually a # in a hex code)
	rfs = str: builtins.substring 1 (builtins.stringLength str - 1) str;
in {
	wayland.windowManager.hyprland = {
		enable = true;

		settings = {
			# monitor
			monitor = ",2560x1440@180, 0x0, 1";

			# programs
			"$terminal" = "alacritty";
			"$menu" = "wofi --show drun";

			exec-once = [
				# autostart (mako starts automatically anyways)
				"swww-daemon & waybar & hypridle"

				# for screenshare
				"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
			];

			env = [
				"HYPRCURSOR_SIZE, 24"
				"HYPRCURSOR_THEME, rose-pine-hyprcursor"
			];

			# look and feel
			general = {
				gaps_in = 5;
				gaps_out = 10;
				border_size = 2;
				layout = "dwindle";

				# colors
				"col.active_border" = "rgba(${rfs palette.border}bf)";
				"col.inactive_border" = "rgba(${rfs palette.color7}ff) rgba(${rfs palette.color8}ff) 135deg";
				"col.nogroup_border_active" = "rgba(${rfs palette.color7}80)";
				"col.nogroup_border" = "rgba(${rfs palette.color8}80)";
			};

			decoration = {
				rounding = 10;

				active_opacity = 1;
				inactive_opacity = 0.95;

				shadow = {
					enabled = true;
					range = 5;
					render_power = 3;
					color = "rgba(1a1a1aee)";
				};

				blur = {
					enabled = true;
					size = 2;
					passes = 1;
					vibrancy = 0.1696;

					xray = true;
				};
			};

			layerrule = [
				"blur, waybar"
				"ignorezero, waybar"
			];

			animations = {
				enabled = "yes";
				bezier = [
					"wind, 0.05, 0.9, 0.1, 1.04"
					"winIn, 0.76, 0.42, 0.74, 0.87"
					"winOut, 0.76, 0.42, 0.74, 0.87"
					"workIn, 0.72, -0.07, 0.41, 0.98"
				];
				animation = [
					"windowsIn, 1, 1, workIn, popin"
					"windowsOut, 1, 1, workIn, popin"
					"windowsMove, 1, 3, wind, slide"
					"fadeIn, 1, 2, winIn"
					"fadeOut, 1, 2, winOut"
					"workspaces, 1, 0.6, workIn, slidefade"
					"specialWorkspace, 1, 2.5, workIn, slidevert"
				];
			};

			dwindle = {
				pseudotile = false;
				smart_split = true;
			};

			misc = {
				force_default_wallpaper = 1;
				disable_hyprland_logo = true;
			};

			input = {
				kb_layout = "pl";
				follow_mouse = 1;
			};

			# keybinds
			"$mainMod" = "ALT";

			bind = [
				", Print, exec, grim -g \"$(slurp -d)\" - | wl-copy --type image/png"
				"$mainMod, R, exec, $terminal"
				"$mainMod, X, killactive,"
				"$mainMod, Y, exit,"
				"$mainMod, space, exec, $menu"
				"$mainMod, F, fullscreen"

				"$mainMod, Q, togglesplit,"

				"$mainMod, V, togglefloating,"
				"$mainMod, V, resizeactive, exact 433 343"

				# move focus with mainMod + arrow keys
				"$mainMod, A, movefocus, l"
				"$mainMod, D, movefocus, r"
				"$mainMod, W, movefocus, u"
				"$mainMod, S, movefocus, d"

				# switch workspaces with mainMod + [0-9]
				"$mainMod, 1, workspace, 1"
				"$mainMod, 2, workspace, 2"
				"$mainMod, 3, workspace, 3"
				"$mainMod, 4, workspace, 4"
				"$mainMod, 5, workspace, 5"
				"$mainMod, 6, workspace, 6"
				"$mainMod, 7, workspace, 7"
				"$mainMod, 8, workspace, 8"
				"$mainMod, 9, workspace, 9"
				"$mainMod, 0, workspace, 10"

				# move active window to a workspace with mainMod + SHIFT + [0-9]
				"$mainMod SHIFT, 1, movetoworkspace, 1"
				"$mainMod SHIFT, 2, movetoworkspace, 2"
				"$mainMod SHIFT, 3, movetoworkspace, 3"
				"$mainMod SHIFT, 4, movetoworkspace, 4"
				"$mainMod SHIFT, 5, movetoworkspace, 5"
				"$mainMod SHIFT, 6, movetoworkspace, 6"
				"$mainMod SHIFT, 7, movetoworkspace, 7"
				"$mainMod SHIFT, 8, movetoworkspace, 8"
				"$mainMod SHIFT, 9, movetoworkspace, 9"
				"$mainMod SHIFT, 0, movetoworkspace, 10"

				# scroll through existing workspaces with mainMod + scroll
				"$mainMod, mouse_down, workspace, e+1"
				"$mainMod, mouse_up, workspace, e-1"
			];

			bindm = [
				# move/resize windows with mainMod + LMB/RMB and dragging
				"$mainMod, mouse:272, movewindow"
				"$mainMod, mouse:273, resizewindow"
			];

			windowrulev2 = "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0";
		};
	};
}
