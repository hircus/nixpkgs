args: with args; 
stdenv.mkDerivation {
  name = "guile-1.8.3";
  src = fetchurl {
		url = ftp://ftp.gnu.org/gnu/guile/guile-1.8.3.tar.gz;
		sha256 = "2ab59099cf2d46f57cf5421c9b84aa85f61961640046e8066c6b321257517796";
	};

  patches = [ ./snarf-tmpdir.patch ];

  buildInputs = [ makeWrapper ];
  propagatedBuildInputs = [readline libtool gmp gawk];

  postInstall = ''
    wrapProgram $out/bin/guile-snarf --prefix PATH : "${gawk}/bin"
  '';

  setupHook = ./setup-hook.sh;
}
