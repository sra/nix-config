{ pkgs, username, ... }:

{
  imports = [ ./work.nix ];

  home-manager.users.${username} = { pkgs, ... }: {
    programs = {
      zsh = {
        initExtra = ''
          export SSH_AUTH_SOCK=/Users/scottanderson/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
          export AWS_VAULT_PROMPT="osascript";
          export AWS_VAULT_KEYCHAIN_NAME="login";
        '';
      };
      alacritty = {
        settings = {
          font = {
            size = 18;
          };
        };
      };
    };
  };
}
