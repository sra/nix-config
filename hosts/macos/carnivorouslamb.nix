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
      "modularml/packages"
      "turbot/tap"
    ];

    brews = [
      # "syncthing"
      "teller"
      "kcat"
      "llm"
      "ansible"
      "tmctl"
      "logcli"
      "mirrord"
      "modular"
      "eksctl"
      "kubeshark"
      "k8sgpt"
      "pipx"
      "steampipe"
      "powerpipe"
      "flowpipe"
    ];

    casks = [
      #"lunarvim"
      "1password"
      "1password-cli"
      "betterdisplay"
      "brave-browser"
      "cursor"
      "drata-agent"
      "firefox"
      "google-drive"
      "iterm2"
      "jetbrains-toolbox"
      "keepassxc"
      "lm-studio" # hash mismatch
      "logi-options-plus"
      "logseq"
      "ollama"
      "orbstack"
      "mqttx"
      "raycast"
      "setapp"
      "slack-cli"
      "spotify"
      "tailscale"
      "via"
      "vivaldi"
      "vlc"
      "warp"
      "zed"
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
