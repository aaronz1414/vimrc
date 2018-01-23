set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim


"============================= PLUGINS ==================================
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdcommenter'
Plugin 'godlygeek/tabular'
"Plugin 'valloric/youcompleteme'
Plugin 'flazz/vim-colorschemes'
Plugin 'lervag/vimtex'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'scrooloose/syntastic'

" All of your Plugins must be added before the following line
call vundle#end()            " required
"========================================================================


filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


"========================= KEY BINDINGS =================================
map <C-n> :NERDTreeToggle<CR>


"======================= PERSONAL SETTINGS ==============================
set number
set colorcolumn=80
set cursorline
set cursorcolumn
set expandtab
set shiftwidth=4
set softtabstop=4
set scrolloff=10
set foldenable
set splitright
set splitbelow
colorscheme herald
set background=dark
set t_Co=256
if !exists("g:syntax_on")
    syntax enable
endif

augroup vimrc_autocmds
    autocmd BufEnter * highlight ColorColumn ctermbg=0
augroup END
    


"======================= SYNTASTIC SETTINGS =============================
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

