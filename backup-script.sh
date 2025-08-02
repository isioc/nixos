cp -f /etc/nixos/configuration.nix $HOME/backup/nixos

cd $HOME/backup
git add *
git commit -m "backup"
git push
