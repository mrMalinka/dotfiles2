status=$(playerctl status -f "{{ uc(status) }}")

if [ $? -ne 0 ]; then
	echo '{"text": ""}' | jq --unbuffered --compact-output .
	exit
fi

if [ "$status" == "PLAYING" ]; then
	echo '{"text": ""}' | jq --unbuffered --compact-output .
elif [ "$status" == "PAUSED" ]; then
	echo '{"text": ""}' | jq --unbuffered --compact-output .
elif [ "$status" == "STOPPED" ]; then
	echo '{"text": ""}' | jq --unbuffered --compact-output .
else
	echo '{"text": ""}' | jq --unbuffered --compact-output .
fi
