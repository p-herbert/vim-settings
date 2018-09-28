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
5. Download and save to `$HOME/.vim/syntax/` the following syntax files:
    - [SQL]
    - [Octave]
    - [R]
    - [SAS]
6. Create a symbolic link from the repository `.vimrc` to the home directory

        ln -s $HOME/.vim/.vimrc $HOME/.vimrc

7. Install [eslint] and [tern]

        npm i -g eslint babel-eslint eslint-plugin-react
        npm i -g tern

8. Install [Nerd Fonts]

9. Install [tern] dependencies

        cd $HOME/.vim/bundle/tern
        npm install

10. Compile [command-t]

        cd $HOME/.vim/bundle/command-t/ruby/command-t/ext/command-t
        ruby extconf.rb
        make

[pathogen]: https://github.com/tpope/vim-pathogen
[SQL]: http://www.vim.org/scripts/script.php?script_id=3702
[Octave]: http://www.vim.org/scripts/script.php?script_id=3600
[R]: http://www.vim.org/scripts/script.php?script_id=2984
[SAS]: http://www.vim.org/scripts/script.php?script_id=3522
[eslint]: https://eslint.org
[Nerd Fonts]: https://github.com/ryanoasis/nerd-fonts
[tern]: https://ternjs.net
[command-t]: https://github.com/wincent/command-t
