{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nix-vscode-extensions, ... }@inputs:
    let
      system = "x86_64-linux";
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
           inherit system;
           config.allowUnfree = true;
        };
      };

      pkgs = nixpkgs.legacyPackages.${system};
      extensions = nix-vscode-extensions.extensions.${system};
      inherit (pkgs) vscode-with-extensions vscodium;

      vscodePkg = vscode-with-extensions.override {
        vscode = vscodium;
        vscodeExtensions = [
          extensions.open-vsx-release.rust-lang.rust-analyzer
          extensions.open-vsx.jnoortheen.nix-ide
        ];
      };
    in {
      ### Device configs :
      nixosConfigurations = {
        nuc = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
            ./base.nix
            ./hosts/nuc/default.nix
          ];
        };
      };


      ###

      packages.${system}.vscode = vscodePkg;

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [ vscodePkg ];
        shellHook = ''
          printf "VSCodium with extensions:\n"
          codium --list-extensions
        '';
      };
    };
}

