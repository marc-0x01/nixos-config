{ lib
, fetchurl
, makeWrapper
, stdenv
, undmg
, variant ?
  if (stdenv.isDarwin && stdenv.isAarch64)
  then "arm64"
  else if (stdenv.isDarwin && stdenv.isx86_64)
  then "x86_64"
  else "undifined"
}:

assert builtins.elem variant [ "arm64" "x86_64" ];
stdenv.mkDerivation (finalAttrs: {
  pname = "qutebrowser-bin-${variant}";
  version = "3.2.1";

  src = fetchurl {
    url = "https://github.com/qutebrowser/qutebrowser/releases/download/v${finalAttrs.version}/qutebrowser-${finalAttrs.version}-${variant}.dmg";
    hash = {
      "arm64" = "sha256-HNEXLXy1rgHiD97JyOEuBuZAeGjge1wvHgo9esZZKCY=";
      "intel64" = "sha256-mOtwN5435O5eZk58mfHa0eW2GNAM1QWVtGoXz9KaBxo=";
    }.${variant};
  };

  sourceRoot = ".";

  nativeBuildInputs = [
    makeWrapper
    undmg
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/Applications $out/bin
    cp -r "qutebrowser.app" $out/Applications
    makeWrapper "$out/Applications/qutebrowser.app/Contents/MacOS/qutebrowser" "$out/bin/qutebrowser"

    runHook postInstall
  '';

  meta = with lib; {
    description = "A keyboard-driven, vim-like browser based on Python and Qt; precompiled binary for MacOS, repacked from official website";
    homepage    = "https://github.com/qutebrowser/qutebrowser";
    changelog   = "https://github.com/qutebrowser/qutebrowser/blob/v${version}/doc/changelog.asciidoc";
    license     = licenses.gpl3Plus;
    mainProgram = "qutebrowser";
    maintainers = with maintainers; [ mguillen ];
    platforms   = systems.inspect.patternLogicalAnd
      (systems.inspect.patterns.isDarwin)
      (({
        "arm64" = systems.inspect.patterns.isAarch64;
        "intel64" = systems.inspect.patterns.isx86_64;
      }).${variant});
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
})