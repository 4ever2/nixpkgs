{ lib, mkCoqDerivation, which, coq
  , metacoq, version ? null }:

with lib; mkCoqDerivation {
  pname = "rust-extraction";
  repo = "coq-rust-extraction";
  owner = "AU-COBRA";
  domain = "github.com";

  inherit version;
  defaultVersion = with versions; switch [coq.coq-version metacoq.version] [
    { cases = ["8.17" "1.3.1-8.17"]; out = "0.1.0"; }
    { cases = ["8.18" "1.3.1-8.18"]; out = "0.1.0"; }
    { cases = ["8.19" "1.3.1-8.19"]; out = "0.1.0"; }
  ] null;

  release."0.1.0".sha256 = "+Of/DP2Vjsa7ASKswjlvqqhcmDhC9WrozridedNZQkY=";
  release."0.1.0".rev = "v0.1.0";

  releaseRev = v: "v${v}";

  propagatedBuildInputs = [ coq.ocamlPackages.findlib metacoq ];

  patchPhase = ''
    patchShebangs ./process_extraction.sh
    patchShebangs ./tests/process-extraction-examples.sh
  '';

  mlPlugin = true;

  meta = {
    description = "A framework for extracting Coq programs to Rust";
    maintainers = with maintainers; [ _4ever2 ];
    license = licenses.mit;
  };
}
