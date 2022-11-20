set nocompatible

"============================= VUNDLE ==========================================
filetype off " required to setup vundle plugins correctly

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

" Keep Plugin commands between vundle#begin/end.
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins I've been using
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-eunuch'
Plugin 'scrooloose/nerdtree'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'pangloss/vim-javascript'
Plugin 'janko/vim-test'
Plugin 'leafgarland/typescript-vim'
Plugin 'quramy/tsuquyomi'
Plugin 'suan/vim-instant-markdown', {'rtp': 'after'}
Plugin 'prettier/vim-prettier'
Plugin 'dense-analysis/ale'
Plugin 'easymotion/vim-easymotion'
Plugin 'haya14busa/incsearch.vim'
Plugin 'haya14busa/incsearch-easymotion.vim'
"Plugin 'puremourning/vimspector'

" Consider installing this for better autocompletion, want to make sure I can
" use the local version though
" Plugin 'zxqfl/tabnine-vim'

" Plugins I've used but haven't wanted installed recently
"Plugin 'hashivim/vim-terraform'
"Plugin 'valloric/youcompleteme'
"Plugin 'godlygeek/tabular'
"Plugin 'lervag/vimtex'
"Plugin 'fatih/vim-go'
"Plugin 'tpope/vim-surround'
"Plugin 'plasticboy/vim-markdown'
"Plugin 'majutsushi/tagbar'
"Plugin 'scrooloose/syntastic'
"Plugin 'xolox/vim-misc'
"Plugin 'xolox/vim-easytags'
"Plugin 'flazz/vim-colorschemes'

call vundle#end()

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"============================ PERSONAL SETTINGS ================================

filetype plugin on
syntax on

set path+=**
set nrformats=

set scrolloff=5

set history=200
"set term=xterm-256color
set nowrap
set incsearch
set autoindent

" Alignment Setting
set cino+=(0

" Folding Settings
set foldenable
set foldmethod=syntax

" https://superuser.com/questions/836781/make-vims-motions-skip-over-folds
set foldopen-=block

"
" Tab Settings
set tabstop=2
set softtabstop=0
set shiftwidth=2
set expandtab
set smarttab

" Pane Settings
set splitright
set splitbelow

" Style Settings
set number
set colorcolumn=80
set nocursorcolumn
set nocursorline
set norelativenumber
set t_Co=256
set background=dark
colorscheme everforest

set statusline+=%F

"if !exists("g:syntax_on")
    "syntax enable
"endif

"augroup vimrc_autocmds
    "autocmd BufEnter * highlight ColorColumn ctermbg=0
"augroup END

"========================= COMMAND ALIASES =====================================
" vim-fugitive
command Rmc Git mergetool -y

"============================= KEY MAPPINGS ====================================
" https://vi.stackexchange.com/questions/7722/how-to-debug-a-mapping
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

nnoremap <silent> <Leader>l :exe "vertical resize -3"<CR>
nnoremap <silent> <Leader>m :exe "vertical resize +3"<CR>
nnoremap <silent> <Leader>s :exe "resize -3"<CR>
nnoremap <silent> <Leader>b :exe "resize +3"<CR>

nnoremap <silent> <Leader>k :set cursorcolumn!<Bar>set cursorline!<CR>

" tsuquyomi
autocmd FileType typescript nmap <buffer> <Leader>r <Plug>(TsuquyomiRenameSymbol)
autocmd FileType typescript nmap <buffer> <Leader>R <Plug>(TsuquyomiRenameSymbolC)
autocmd FileType typescript nmap <buffer> <Leader>f <Plug>(TsuquyomiReferences)
autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>

" vim-test
"nmap <silent> <Leader>t :TestNearest<CR>
"nmap <silent> <Leader>T :TestFile<CR>
"nmap <silent> <Leader>a :TestSuite<CR>
"nmap <silent> <Leader>p :TestLast<CR>
"nmap <silent> <Leader>g :TestVisit<CR>
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

"nnoremap <silent> [q :cprevious<CR>
"nnoremap <silent> ]q :cnext<CR>

" git/vim-fugitive
"https://vi.stackexchange.com/questions/37139/vim-mapping-diffput-diffget-to-ctrlleft-ctrlright-with-working-buffer-sele
nnoremap <expr> gdh ":diffget " .. '//2/' .. expand('%') .. " \| diffupdate\<CR>"
nnoremap <expr> gdb ":diffget " .. '//3/' .. expand('%') .. " \| diffupdate\<CR>"

" easymotion
nmap z/ <Plug>(incsearch-easymotion-/)
nmap z? <Plug>(incsearch-easymotion-?)

map <C-n> :NERDTreeToggle<CR>

"============================ QUICKFIX SETTINGS ================================
augroup quickfix
  autocmd!
  autocmd FileType qf setlocal wrap
augroup END

"========================== NERDTREE SETTINGS ==================================
let NERDTreeIgnore = ['\.pyc$']

"============================ FZF SETTINGS =====================================
"set rtp+=~/.fzf
set rtp+=/opt/homebrew/opt/fzf

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_history_dir = '~/.local/share/fzf-history'

function! s:ag_to_qf(line)
  let parts = split(a:line, ':')
  return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
        \ 'text': join(parts[3:], ':')}
endfunction

function! s:ag_handler(lines)
  if len(a:lines) < 2 | return | endif

  let cmd = get({'ctrl-x': 'split',
               \ 'ctrl-v': 'vertical split',
               \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')
  let list = map(a:lines[1:], 's:ag_to_qf(v:val)')

  let first = list[0]
  execute cmd escape(first.filename, ' %#\')
  execute first.lnum
  execute 'normal!' first.col.'|zz'

  if len(list) > 1
    call setqflist(list)
    copen
    wincmd p
  endif
endfunction

"Fuzzy find within the current working directory
command! -nargs=* Fa call fzf#run({
\ 'source':  printf('ag --ignore node_modules --nogroup --column --color "%s"',
\                   escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
\ 'sink*':    function('<sid>ag_handler'),
\ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
\            '--multi --bind=ctrl-a:select-all,ctrl-d:deselect-all '.
\            '--color hl:68,hl+:110',
\ 'down':    '50%'
\ })

"Fuzzy find within the current working directory, including node_modules
command! -nargs=* FaNode call fzf#run({
\ 'source':  printf('ag --nogroup --column --color "%s"',
\                   escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
\ 'sink*':    function('<sid>ag_handler'),
\ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
\            '--multi --bind=ctrl-a:select-all,ctrl-d:deselect-all '.
\            '--color hl:68,hl+:110',
\ 'down':    '50%'
\ })

"Fuzzy find within the current file
command! -nargs=* Faf call fzf#run({
\ 'source':  printf('ag --vimgrep "%s" %s',
\                   escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\'),
\                   expand("%")),
\ 'sink*':    function('<sid>ag_handler'),
\ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
\            '--multi --bind=ctrl-a:select-all,ctrl-d:deselect-all '.
\            '--color hl:68,hl+:110',
\ 'down':    '50%'
\ })

"========================== VIM PRETTIER SETTINGS ==============================
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 1

"========================== VIM PRETTIER SETTINGS ==============================
let g:prettier#autoformat_require_pragma = 0
let g:prettier#autoformat_config_present = 1

"============================ EASYTAGS SETTINGS ================================
"let g:easytags_async = 1

"============================= TAGBAR SETTINGS =================================
"map <C-l> :TagbarToggle<CR>

"============================= VIM-GO SETTINGS =================================
"let g:go_highlight_types = 1
"let g:go_highlight_fields = 1
"let g:go_highlight_functions = 1
"let g:go_highlight_function_calls = 1
"let g:go_fmt_experimental = 1
"let g:go_auto_sameids = 1
"map <C-[> :GoReferrers<CR>

"========================== VIM-TERRAFORM SETTINGS =============================
"let g:terraform_fmt_on_save = 1
"let g:terraform_align = 1
"let g:terraform_fold_sections = 1

"=============================== VIM-TEST SETTINGS =============================
let test#strategy = "dispatch"

"=========================== SYNTASTIC SETTINGS ================================
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

"=========================== tsuquyomi settings "===============================
let g:tsuquyomi_definition_split = 3
