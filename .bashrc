alias fucking='sudo'

alias resys='sudo nixos-rebuild switch --flake /etc/nixos#default'
alias rehome='home-manager switch --flake ~/.config/home-manager/'
alias cleanup='sudo nix-collect-garbage -d'

alias nv='nvim'
alias snv='sudo nvim'

alias wals='~/.config/walpset.sh'
alias py='python'

eval "$(starship init bash)"
eval "$(zoxide init bash --cmd cd)"
