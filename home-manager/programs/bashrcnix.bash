alias fucking='sudo'

alias resys='sudo nixos-rebuild switch --flake /etc/nixos#default'
alias rehome='home-manager switch --flake ~/.config/home-manager/'
alias cleanup='sudo nix-collect-garbage -d'

alias ramdisk='[ ! -d ~/ramdisk ] && mkdir ~/ramdisk && sudo mount -t tmpfs -o size=20G tmpfs ~/ramdisk'
alias unramdisk='sudo umount ~/ramdisk && [ ! -d ~/ramdisk ] || rm -r ~/ramdisk'

alias encrypt='gpg --symmetric --cipher-algo AES256 --pinentry-mode loopback --output' # (encrypted name, decrypted name)
alias decrypt='gpg --decrypt --pinentry-mode loopback --output' # (decrypted name, encrypted name)
alias usage='echo "decrypt <new name> <file to decrypt>  encrypt <new name> <file to encrypt>"'

alias afk="(trap 'kill 0' SIGINT; cbonsai -Sm 'afk' -c 󰲓 & mpg123 --loop 1 -f 4096 ~/.config/afk.mp3 1> /dev/null 2>&1 & wait)"
alias pasteimg='wl-paste > img.png'
alias nv='nvim'
alias snv='sudo nvim'


vid_trim() {
  for input in "$@"; do
    [ -f "$input" ] || { echo "File not found: $input"; continue; }

    dur=$(ffprobe -v error -show_entries format=duration \
          -of csv=p=0 "$input")

    if awk -v d="$dur" 'BEGIN { exit (d >= 3) }'; then
      echo "Skipping $input: Video too short (${dur}s)"
      continue
    fi

    start=1.5
    clip_dur=$(awk -v d="$dur" -v s="$start" \
               'BEGIN { printf("%.2f", d - s - 1.5) }')

    output="trimmed.mp4"

    ffmpeg -nostdin \
      -ss "$start" \
      -i "$input" \
      -t "$clip_dur" \
      -c:v libx264 \
      -c:a aac \
      -movflags +faststart \
      "$output" \
      && echo "Created: $output" \
      || echo "Failed to trim $input"
  done
}

vid_compress() {
  for input in "$@"; do
    [ -f "$input" ] || { echo "File not found: $input"; continue; }
    dur=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$input")
    if [ -z "$dur" ]; then
      echo "Could not get duration for $input"
      continue
    fi

    target_size=10000000
    audio_bitrate_kbps=128
    total_bits=$(awk -v s="$target_size" 'BEGIN { print s * 8 }')
    audio_bits=$(awk -v d="$dur" -v b="$audio_bitrate_kbps" 'BEGIN { print d * b * 1000 }')
    video_bits=$(awk -v t="$total_bits" -v a="$audio_bits" 'BEGIN { print t - a }')
    if awk -v v="$video_bits" 'BEGIN { exit (v <= 0) ? 0 : 1 }'; then
      echo "Cannot compress $input: required video bitrate is negative or zero."
      continue
    fi

    video_bitrate=$(awk -v v="$video_bits" -v d="$dur" 'BEGIN { print v / d }')
    video_bitrate_kbps=$(awk -v v="$video_bitrate" 'BEGIN { printf "%.2f", v / 1000 }')
    output="compressed.mp4"
    passlog="/tmp/vid_compress_pass"

    ffmpeg -y -i "$input" \
      -c:v libx264 -b:v "${video_bitrate_kbps}k" \
      -pass 1 -passlogfile "$passlog" -an -f null - \
      || { echo "First pass failed for $input"; continue; }

    ffmpeg -i "$input" \
      -c:v libx264 -b:v "${video_bitrate_kbps}k" \
      -pass 2 -passlogfile "$passlog" \
      -c:a aac -b:a "${audio_bitrate_kbps}k" \
      "$output" \
      || { echo "Second pass failed for $input"; continue; }

    echo "Compressed: $output"

    rm -f "${passlog}-0.log" "${passlog}-0.log.mbtree"
  done
}

vid_prepare() {
  if [ $# -ne 1 ]; then
    echo "Usage: vid_prepare input.mp4"
    return 1
  fi

  local input="$1"

  if [ ! -f "$input" ]; then
    echo "File not found: $input"
    return 1
  fi

  vid_trim "$input"

  local to_compress="$input"
  if [ -f "trimmed.mp4" ]; then
    to_compress="trimmed.mp4"
  fi

  vid_compress "$to_compress"

  if [ ! -f "compressed.mp4" ]; then
    echo "Compression did not produce an output file."
    [ "$to_compress" = "trimmed.mp4" ] && rm -f "trimmed.mp4"
    return 1
  fi

  local output="prepared.mp4"
  mv "compressed.mp4" "$output"
  if [ $? -ne 0 ]; then
    echo "Failed to rename compressed.mp4 to $output"
    # cleanup intermediate files
    [ "$to_compress" = "trimmed.mp4" ] && rm -f "trimmed.mp4"
    rm -f "compressed.mp4"
    return 1
  fi

  if [ "$to_compress" = "trimmed.mp4" ]; then
    rm -f "trimmed.mp4"
  fi

  echo "Created: $output"
}


alias wals='~/.config/walpset.sh'
alias py='python'

# for go tools
export PATH="$PATH:$HOME/go/bin"
# for my own executables
export PATH="$PATH:$HOME/userbin"

eval "$(starship init bash)"
eval "$(zoxide init bash --cmd cd)"
