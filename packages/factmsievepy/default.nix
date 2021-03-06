{ stdenvNoCC, msieve, ggnfs, python2 }:

let
  pname = "factmsievepy";
  version = "0.86";
in

stdenvNoCC.mkDerivation {
  inherit pname version;
  inherit msieve ggnfs;

  src = ./factmsieve.py;

  buildInputs = [ msieve ggnfs python2 ];

  unpackPhase = ''
    runHook preUnpack

    cp $src factmsieve.py

    runHook postUnpack
  '';

  patchPhase = ''
    runHook prePatch

    sed -i 's/\r//g'                                                                   factmsieve.py
    sed -i -e '1s|^|#!${python2}/bin/python\n|'                                        factmsieve.py
    sed -i -e "s|  al = {} if VERBOSE else {'creationflags' : 0x08000000 }|  al = {}|" factmsieve.py
    sed -i -e "s|^GGNFS_PATH = .*$|GGNFS_PATH = '${ggnfs}/bin/'|"                      factmsieve.py
    sed -i -e "s|^MSIEVE_PATH = .*$|MSIEVE_PATH = '${msieve}/bin/'|"                   factmsieve.py
    sed -i -e 's|^NUM_CORES = .*$|NUM_CORES = 4|'                                      factmsieve.py
    sed -i -e 's|^THREADS_PER_CORE = .*$|THREADS_PER_CORE = 1|'                        factmsieve.py
    sed -i -e 's|^USE_CUDA = .*$|USE_CUDA = False|'                                    factmsieve.py
    sed -i -e 's|^MSIEVE_POLY_TIME_LIMIT = .*$|MSIEVE_POLY_TIME_LIMIT = 0|'            factmsieve.py
    sed -i -e 's|^VERBOSE = .*$|VERBOSE = False|'                                      factmsieve.py

    runHook postPatch
  '';

  installPhase = ''
    runHook preInstall

    install -Dt $out/bin -m755 factmsieve.py

    runHook postInstall
  '';
}
