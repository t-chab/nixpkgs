{ stdenv, osx_private_sdk, CF }:

stdenv.mkDerivation {
  name = "${CF.name}-private";
  phases = [ "installPhase" "fixupPhase" ];
  installPhase = ''
    dest=$out/Library/Frameworks/CoreFoundation.framework/Headers
    mkdir -p $dest
    pushd $dest
      cp -R ${osx_private_sdk}/CocoaFoundationHeaders/* $dest/
      for file in ${CF}/Library/Frameworks/CoreFoundation.framework/Headers/*; do
        cp $file .
      done
    popd

  '';

  setupHook = ./setup-hook.sh;
}
