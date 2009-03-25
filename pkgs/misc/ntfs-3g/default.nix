{stdenv, fetchurl, utillinux}:

stdenv.mkDerivation rec {
  pname = "ntfs-3g";
  version = "2009.2.1";
  name = "${pname}-${version}";

  src = fetchurl {
    url = "${meta.homepage}/${name}.tgz";
    sha256 = "1c3qhn0i5hlyk9dky5a4jnbfkyz73d3qpymblc8mhhx642nigbj7";
  };

  preConfigure = ''
    substituteInPlace src/Makefile.in --replace /sbin '@sbindir@' 
    substituteInPlace libfuse-lite/mount_util.c \
      --replace /bin/mount ${utillinux}/bin/mount \
      --replace /bin/umount ${utillinux}/bin/umount
  '';

  configureFlags = "--enable-shared --disable-static --disable-ldconfig --exec-prefix=\${prefix} --enable-mount-helper";

  meta = {
    homepage = http://www.ntfs-3g.org;
    description = "FUSE-base NTFS driver with full write support";
  };
}
