{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-25.05 branch here
    nixGL.url = "github:nix-community/nixGL";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Kubelogin v1.9 issue with token
    nixpkgs-c5dd4393.url = "github:NixOS/nixpkgs/c5dd43934613ae0f8ff37c59f61c507c2e8f980d";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-c5dd4393,
      nixpkgs-unstable,
      nixGL,
      home-manager,
      self,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ nixGL.overlay ];
        config.allowUnfree = true;
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        overlays = [ nixGL.overlay ];
        config.allowUnfree = true;
      };
      pkgs-c5dd4393 = import nixpkgs-c5dd4393 {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      homeConfigurations."niels" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];
        extraSpecialArgs = {
          inherit pkgs-c5dd4393 pkgs-unstable self;
        };
      };
      packages.x86_64-linux.bootstrap = pkgs.writeShellApplication {
        name = "bootstrap";
        runtimeInputs = [
          pkgs.git
          pkgs.home-manager
        ];
        text = ''
          home-manager --extra-experimental-features nix-command --extra-experimental-features flakes switch -b backup 
        '';
      };
    };
}
