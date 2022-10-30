{ config, pkgs, ... }:

{
  imports = [ ../nix-base.nix ./darwin-base.nix ];

  networking.hostName = "platini";

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix = {
    settings = {
      max-jobs = 8;
      cores = 0;
    };
  };

  homebrew = {
    taps = [
      "homebrew/core"
      "homebrew/cask"
    ];

    brews = [
      "syncthing"
    ];

    casks = [
      "firefox"
      "mediaelch"
      "jaikoz"
      "steam"
      "origin"
      "spectacle"
    ];
  };

  services = {
    skhd = {
      skhdConfig = ''
        ralt - 1: open /run/current-system/Applications/kitty.app
        ralt - 2: open /run/current-system/Applications/Emacs.app
        ralt - 3: open -a /run/current-system/Applications/Homebrew\ Apps/Firefox.app
      '';
    };
  };
}
