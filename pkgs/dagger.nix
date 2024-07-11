{ buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "dagger";
  version = "0.11.9";

  src = fetchFromGitHub {
    owner = "jesseduffield";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-w5QL+CuMYyTTnNAfWF8jQuQWfjxaw7bANK69Dc+onGk=";
  };
}
