{ stdenv, fetchFromGitHub, lib, ... }:

stdenv.mkDerivation rec {
  name = "kubetail-${version}";
  version = "1.6.7";

  src = fetchFromGitHub {
    owner = "johanhaleby";
    repo = "kubetail";
    rev = "${version}";
    sha256 = "159162dazcr0gsq9mkwb7sf4psqq5iqqgavy2mc8qnpswdlq3pfc";
  };

  installPhase = ''
    install -Dm755 kubetail                 "$out/bin/kubetail"
    install -Dm755 completion/kubetail.bash "$out/share/bash-completion/completions/kubetail"
    install -Dm755 completion/kubetail.fish "$out/share/fish/vendor_completions.d/kubetail.fish"
    install -Dm755 completion/kubetail.zsh  "$out/share/zsh/site-functions/_kubetail"
  '';

  meta = with lib; {
    description = "Bash script to tail Kubernetes logs from multiple pods at the same time";
    longDescription = ''
      Bash script that enables you to aggregate (tail/follow) logs from
      multiple pods into one stream. This is the same as running "kubectl logs
      -f " but for multiple pods.
    '';
    homepage = https://github.com/johanhaleby/kubetail;
    license = licenses.asl20;
    maintainers = with maintainers; [ kalbasit ];
    platforms = platforms.all;
  };
}
