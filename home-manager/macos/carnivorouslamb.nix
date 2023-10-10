{ pkgs, username, ... }:

{
  imports = [ ./work.nix ];

  home-manager.users.${username} = { pkgs, ... }: {
    programs = {
      zsh = {
        initExtra = ''
          SSH_AUTH_SOCK=/Users/scottanderson/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
        '';
      };
      alacritty = {
        settings = {
          font = {
            size = 16;
          };
        };
      };
    };
  };
}
