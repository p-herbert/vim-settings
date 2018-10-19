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

6. Install [eslint], [prettier], and [tern]

        npm i -g eslint babel-eslint eslint-plugin-react eslint-plugin-prettier
        npm i -g prettier
        npm i -g tern

7. Install [Nerd Fonts]

8. Install [tern] dependencies

        cd $HOME/.vim/bundle/tern
        npm install

9. Compile [command-t]

        cd $HOME/.vim/bundle/command-t/ruby/command-t/ext/command-t
        ruby extconf.rb
        make

[pathogen]: https://github.com/tpope/vim-pathogen
[eslint]: https://eslint.org
[prettier]: https://prettier.io
[Nerd Fonts]: https://github.com/ryanoasis/nerd-fonts
[tern]: https://ternjs.net
[command-t]: https://github.com/wincent/command-t
