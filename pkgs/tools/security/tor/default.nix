{ stdenv, fetchurl, libevent, openssl, zlib }:

stdenv.mkDerivation rec {
  name = "tor-0.2.2.35";

  src = fetchurl {
    url = "http://www.torproject.org/dist/${name}.tar.gz";
    sha256 = "f141a41fffd31494a0f96ebbb6b999eab33ce62d5c31f81222a0acd034adbf3a";
  };

#  patchPhase =
    # DNS lookups fail in chroots.
#    '' sed -i "src/or/test.c" -es/localhost/127.0.0.1/g
#    '';

  buildInputs = [ libevent openssl zlib ];

  doCheck = true;

  meta = {
    homepage = http://www.torproject.org/;
    description = "Tor, an anonymous network router to improve privacy on the Internet";

    longDescription=''
      Tor protects you by bouncing your communications around a distributed
      network of relays run by volunteers all around the world: it prevents
      somebody watching your Internet connection from learning what sites you
      visit, and it prevents the sites you visit from learning your physical
      location. Tor works with many of your existing applications, including
      web browsers, instant messaging clients, remote login, and other
      applications based on the TCP protocol.
    '';

    license="mBSD";

    maintainers =
      [ # Russell O’Connor <roconnor@theorem.ca> ?
	stdenv.lib.maintainers.ludo
      ];
    platforms = stdenv.lib.platforms.gnu;  # arbitrary choice
  };
}
