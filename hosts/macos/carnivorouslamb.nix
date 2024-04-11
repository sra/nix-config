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
      "triggermesh/cli"
      "metalbear-co/mirrord"
    ];

    brews = [
      # "syncthing"
      "teller"
      "llm"
      "ollama"
      "ansible"
      "mesheryctl"
      "tmctl"
      "logcli"
      "kamel"
      "mirrord"
      "eksctl"
      "ykman"
      "temporal"
    ];

    casks = [
      #"lunarvim"
      "betterdisplay"
      "firefox"
      "vivaldi"
      "brave-browser"
      "jetbrains-toolbox"
      "orbstack"
      "setapp"
      "1password"
      "1password-cli"
      "google-drive"
      "logseq"
      "logi-options-plus"
      "spotify"
      "tailscale"
      "iterm2"
      "slack-cli"
      "raycast"
      "via"
      "whisky"
      "drata-agent"
      "cursor"
      "zed"
      "keepassxc"
      #"lm-studio" # hash mismatch
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
