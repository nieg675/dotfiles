{ config, pkgs, self }:

{
  # TODO please change the username & home directory to your own
  home.username = "niels";
  home.homeDirectory = "/home/niels";

  home.file.".gitconfig".source = "${self}/gitconfig/.gitconfig" 

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
     #NVIM
     pkgs.gcc
     pkgs.stylua
     pkgs.nixfmt
     pkgs.shellcheck
     pkgs.pgformatter
     pkgs.sqlfluff
     pkgs.neovim

     # Core
     pkgs.google-chrome
     pkgs.gnumake
     pkgs.protobuf
     pkgs.direnv
     pkgs.nix-direnv
     pkgs.tree
     pkgs.git
     pkgs.ripgrep
     pkgs.fd
     pkgs.jq
     pkgs.tmux
     pkgs.gh

     # Misc
     pkgs.iosevka
     pkgs.nerd-fonts.symbols-only

     # Kubernetes
     pkgs.kubectl
     pkgs.kubelogin
     pkgs.kubernetes-helm
     pkgs.tilt
     pkgs.kind
     pkgs.ctlptl
     pkgs.kustomize
     pkgs.azure-cli
     pkgs.argocd

     # Languages
     pkgs.beam.packages.erlang_27.elixir_1_18
     pkgs.beam.interpreters.erlang_27
     #pkgs.rebar3
     #pkgs.rustup
     #pkgs.nodejs
  ];


  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}
