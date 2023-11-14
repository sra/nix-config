{ config, pkgs, ... }:

{
  imports = [ ../nix-base.nix ./darwin-base.nix ];

  networking = {
    hostName = "carnivorouslamb";
  };

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix = {
    settings = {
      max-jobs = 4;
      cores = 0;
    };
  };


  homebrew = {
    taps = [
      "homebrew/services"
    ];

    brews = [
      # "syncthing"
      "teller"
      "llm"
      "ollama"
    ];

    casks = [
      "firefox"
      "brave-browser"
      "jetbrains-toolbox"
      "orbstack"
      "setapp"
      "1password"
      "1password-cli"
      "google-drive"
      "logseq"
      "logi-options-plus"
      "reflect"
      "spotify"
      "tailscale"
      "iterm2"
      "slack-cli"
      "raycast"
      "via"
      "whisky"
      "drata-agent"
    ];
  };

  services = {
    skhd = {
      skhdConfig = ''
        lalt - 1: open -a ~/Applications/Homebrew\ Apps/Firefox.app
      '';
    };
  };
}
