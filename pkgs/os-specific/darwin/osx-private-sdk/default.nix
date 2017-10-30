{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  name = "OSXPrivateSDK";

  src = fetchFromGitHub {
    owner = "samdmarshall";
    repo = "OSXPrivateSDK";
    rev = "f4d52b60e86b496abfaffa119a7d299562d99783";
    sha256 = "0bv0884yxpvk2ishxj8gdy1w6wb0gwfq55q5qjp0s8z0z7f63zqh";
  };

  # NOTE: we install only headers that are really needed to keep closure sie
  # reasonable.
  installPhase = ''
    mkdir -p $out/include
    cp PrivateSDK10.10.sparse.sdk/usr/local/include/sandbox/private.h $out/include/sandbox_private.h
    cp -R PrivateSDK10.10.sparse.sdk/System/Library/Frameworks/Security.framework/Versions/A/PrivateHeaders $out/include/SecurityPrivateHeaders
    cp -R PrivateSDK10.10.sparse.sdk/System/Library/Frameworks/CoreFoundation.framework/Headers $out/include/CoreFoundationPrivateHeaders
    cp -R PrivateSDK10.10.sparse.sdk/usr/include/xpc $out/include/
    cp -R PrivateSDK10.10.sparse.sdk/usr/local/include/bsm $out/include/bsm
  '';
}
