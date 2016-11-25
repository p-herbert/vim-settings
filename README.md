# Vim Environment

These are my personal vim settings.

# Installation

1. Clone the repository

		git clone https://github.com/p-herbert/vim-settings.git ~/.vim

2. Initialize the local configuration file

		git submodule init

3. Fetch the submodules

		git submodule update

4.	Install [pathogen]
5. Download the plugin [comments] and save it to `~/.vim/bundle/comments/plugin/`
6. Download and save to `~/.vim/syntax/` the following syntax files:
	- [SQL]
	- [Octave]
	- [R]
	- [SAS]
7. Create a symbolic link from the repository `.vimrc` to the home directory

    	ln -s ~/.vim/.vimrc ~

8. Install [jsctags]

        npm i -g jsctags

**Note: Additional system dependencies will need to be installed. See individual plugins for instructions.**

[pathogen]: https://github.com/tpope/vim-pathogen
[comments]: http://www.vim.org/scripts/script.php?script%5Fid=1528
[SQL]: http://www.vim.org/scripts/script.php?script_id=3702
[Octave]: http://www.vim.org/scripts/script.php?script_id=3600
[R]: http://www.vim.org/scripts/script.php?script_id=2984
[SAS]: http://www.vim.org/scripts/script.php?script_id=3522
[jsctags]: https://github.com/ramitos/jsctags
