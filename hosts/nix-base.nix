{ pkgs, ... }:

{

  imports = [ ../cachix.nix ];

  # Set your time zone.
  time = { timeZone = "America/New_York"; };

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      extra-platforms = aarch64-darwin
      trusted-users = root sra
    '';
  };

  nixpkgs = {
    config = { allowUnfree = true; };
  };

  environment = {
    systemPackages = with pkgs; [
      neovim
      atuin
      cachix
      ripgrep
      fd
      gitui
      rclone
      #python3
      #(python3.withPackages (ps: with ps; [
        #pandas
      #]))

    ];
    pathsToLink = [ "/share/zsh" ];
  };

  fonts.fonts = with pkgs; [
    dejavu_fonts
    nerdfonts#3.1.1
    #iosevka-nerdfont
    #fira-code-nerdfont
    #hack-font
    font-awesome
  ];

  programs = {
    zsh = { enable = true; };
  };
}
