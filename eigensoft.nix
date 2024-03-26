{
  pkgs,
  stdenv,
  fetchFromGitHub,
  lib,
}:
stdenv.mkDerivation {
  pname = "eigensoft";
  version = "8.0.0";

  src = fetchFromGitHub {
    owner = "DReichLab";
    repo = "EIG";
    rev = "v8.0.0";
    hash = "sha256-6Ac8fbqAVf6qxFf9wGrKzvpSNkm9IyaAPoBEBpUWZv0=";
  };

  buildInputs = with pkgs; [
    gsl
    lapack
    openblas
  ];

  buildPhase = ''
    pushd src
    make all
    popd
  '';

  installPhase = ''
    pushd src
    make install
    popd
    mkdir -p $out/bin
    mv -t $out/bin bin/*
  '';

  meta = with lib; {
    description = "";
    # license = "";
    homepage = "";
  };
}
