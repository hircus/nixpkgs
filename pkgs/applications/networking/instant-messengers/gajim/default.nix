a :  
let 
  fetchurl = a.fetchurl;

  version = a.lib.attrByPath ["version"] "0.14.1" a; 
  buildInputs = with a; [
    python pyGtkGlade gtk perl intltool dbus gettext
    pkgconfig makeWrapper libglade pyopenssl libXScrnSaver
    libXt xproto libXext xextproto libX11 gtkspell aspell
    scrnsaverproto pycrypto pythonDBus pythonSexy 
    docutils
  ];
in
rec {
  src = fetchurl {
    url = "http://www.gajim.org/downloads/0.14/gajim-${version}.tar.gz";
    sha256 = "ef757572acf3f3d59408fd95b7ec99bc0e39c5b8c66bc61c78ba65e71c3d8e18";
  };

  inherit buildInputs;
  configureFlags = [];

  preConfigure = a.fullDepEntry (''
    export PYTHONPATH="$PYTHONPATH''${PYTHONPATH:+:}$(toPythonPath ${a.pyGtkGlade})/gtk-2.0"
    export PYTHONPATH="$PYTHONPATH''${PYTHONPATH:+:}$(toPythonPath ${a.pygobject})/gtk-2.0"
    sed -e '/-L[$]x_libraries/d' -i configure
  '') ["addInputs" "doUnpack"];

  fixScriptNames = a.fullDepEntry (''
    mkdir "$out"/bin-wrapped
    for i in "$out"/bin/.*-wrapped; do
      name="$i"
      name="''${name%-wrapped}"
      name="''${name##*/.}"
      mv "$i" "$out/bin-wrapped/$name"
      sed -e 's^'"$i"'^'"$out/bin-wrapped/$name"'^' -i "$out/bin/$name"
    done
  '') ["wrapBinContentsPython"];

  /* doConfigure should be removed if not needed */
  phaseNames = ["preConfigure" (a.doDump "1") "doConfigure" "doMakeInstall" "wrapBinContentsPython" "fixScriptNames"];

  name = "gajim-" + version;
  meta = {
    description = "Jabber client with meta-contacts";
    maintainers = [a.lib.maintainers.raskin];
  };
}
