{
  config,
  pkgs,
  pkgs-c5dd4393,
  pkgs-unstable,
  self,
  ...
}:
{
  # TODO please change the username & home directory to your own
  home.username = "niels";
  home.homeDirectory = "/home/niels";

  home.file.".gitconfig" = {
    source = "${self}/gitconfig/.gitconfig";
    force = true;
  };

  home.file.".gitconfig-personal" = {
    source = "${self}/gitconfig/.gitconfig-personal";
    force = true;
  };

  home.file.".gitconfig-work" = {
    source = "${self}/gitconfig/.gitconfig-work";
    force = true;
  };

  home.file.".config/tmux" = {
    source = "${self}/tmux";
    force = true;
  };

  home.file.".config/nvim" = {
    source = "${self}/nvim";
    force = true;
  };

  home.file.".config/alacritty" = {
    source = "${self}/alacritty";
    force = true;
  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      source "${self}/bash/bashrc"
    '';
  };

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      papercolor-theme
      typescript-tools-nvim
      telescope-nvim
      #telescope dep
      plenary-nvim
      #syntax highlighting
      vim-elixir
      #lsp
      nvim-lspconfig
      #autocomplete
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      nvim-cmp
      #snippets
      luasnip
      cmp_luasnip
      friendly-snippets
      #formatting
      conform-nvim
    ];
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    #NVIM
    pkgs.gcc
    pkgs.stylua
    pkgs.nixfmt-rfc-style
    pkgs.shellcheck
    pkgs.pgformatter
    pkgs.sqlfluff
    xclip

    # Core
    pkgs.alacritty
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
    pkgs.rustup
    #pkgs.gh
    # needed for -q option - needed for tilt
    pkgs.netcat-openbsd
    pkgs.nmap

    # Misc
    pkgs.iosevka
    pkgs.nerd-fonts.symbols-only
    clang-tools

    # Kubernetes
    pkgs.kubectl
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
    pkgs-unstable.beam27Packages.elixir-ls
    pkgs.python3
    pkgs-c5dd4393.kubelogin
    #pkgs.rustup
    #pkgs.clang
    #pkgs.rebar3
    pkgs.nodejs
    pkgs.typescript
    pkgs.typescript-language-server
    pkgs.jdk24_headless

    #printing
    pkgs.gutenprint

    # Interlink stuff to clean up
    #pkgs.libclang
    pkgs.openssl
    pkgs.pkg-config
    pkgs.srtp
    pkgs.unzip
    #musl
    pkgs.stdenv
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
