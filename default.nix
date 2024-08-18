{pkgs ? import <nixpkgs> {}}: let
  beagle = pkgs.callPackage ./beagle.nix {};
  eigensoft = pkgs.callPackage ./eigensoft.nix {};
in
  pkgs.buildEnv {
    name = "bioinfo-tools";
    paths =
      [
        beagle
        eigensoft
      ]
      ++ (with pkgs; [
        bcftools
        picard-tools
        plink-ng
        samtools
      ]);
  }
