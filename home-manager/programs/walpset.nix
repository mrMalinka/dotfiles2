{ ... }:

{

home.file.".config/walpset.sh" = { text = ''
if ! [ -s $1 ]; then
	echo "$1: file not found"
	exit 1
fi

swww img $1 --transition-type wave --transition-angle 0 --transition-fps 180 --transition-wave 50,10 > /dev/null
wal --cols16 -n -q -i $1

hex=$(sed -n '3p' ~/.cache/wal/colors | cut -c 2-)
openrgb --noautoconnect -d 0 -z 1 -m "Static" -c $hex -b 80

if [ -s ~/.config/wallpaper.png ]; then
	rm ~/.config/wallpaper.png
fi
cp $1 ~/.config/wallpaper.png

read -p "updating home-manager, continue? [y/n] " response && [[ $response == "y" ]] && echo "continuing" || exit 0

home-manager switch --flake ~/.config/home-manager/
'';

executable = true;
}
