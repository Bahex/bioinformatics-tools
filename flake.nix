{
  description = "ARTUSA Tools";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    # System types to support.
    supportedSystems = ["x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin"];

    # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    # Nixpkgs instantiated for supported system types.
    nixpkgsFor = forAllSystems (system:
      import nixpkgs {
        inherit system;
        config = {allowUnfree = true;};
      });
  in {
    packages = forAllSystems (system: let
      pkgs = nixpkgsFor.${system};
    in {
      beagle = pkgs.callPackage ./beagle.nix {};
      eigensoft = pkgs.callPackage ./eigensoft.nix {};
      default = pkgs.callPackage ./. {};
    });
  };
}
