{
  description = "Common Lisp development environment for Land of Lisp";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;  # unfree パッケージを許可
        };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            sbcl        # Common Lisp コンパイラ
            rlwrap      # REPL の履歴・補完サポート
            vscode      # VSCode (拡張機能は手動インストール)
          ];

          shellHook = ''
            export QUICKLISP_DIR="$PWD/.quicklisp"

            if [ ! -d "$QUICKLISP_DIR" ]; then
              echo "Setting up Quicklisp in $QUICKLISP_DIR..."
              mkdir -p "$QUICKLISP_DIR"
              curl -o "$QUICKLISP_DIR/quicklisp.lisp" https://beta.quicklisp.org/quicklisp.lisp
              sbcl --load "$QUICKLISP_DIR/quicklisp.lisp" --eval "(quicklisp-quickstart:install :path \"$QUICKLISP_DIR\")" --quit
              rm "$QUICKLISP_DIR/quicklisp.lisp"
            fi

            export PATH="$QUICKLISP_DIR/bin:$PATH"
            export QUICKLISP_HOME="$QUICKLISP_DIR"

            echo "Common Lisp development environment is ready!"
            echo "Run 'code .' to start VSCode, then install 'Alive Debugger' manually from the VSCode marketplace."
          '';
        };
      }
    );
}
