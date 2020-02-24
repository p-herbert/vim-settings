# Vim Environment

These are my personal vim settings.

# Installation

1. Clone the repository

        git clone https://github.com/p-herbert/vim-settings.git $HOME/.vim

2. Initialize the local configuration file

        git submodule init

3. Fetch the submodules

        git submodule update

4. Install [pathogen]

5. Create a symbolic link from the repository `.vimrc` to the home directory

        ln -s $HOME/.vim/.vimrc $HOME/.vimrc

    ## Note
    On macOS replace the system version of `vim` and `ruby` using [brew].

6. Install [eslint], [prettier], [csslint], [mustache], and [tern]

        npm i -g eslint prettier csslint tern babel-eslint eslint-plugin-react eslint-plugin-prettier ember-template-lint

7. Install [Nerd Fonts]

8. Install [tern] dependencies

        cd $HOME/.vim/bundle/tern
        npm install

9. Compile [command-t]

        cd $HOME/.vim/bundle/command-t/ruby/command-t/ext/command-t
        ruby extconf.rb
        make

    ## Note
    [command-t] must be compiled using the same version of `ruby` linked to `vim`.

10. Install [rust] and [racer]

        curl https://sh.rustup.rs -sSf | sh
        rustup install nightly
        cargo +nightly install racer

11. Install [rls]

        rustup component add rls rust-analysis rust-src

[pathogen]: https://github.com/tpope/vim-pathogen
[eslint]: https://eslint.org
[prettier]: https://prettier.io
[csslint]: https://github.com/CSSLint/csslint
[Nerd Fonts]: https://github.com/ryanoasis/nerd-fonts
[tern]: https://ternjs.net
[command-t]: https://github.com/wincent/command-t
[mustache]: https://github.com/ember-template-lint/ember-template-lint
[brew]: https://brew.sh/
[rust]: https://rustup.rs/#
[rls]: https://github.com/rust-lang/rls
[racer]: https://github.com/racer-rust/racer
