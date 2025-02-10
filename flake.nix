{
  description = "Common Lisp development environment for Land of Lisp";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            sbcl                     # Common Lispコンパイラ
            quicklisp                # パッケージマネージャ
            vscode                   # エディタ
            (vscode-with-extensions.override {
              vscodeExtensions = with vscode-extensions; [
                alivedebug.alive      # VSCode用Common Lisp拡張
              ];
            })
          ];

          shellHook = ''
            # Quicklispのセットアップ
            if [ ! -d "$HOME/quicklisp" ]; then
              curl -O https://beta.quicklisp.org/quicklisp.lisp
              sbcl --load quicklisp.lisp --eval '(quicklisp-quickstart:install)' --quit
              rm quicklisp.lisp
            fi

            # Quicklispのパスを設定
            export QUICKLISP_HOME="$HOME/quicklisp"
            export PATH="$QUICKLISP_HOME/bin:$PATH"

            echo "Common Lisp development environment is ready!"
            echo "Run 'code .' to start VSCode with Alive extension."
          '';
        };
      }
    );
}{
  description = "Common Lisp development environment for Land of Lisp";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            sbcl                     # Common Lispコンパイラ
            quicklisp                # パッケージマネージャ
            vscode                   # エディタ
            (vscode-with-extensions.override {
              vscodeExtensions = with vscode-extensions; [
                alivedebug.alive      # VSCode用Common Lisp拡張
              ];
            })
          ];

          shellHook = ''
            # Quicklispのセットアップ
            if [ ! -d "$HOME/quicklisp" ]; then
              curl -O https://beta.quicklisp.org/quicklisp.lisp
              sbcl --load quicklisp.lisp --eval '(quicklisp-quickstart:install)' --quit
              rm quicklisp.lisp
            fi

            # Quicklispのパスを設定
            export QUICKLISP_HOME="$HOME/quicklisp"
            export PATH="$QUICKLISP_HOME/bin:$PATH"

            echo "Common Lisp development environment is ready!"
            echo "Run 'code .' to start VSCode with Alive extension."
          '';
        };
      }
    );
}
