# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # wireguard
  networking.wg-quick.interfaces = {
    wg0 = {
      configFile = "/etc/wireguard/SI_wg0.conf";
      autostart = true;
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "ru";
    variant = "ruchey_ru";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.c = {
    isNormalUser = true;
    description = "c";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "input"
      "pipewire"
      "video"];
    packages = with pkgs; [];
  };

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # packages installed
  environment.systemPackages = with pkgs; [

  kitty # terminal
  waybar # taskbar
  wofi # menu
  networkmanagerapplet # network
  blueberry # bluetooth
  git

  # touchpad
  libinput
  libinput-gestures

  # basic programs
  firefox
  telegram-desktop
  discord

  # joycons
  joycond

  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  # steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # joycons
  services.joycond.enable = true;
  boot.kernelModules = [ "joycond" "hid-nintendo" ];

  # hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # hyprland folder
  systemd.tmpfiles.rules = [
    "d /tmp/hypr 0770 root root -"
  ];

  # graphics
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true; # for steam ig
  };

  # sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # bluetooth
  hardware.bluetooth.enable = true;

  # touchpad
  services.xserver.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      tapping = true;
      disableWhileTyping = true;
    };
  };

  environment.sessionVariables = {
    LIBINPUT_ACCEL_PROFILE = "flat";
  };

  services.udev.extraRules = ''
    KERNEL=="event*", GROUP="input", MODE="0660"
  '';

  # aliases
  programs.bash = {
#    enable = true;
    shellAliases = {
      b2g="~/backup/backup-script.sh";
      nixrs="sudo nixos-rebuild switch";
      nixclean="sudo nix-collect-garbage -d";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
