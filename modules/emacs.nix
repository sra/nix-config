{ pkgs }:

(pkgs.emacsPackagesGen pkgs.emacs).emacsWithPackages (epkgs:
  (with epkgs.melpaPackages; [
    ace-window
    add-node-modules-path
    ag
    base16-theme
    cargo
    company
    company-org-roam
    counsel
    dap-mode
    direnv
    docker
    docker-compose-mode
    dockerfile-mode
    flx
    flycheck
    flycheck-kotlin
    flycheck-rust
    flycheck-yamllint
    forge
    ivy
    js2-mode
    kotlin-mode
    lsp-ivy
    lsp-java
    lsp-mode
    lsp-ui
    lsp-pyright
    magit
    nix-mode
    org-download
    org-roam
    org-roam-server
    org-trello
    paredit
    prettier-js
    projectile
    racer
    racket-mode
    rust-mode
    shackle
    smex
    spaceline
    terraform-mode
    typescript-mode
    use-package
    use-package-ensure-system-package
    vimish-fold
    web-mode
    which-key
    writegood-mode
    yaml-mode
    yasnippet
    yasnippet-snippets
  ]) ++ (with epkgs.orgPackages; [ org-plus-contrib ]))

