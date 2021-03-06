version: final: prev:

with final; {

  ecm-git = callPackage ./packages/ecm-git { };

  msieve-svn = callPackage ./packages/msieve-svn { ecm = ecm-git; zlib = null; };
  ggnfs = callPackage ./packages/ggnfs { };
  ytools = callPackage ./packages/ytools { };
  ysieve = callPackage ./packages/ysieve { };
  yafu-unwrapped = callPackage ./packages/yafu-unwrapped { ecm = ecm-git; msieve = msieve-svn; };
  yafu = callPackage ./packages/yafu { };

  ecmpy = callPackage ./packages/ecmpy { ecm = ecm-git; };
  factmsievepy = callPackage ./packages/factmsievepy { msieve = msieve-svn; };
  aliqueit-unwrapped = callPackage ./packages/aliqueit-unwrapped { ecm = ecm-git; msieve = msieve-svn; };
  aliqueit = callPackage ./packages/aliqueit { };

  cado-nfs = callPackage ./packages/cado-nfs { ecm = ecm-git; };

  # primesieve = callPackage ./packages/primesieve { };
  # primecount = callPackage ./packages/primecount { };  ---  rebuilds / breaks sage via primecountpy
  # primesum = callPackage ./packages/primesum { };

  mersenneforumorg = buildEnv
    {
      name = "mersenneforumorg-${version}";
      paths = [
        aliqueit
        cado-nfs
        ecm-git
        ecmpy
        factmsievepy
        ggnfs
        gmp
        msieve-svn
        # primecount
        # primesieve
        # primesum
        yafu
        ysieve
        ytools
      ];
    };

}
