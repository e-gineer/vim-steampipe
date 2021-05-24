## Overview: vim-steampipe

This plugin sets up `*.sp` and `*.spc` to be highlighted as HCL.

---

## Installation

With [Vim 8 packages](http://vimhelp.appspot.com/repeat.txt.html#packages):

    git clone https://github.com/e-gineer/vim-steampipe.git ~/.vim/pack/plugins/start/vim-steampipe

With [Pathogen](https://github.com/tpope/vim-pathogen):

    git clone https://github.com/e-gineer/vim-steampipe.git ~/.vim/bundle/vim-steampipe

With [Vundle](https://github.com/VundleVim/Vundle.vim), add the following to `~/.vimrc`:

    Plugin 'e-gineer/vim-steampipe'

---

## Usage

Allow vim-steampipe to align settings automatically with Tabularize.

    let g:steampipe_align=1

Allow vim-steampipe to automatically fold (hide until unfolded) sections of
steampipe code.
Defaults to 0 which is off.

    let g:steampipe_fold_sections=1

---

## Running tests

To run the test suite and verify functionality

    make

---

## Credits

This project is derived from https://github.com/hashivim/vim-terraform. It
builds on the shoulders of all contributors to that project and it's lineage.
