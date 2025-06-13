let
  nixpkgs = import ../nix/release.nix;
  monorepo-pkgs = import ../nix/default.nix;
in
  nixpkgs.haskellPackages.shellFor {
    packages = p: builtins.attrValues monorepo-pkgs;
    buildInputs = [
      nixpkgs.haskellPackages.cabal-install
      nixpkgs.haskellPackages.fourmolu
      nixpkgs.haskellPackages.ghcid
      nixpkgs.haskellPackages.hlint
    ];
  }
