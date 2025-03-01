{ ... }:

# yes i know i should be doing it with shellAliases and whatnot but this is much cleaner
{

home.file.".bashrc".text = ''
alias fucking='sudo'

alias resys='sudo nixos-rebuild switch --flake /etc/nixos#default'
alias rehome='home-manager switch --flake ~/.config/home-manager/'
alias cleanup='sudo nix-collect-garbage -d'

alias nv='nvim'
alias snv='sudo nvim'

alias ramdisk='[ ! -d ~/ramdisk ] && mkdir ~/ramdisk && sudo mount -t tmpfs -o size=1G tmpfs ~/ramdisk'
alias unramdisk='sudo umount ~/ramdisk && [ ! -d ~/ramdisk ] || rm -r ~/ramdisk'

alias encrypt='gpg --symmetric --cipher-algo AES256 --pinentry-mode loopback --output' # (encrypted name, decrypted name)
alias decrypt='gpg --decrypt --pinentry-mode loopback --output' # (decrypted name, encrypted name)
alias usage='echo "decrypt <new name> <file to decrypt>  encrypt <new name> <file to encrypt>"'

alias afk='cbonsai -Sm "afk" -c 󰲓'

alias pasteimg='wl-paste > img.png'

alias wals='~/.config/walpset.sh'
alias py='python'

eval "$(starship init bash)"
eval "$(zoxide init bash --cmd cd)"
'';

}
