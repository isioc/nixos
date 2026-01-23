cp -f /etc/nixos/configuration.nix $HOME/backup/nixos # nixos
cp -f ~/.config/hypr/hyprland.conf $HOME/backup/configs # hyprland
cp -f ~/.config/libinput-gestures.conf $HOME/backup/configs # touchpad
cp -f ~/.config/wofi/config $HOME/backup/configs # wofi conf
cp -f ~/.config/wofi/style.css $HOME/backup/configs # wofi style conf

cd $HOME/backup
git add *
git commit -m "backup"
git push
