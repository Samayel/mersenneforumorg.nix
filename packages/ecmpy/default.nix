{ stdenvNoCC, ecm, python2 }:

let
  pname = "ecmpy";
  version = "0.44";
in

stdenvNoCC.mkDerivation {
  inherit pname version;
  inherit ecm;

  src = ./ecm.py;

  buildInputs = [ ecm python2 ];

  unpackPhase = ''
    runHook preUnpack

    cp $src ecm.py

    runHook postUnpack
  '';

  patchPhase = ''
    runHook prePatch

    sed -i -e '1s|^|#!${python2}/bin/python2\n|'                ecm.py
    sed -i -e "s|^ECM_PATH = .*$|ECM_PATH = '${ecm}/bin'|"      ecm.py
    sed -i -e 's|^ECM_THREADS = .*$|ECM_THREADS = 4|'           ecm.py

    runHook postPatch
  '';

  installPhase = ''
    runHook preInstall

    install -Dt $out/bin -m755 ecm.py

    runHook postInstall
  '';
}
