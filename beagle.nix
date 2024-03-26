{
  stdenvNoCC,
  fetchurl,
  makeWrapper,
  jre,
  lib,
}:
stdenvNoCC.mkDerivation rec {
  pname = "beagle";
  # version = "5.4";
  version = "01Mar24.d36";

  src = fetchurl {
    url = "http://faculty.washington.edu/browning/${pname}/${pname}.${version}.jar";
    sha256 = "AmUQygJXDG2+77DUO2rXWJZotsv2QORfs0UCfxeTUdw=";
  };

  nativeBuildInputs = [makeWrapper];
  buildInputs = [jre];

  dontUnpack = true;

  installPhase = ''
    mkdir -pv $out/share/java
    cp $src $out/share/java/${pname}.jar

    mkdir -pv $out/bin
    makeWrapper ${jre}/bin/java $out/bin/beagle --add-flags "-jar $out/share/java/${pname}.jar"
  '';

  meta = {
    description = "Beagle is a software package for phasing genotypes and imputing ungenotyped markers.";
    license = lib.licenses.gpl3;
    homepage = "http://faculty.washington.edu/browning/beagle/beagle.html";
    mainProgram = "beagle";
  };
}
