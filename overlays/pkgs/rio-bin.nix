{ lib
, fetchurl
, makeWrapper
, stdenv
, undmg
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "rio-bin";
  version = "0.1.7";

  src = fetchurl {
    url = "https://github.com/rapahmorim/rio/releases/download/v${finalAttrs.version}/Rio-v${finalAttrs.version}.dmg";
    hash = "sha256-x+5frYncXhJXX6UY/ovozVqAUXugqWNAClxiW+N76to=";
  };

  sourceRoot = ".";

  nativeBuildInputs = [
    makeWrapper
    undmg
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/Applications $out/bin
    cp -r "Rio.app" $out/Applications
    makeWrapper "$out/Applications/Rio.app/Contents/MacOS/rio" "$out/bin/rio"

    runHook postInstall
  '';

  meta = with lib; {
    description = "";
    homepage    = "https://github.com/raphamorim/rio";
    changelog   = "https://github.com/raphamorim/rio/blob/v${version}/CHANGELOG.md";
    license     = licenses.mit;
    mainProgram = "rio";
    maintainers = with maintainers; [ mguillen ];
    platforms   = systems.inspect.patterns.isAarch64;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
})