{ pkgs, username, ... }:

{
  imports = [ ../base.nix ];

  home-manager.users.${username} = { pkgs, ... }: {
    home = {
      packages = with pkgs; [
        slack
      ];
    };

    programs = {
      git = {
        extraConfig = {
          credential = { helper = "osxkeychain"; };
          branch = { autosetupmerge = true; };
        };
      };
      firefox = {
        package = pkgs.runCommand "firefox-0.0.0" { } "mkdir $out";
        profiles = {
          sra = {
            userChrome = ''
              #TabsToolbar { visibility: collapse !important; }

              #sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] #sidebar-header {
                  display:none;
              }
            '';
          };
        };
      };
    };
  };
}
