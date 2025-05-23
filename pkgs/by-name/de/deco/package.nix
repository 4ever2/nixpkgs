{
  lib,
  stdenv,
  fetchFromGitHub,
  scsh,
  feh,
  xorg,
}:

stdenv.mkDerivation {
  pname = "deco";
  version = "unstable-2019-04-03";

  src = fetchFromGitHub {
    owner = "ebzzry";
    repo = "deco";
    rev = "dd8ec7905bc85d085eb2ee3bddabea451054288c";
    sha256 = "sha256-/3GeNvWOCRPOYTUbodXDUxR5QVDEyx6x2Jt5PxsPdvk=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp deco $out/bin
    chmod +x $out/bin/deco
  '';

  postFixup = ''
    substituteInPlace $out/bin/deco --replace "/usr/bin/env scsh" "${scsh}/bin/scsh"
    substituteInPlace $out/bin/deco --replace "feh" "${feh}/bin/feh"
    substituteInPlace $out/bin/deco --replace "xdpyinfo" "${xorg.xdpyinfo}/bin/xdpyinfo"
  '';

  meta = with lib; {
    homepage = "https://github.com/ebzzry/deco";
    description = "Simple root image setter";
    license = licenses.mit;
    maintainers = [ maintainers.ebzzry ];
    platforms = platforms.unix;
    mainProgram = "deco";
  };

  dontBuild = true;
}
