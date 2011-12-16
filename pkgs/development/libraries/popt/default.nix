{stdenv, fetchurl}:

stdenv.mkDerivation {
  name = "popt-1.16";

  src = fetchurl {
    url = "http://rpm5.org/files/popt/popt-1.16.tar.gz";
    sha256 = "1j2c61nn2n351nhj4d25mnf3vpiddcykq005w2h6kw79dwlysa77";
  };

  meta = {
    description = "command line option parsing library";
  };

}
