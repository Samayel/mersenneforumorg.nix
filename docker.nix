pkgs:

let

  contents = with pkgs; [
    qshell

    aliqueit
    cado-nfs
    ecm-git
    msieve-svn
    primecount
    primesieve
    primesum
    yafu
  ];

in

pkgs.dockerTools.buildLayeredImage {
  name = "mersenneforumorg-docker";
  tag = "latest";

  inherit contents;

  config = {
    Cmd = [ "${pkgs.bashInteractive}/bin/bash" ];
  };
}
