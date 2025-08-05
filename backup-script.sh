cp -f /etc/nixos/configuration.nix $HOME/backup/nixos
cp -f ~/.config/hypr/hyprland.conf $HOME/backup/configs
cp -f ~/.config/libinput-gestures.conf $HOME/backup/configs

cd $HOME/backup
git add *
git commit -m "backup"
git push
