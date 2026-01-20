cp -f /etc/nixos/configuration.nix $HOME/backup/nixos # nixos
cp -f ~/.config/hypr/hyprland.conf $HOME/backup/configs # hyprland
cp -f ~/.config/libinput-gestures.conf $HOME/backup/configs # touchpad
cp -f ~/.config/rofi/config.rasi $HOME/backup/configs # rofi menu
 
cd $HOME/backup
git add *
git commit -m "backup"
git push
