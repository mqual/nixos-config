{
  description = "Haxfn's Unified NixOS and Home Manager Flake";

  inputs = {
    # We use nixos-unstable to match your 25.11 stateVersion intent
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # This replaces your builtins.getFlake call for ki-editor
    ki-editor.url = "github:ki-editor/ki-editor";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ki-editor,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; }; # Passes 'inputs' (like ki-editor) to your modules
        modules = [
          ./configuration.nix

          # This nests Home Manager inside the NixOS rebuild process
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = { inherit inputs; };

            home-manager.users.haxfn = import ./home.nix;
          }
        ];
      };
    };
}
