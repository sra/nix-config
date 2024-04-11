{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR/master";
    };
  };

  outputs = { self, nixpkgs, darwin,  nur, home-manager, ... }@inputs:
    let
      machost = { system, host, username ? "sra" }:
        darwin.lib.darwinSystem {
          inherit system;
          modules = [
            ./hosts/macos/${host}.nix { nixpkgs.overlays = [ ]; }
            home-manager.darwinModules.home-manager
            ./home-manager/macos/${host}.nix
          ];
          specialArgs = {
            inherit username;
            x86pkgs = import nixpkgs {
              system = "aarch64-darwin";
              overlays = [ ];
            };
            nur = import nur {
              pkgs = import nixpkgs { inherit system; };
              nurpkgs = import nixpkgs { inherit system; };
            };
          };
        };
      nixoshost = { system, host, username ? "sra" }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/nixos/${host}
            home-manager.nixosModules.home-manager
            ./home-manager/nixos/${host}.nix
          ];
          specialArgs = {
            inherit username;
            inherit inputs;
            pkgs = import nixpkgs { inherit system; overlays = [ ]; };
            nur = import nur {
              pkgs = import nixpkgs { inherit system; };
              nurpkgs = import nixpkgs { inherit system; };
            };
          };
        };
      rpihost = { host }:
        nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
            (
              let
                pkgs = nixpkgs.legacyPackages.aarch64-linux;
              in
              {
                system.stateVersion = "23.05";
                nixpkgs = {
                  buildPlatform.system = "x86_64-linux";
                  hostPlatform.system = "aarch64-linux";
                };
                networking = {
                  wireless.enable = true;
                };
                console = {
                  earlySetup = true;
                  packages = with pkgs; [ terminus_font ];
                  font = nixpkgs.lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
                };
                users.users.sra = {
                  isNormalUser = true;
                  home = "/home/sra";
                  description = "Scott";
                  extraGroups = [ "wheel" "networkmanager" ];
                  hashedPassword = "";
                };
              }
            )
          ];
        };
    in
    {
      devShell =
        let
          pkglist = pkgs: [
            pkgs.nixfmt
            pkgs.nixpkgs-fmt
          ];
        in
        inputs.nixpkgs.lib.listToAttrs (map
          (system: {
            name = system;
            value = nixpkgs.legacyPackages.${system}.mkShell {
              nativeBuildInputs = pkglist nixpkgs.legacyPackages.${system};
            };
          }) [ "x86_64-darwin" "x86_64-linux" "aarch64-darwin" ]);
      nixosConfigurations = {
        #sanchez = nixoshost { system = "x86_64-linux"; host = "sanchez"; };
        #rossi = nixoshost { system = "x86_64-linux"; host = "rossi"; };
        #rpi = rpihost { host = "test"; };
      };
      darwinConfigurations = {
        lamb = machost { system = "aarch64-darwin"; host = "lamb"; };
        carnivorouslamb = machost { system = "aarch64-darwin"; host = "carnivorouslamb"; username = "scottanderson";};
        #socrates = machost { system = "x86_64-darwin"; host = "socrates"; };
        #careca = machost { system = "aarch64-darwin"; host = "careca"; username = "matthew.ryall"; };
        #platini = machost { system = "x86_64-darwin"; host = "platini"; };
        #robson = machost { system = "x86_64-darwin"; host = "robson"; };
      };

    };
}
