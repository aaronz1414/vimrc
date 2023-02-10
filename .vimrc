set nocompatible
let g:polyglot_disabled = ['typescript']

function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

"============================= VIM-PLUG ========================================
call plug#begin()

Plug 'williamboman/mason.nvim'

" Language Functionality
Plug 'sheerun/vim-polyglot'
Plug 'prettier/vim-prettier'
Plug 'nvim-treesitter/nvim-treesitter', Cond(has('nvim'), {'do': ':TSUpdate'})
" Plug 'windwp/nvim-ts-autotag'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'danielvolchek/tailiscope.nvim'
" Installed coc.nvim plugins with the following commands
" :CocInstall @yaegassy/coc-tailwindcss3
" :CocInstall coc-tsserver
" :CocInstall coc-json
" :CocInstall coc-styled-components
" :CocInstall coc-snippets
" :CocInstall coc-eslint
" :CocInstall coc-db
" :CocInstall coc-pairs
" :CocInstall coc-react-refactor

" Navigation
if has('nvim')
  Plug 'ggandor/leap.nvim'
else
  Plug 'easymotion/vim-easymotion'
  Plug 'haya14busa/incsearch.vim'
  Plug 'haya14busa/incsearch-easymotion.vim'
endif

" Tmux
Plug 'christoomey/vim-tmux-navigator'

" Debugging
if has('nvim')
  Plug 'mfussenegger/nvim-dap'
  Plug 'rcarriga/nvim-dap-ui'
  Plug 'folke/neodev.nvim'
  Plug 'mxsdev/nvim-dap-vscode-js'
else
  Plug 'puremourning/vimspector', Cond(!has('nvim'))
endif

" Editing
Plug 'kylechui/nvim-surround', Cond(has('nvim'), {'tag': '*'})
Plug 'tpope/vim-commentary' " Might want to go back to nerdcommenter?

" Git
Plug 'tpope/vim-fugitive'
if has('nvim')
  Plug 'lewis6991/gitsigns.nvim'
else
  Plug 'airblade/vim-gitgutter'
endif

" Other Utilities
Plug 'tpope/vim-repeat'
Plug 'nvim-lua/plenary.nvim'
Plug 'tpope/vim-dispatch' " TODO: Set this up to run ts/js tests
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
" Call :CocInstall coc-db for https://github.com/kristijanhusak/vim-dadbod-completion

" Files
if has('nvim')
  Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
  Plug 'nvim-tree/nvim-tree.lua'
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
else
  Plug 'scrooloose/nerdtree'
endif

" Display
Plug 'vim-airline/vim-airline'
Plug 'karb94/neoscroll.nvim'

" Colorschemes
Plug 'EdenEast/nightfox.nvim'
Plug 'sainnhe/everforest'
Plug 'cocopon/iceberg.vim'

call plug#end()

"======================= PLUGIN GRAVEYARD ======================================
" Plug 'pangloss/vim-javascript'
" Plug 'MaxMEllon/vim-jsx-pretty'
" Plug 'jparise/vim-graphql'
" Plug 'leafgarland/typescript-vim'
"Plug 'preservim/tagbar'
"Plug 'ludovicchabant/vim-gutentags'
"Plug 'dense-analysis/ale'
"Plug 'quramy/tsuquyomi'
"Plug 'suan/vim-instant-markdown', {'rtp': 'after'}
"Plug 'janko/vim-test'
"Plugin 'vim-airline/vim-airline-themes'
" Plugin 'scrooloose/nerdcommenter'
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

"============================ PERSONAL SETTINGS ================================
filetype plugin on
syntax on
set nohlsearch

" Disable mouse
set mouse=

set autoread

set backspace=indent,eol,start

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

" Colorscheme Settings
" https://github.com/tmux/tmux/issues/1246
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set background=dark
let g:everforest_background = 'medium'
let g:everforest_better_performance = 1

colorscheme everforest

"COC
set pumheight=10

"if !exists("g:syntax_on")
    "syntax enable
"endif

" dadbod-ui
let g:db_ui_use_nerd_fonts = 1
let g:db_ui_execute_on_save = 0

" vim-tmux-navigator
let  g:tmux_navigator_no_wrap = 1

"============================== STATUSLINE =====================================
" Statusline docs: https://vimdoc.sourceforge.net/htmldoc/options.html#'statusline'

function! DiagnosticExists() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  return !empty(info)
endfunction

function! DiagnosticExistsWithoutErrors() abort
  if !DiagnosticExists() | return v:false | endif

  let info = get(b:, 'coc_diagnostic_info', {})
  return !get(info, 'error', 0)
        \ && !get(info, 'warning', 0)
        \ && !get(info, 'information', 0)
        \ && !get(info, 'hint', 0)
endfunction

function! GetDiagnosticHeader() abort
  if DiagnosticExistsWithoutErrors() | return 'No errors! ' | endif
  return ''
endfunction

function! GetDiagnosticStatus(name, symbol) abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) || !get(info, a:name, 0) | return '' | endif

  return a:symbol . info[a:name] . ' '
endfunction

function! GetDiagnosticSeparator() abort
  if DiagnosticExists() | return ' | ' | endif
  return ''
endfunction

function! GetCocStatus() abort
  " Use coc#status() if you want COC's formatting for errors and warnings
  " let cocStatus = coc#status()
  let cocStatus = get(g:, 'coc_status', '')
  if !len(cocStatus) | return '' | endif
  return cocStatus . ' | '
endfunction

" set statusline=*
" set statusline+=\ %{GetDiagnosticHeader()}
" set statusline+=%#ERROR#%{GetDiagnosticStatus('error','E')}%*
" set statusline+=%#WARNING#%{GetDiagnosticStatus('warning','W')}%*
" set statusline+=%#INFORMATION#%{GetDiagnosticStatus('information','I')}%*
" set statusline+=%#HINT#%{GetDiagnosticStatus('hint','H')}%*
" set statusline+=%{GetDiagnosticSeparator()}
" set statusline+=%{GetCocStatus()}
" set statusline+=%f
" set laststatus=2

" https://www.reddit.com/r/vim/comments/sby64c/highlight_only_foreground_of_status_line_text/
" https://www.reddit.com/r/vim/comments/ga4xe0/why_use_reverse_for_tui_highlights/
" Some libraries use the reverse colors as a hack to increase the priority of
" their highlight group, so this function should check for that. If this
" doesn't work, then you could try just hardcoding the result of fg# as the
" statusline background color instead
function! GetBaseBg() abort
  let hl_base = 'StatusLine'
  if synIDattr(synIDtrans(hlID(hl_base)), 'reverse')
    return synIDattr(synIDtrans(hlID(hl_base)), 'fg#')
  endif

  return synIDattr(synIDtrans(hlID(hl_base)), 'bg#')
endfunction

" let base_bg = GetBaseBg()
" let v:colornames['aaron_statusline_bg'] = base_bg

" hi StatusLine ctermfg=247
" hi ERROR ctermfg=160
" hi WARNING ctermfg=178
" hi INFORMATION ctermfg=20
" hi HINT ctermfg=107
" hi ERROR guifg=#DE1F1F guibg=aaron_statusline_bg
" hi WARNING guifg=#F0F02D guibg=aaron_statusline_bg
" hi INFORMATION guifg=#4273E5 guibg=aaron_statusline_bg
" hi HINT guifg=#7BD546 guibg=aaron_statusline_bg

"============================ AUTO COMMANDS ====================================
"https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
augroup openFolds
  autocmd!
  au BufRead * normal zR 
augroup END

"COC
augroup coc
  autocmd!
  autocmd User CocStatusChange redrawstatus
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup END

"Quickfix list foramtting
augroup quickfix
  autocmd!
  autocmd FileType qf setlocal wrap
augroup END

"augroup vimrc_autocmds
    "autocmd BufEnter * highlight ColorColumn ctermbg=0
"augroup END

"========================= COMMAND ALIASES =====================================
" vim-fugitive
command Rmc Git mergetool -y

"============================= KEY MAPPINGS ====================================
" https://vi.stackexchange.com/questions/7722/how-to-debug-a-mapping

nnoremap <space> <Nop>
let mapleader=" "

nnoremap <C-@> <C-[>

nnoremap gp "+p
nnoremap gy "+y
xnoremap gy "+y

" https://www.reddit.com/r/vim/comments/gk4v52/how_to_navigate_html_better/
" Next closing tag
nnoremap <silent> ]t /\/>\\|<\/[a-zA-Z0-9]<CR>
vnoremap <silent> ]t /\/>\\|<\/[a-zA-Z0-9]<CR>
onoremap <silent> ]t /\/>\\|<\/[a-zA-Z0-9]<CR>
" Previous opening tag
nnoremap <silent> [t ?<[a-zA-Z0-9]<CR>
vnoremap <silent> [t ?<[a-zA-Z0-9]<CR>
onoremap <silent> [t ?<[a-zA-Z0-9]<CR>

" Custom text objects
" https://vim.fandom.com/wiki/Creating_new_text_objects
"
" ib/ab is redundant with i)/a) (https://neovim.io/doc/user/motion.html#object-select),
" so we'll turn it off to make sure it doesn't
" interfere with our goto previous blocks. We use b and e here since it's
" similar to the b and e word motions
vnoremap ib <Nop>
onoremap ib <Nop>
vnoremap ab <Nop>
onoremap ab <Nop>

" Current line to previous or next brace
vnoremap <silent> ib{ :<C-U>normal! V[{j<CR>
vnoremap <silent> ie} :<C-U>normal! V]}k<CR>
omap <silent> ib{ :normal Vib}<CR>
omap <silent> ie} :normal Vie}<CR>
vnoremap <silent> ab{ :<C-U>normal! V[{<CR>
vnoremap <silent> ae} :<C-U>normal! V]}<CR>
omap <silent> ab{ :normal Vab}<CR>
omap <silent> ae} :normal Vae}<CR>

" Current line to previous opening tag or next closing tag (requires
" next/previous tag mappings above)
vmap <silent> ibt :<Esc>V[tj
vmap <silent> iet :<Esc>V]tk
omap <silent> ibt :normal Vibt<CR>
omap <silent> iet :normal Viet<CR>
vmap <silent> abt :<Esc>V[t
vmap <silent> aet :<Esc>V]t
omap <silent> abt :normal Vabt<CR>
omap <silent> aet :normal Vaet<CR>

" Current line to beginning or end of function. Only works for
" structured languages https://neovim.io/doc/user/motion.html#various-motions
vnoremap <silent> ibf :<C-U>normal! V[mj<CR>
vnoremap <silent> ief :<C-U>normal! V]Mk<CR>
omap <silent> ibf :normal Vibf<CR>
omap <silent> ief :normal Vief<CR>

" fzf
" nmap <C-p> :FZF<CR>
" nmap <C-s> :Fa<CR>

nnoremap <silent> <Leader>vd :exe "vertical resize -5"<CR>
nnoremap <silent> <Leader>vi :exe "vertical resize +5"<CR>
nnoremap <silent> <Leader>sd :exe "resize -5"<CR>
nnoremap <silent> <Leader>si :exe "resize +5"<CR>

nnoremap <silent> <Leader>k :set cursorcolumn!<Bar>set cursorline!<CR>

" Easier keys for marks
nnoremap ' `
nnoremap <silent> gmt :tabnew<CR>`
nnoremap <silent> gmx <C-w>s`
nnoremap <silent> gmv <C-w>v`
" nnoremap <Leader>m m


" vim-test
"nmap <silent> <Leader>t :TestNearest<CR>
"nmap <silent> <Leader>T :TestFile<CR>
"nmap <silent> <Leader>a :TestSuite<CR>
"nmap <silent> <Leader>p :TestLast<CR>
"nmap <silent> <Leader>g :TestVisit<CR>
" nmap <silent> t<C-n> :TestNearest<CR>
" nmap <silent> t<C-f> :TestFile<CR>
" nmap <silent> t<C-s> :TestSuite<CR>
" nmap <silent> t<C-l> :TestLast<CR>
" nmap <silent> t<C-g> :TestVisit<CR>

"nnoremap <silent> [q :cprevious<CR>
"nnoremap <silent> ]q :cnext<CR>

" dadbod-ui
nnoremap <Leader>pg :tabnew \| DBUI<CR>

" git/gitgutter
nmap <Leader>gt :GitGutterBufferToggle<CR>

" git/vim-fugitive
"https://vi.stackexchange.com/questions/37139/vim-mapping-diffput-diffget-to-ctrlleft-ctrlright-with-working-buffer-sele
nnoremap <expr> gdh ":diffget " .. '//2/' .. expand('%') .. " \| diffupdate\<CR>"
nnoremap <expr> gdb ":diffget " .. '//3/' .. expand('%') .. " \| diffupdate\<CR>"
nmap <Leader>gd :Gvidffsplit<CR>

" easymotion
nmap z/ <Plug>(incsearch-easymotion-/)
nmap z? <Plug>(incsearch-easymotion-?)
nmap <Leader>w <Plug>(easymotion-w)
nmap <Leader>b <Plug>(easymotion-b)

if has('nvim')
  map <silent> <C-n> :NvimTreeToggle<CR>
else
  map <silent> <C-n> :NERDTreeToggle<CR>
endif

nmap <C-l> :TagbarToggle<CR>

" tsuquyomi
"autocmd FileType typescript nmap <buffer> <Leader>r <Plug>(TsuquyomiRenameSymbol)
"autocmd FileType typescript nmap <buffer> <Leader>R <Plug>(TsuquyomiRenameSymbolC)
" autocmd FileType typescript nmap <buffer> <Leader>f <Plug>(TsuquyomiReferences)
"autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>

" COC
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<Tab>"
nmap <silent> <Leader>t <Plug>(coc-type-definition)

nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gk <Plug>(coc-type-definition)

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> ge :CocDiagnostics<CR>
nmap <Leader>qf  <Plug>(coc-fix-current)
nnoremap <silent><nowait> <space>d :<C-u>CocList diagnostics<cr>

nmap <silent> <Leader>rn <Plug>(coc-rename)
nmap <silent> <Leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <Leader>re  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <Leader>ca  <Plug>(coc-codeaction-cursor)
xmap <silent> <Leader>ca  <Plug>(coc-codeaction-selected)
nmap <silent> <Leader>cf  <Plug>(coc-codeaction-source)

nmap <Leader>cle :call ToggleCodeLens()<CR>
nmap <silent> <Leader>clt :CocCommand document.toggleCodeLens<CR>
nmap <Leader>cl <Plug>(coc-codelens-action)

function! ToggleCodeLens()
  let enabled = coc#util#get_config('codeLens')['enable']
  if enabled
    call coc#config('codeLens.enable', 0)
    echo 'Disabled CodeLens'
  else
    call coc#config('codeLens.enable', 1)
    echo 'Enabled CodeLens'
  endif
endfunction

" function! DisableCodeLens()
"   call coc#config('codeLens.enable', 0)
"   while coc#util#get_config('codeLens')['enable']
"     sleep 50m
"   endwhile
"   call CocActionAsync('runCommand', 'document.toggleCodeLens')
" endfunction

" function! EnableCodeLens()
"   call coc#config('codeLens.enable', 1)
"   while !coc#util#get_config('codeLens')['enable']
"     sleep 50m
"   endwhile
"   call CocActionAsync('runCommand', 'document.toggleCodeLens')
" endfunction

nnoremap <silent><nowait> <space>c :CocList commands<CR>

nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

nnoremap <silent> <Leader>hi :call CocAction('showIncomingCalls')<CR>
nnoremap <silent> <Leader>ho :call CocAction('showOutgoingCalls')<CR>
nnoremap <silent> <Leader>hti :call CocAction('showSubTypes')<CR>
nnoremap <silent> <Leader>hto :call CocAction('showSuperTypes')<CR>

nnoremap <silent><nowait> <space>o :call ToggleOutline()<CR>
function! ToggleOutline() abort
  let winid = coc#window#find('cocViewId', 'OUTLINE')
  if winid == -1
    call CocActionAsync('showOutline', 1)
  else
    call coc#window#close(winid)
  endif
endfunction

" Vimspector
if !has('nvim')
  nnoremap <Leader>dd :call vimspector#Launch()<CR>
  nnoremap <Leader>de :call vimspector#Reset()<CR>
  nnoremap <Leader>dc :call vimspector#Continue()<CR>

  nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
  nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>

  nmap <Leader>dk <Plug>VimspectorRestart
  nmap <Leader>dh <Plug>VimspectorStepOut
  nmap <Leader>dl <Plug>VimspectorStepInto
  nmap <Leader>dj <Plug>VimspectorStepOver
endif

" Open go to definition in new tab
nnoremap <silent> gdt <C-w><C-]><C-w>T
nnoremap <silent> gdx <C-w><C-]>
nnoremap <silent> gdv <C-w>v<C-]>
" nmap <silent> gd <Plug>(coc-definition)

"========================== COC SETTINGS "======================================
set updatetime=300
set signcolumn=yes
set tagfunc=CocTagFunc

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

"=========================== TSUQUYOMI SETTINGS "===============================
"let g:tsuquyomi_definition_split = 3

"=========================== VIMSPECTOR SETTINGS "==============================
let g:vimspector_base_dir='/Users/aaron/.vim/plugged/vimspector'

"===============================================================================
"=========================== NEOVIM ONLY SETTINGS ""============================
"===============================================================================
if has('nvim')
lua <<EOF
require("mason").setup()

require('leap').add_default_mappings()
require('leap').opts.safe_labels = { "s", "f", "n", "u", "t", "/" }

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

require("nvim-surround").setup({
  keymaps = {
    insert = "<C-g>z",
    insert_line = "<C-g>Z",
    normal = "yz",
    normal_cur = "yzz",
    normal_line = "yZ",
    normal_cur_line = "yZZ",
    visual = "Z",
    visual_line = "gZ",
    delete = "dz",
    change = "cz",
  },
})

require'nvim-web-devicons'.setup {
  default = true;
}

-- TODO: Not working
-- https://github.com/windwp/nvim-ts-autotag/issues/64
-- require('nvim-treesitter.configs').setup({
--   autotag = {
--     enable = true,
--     filetypes = { "html", "xml", "php", "javascriptreact", "javascript", "typescriptreact", "typescript", "js", "jsx", "ts", "tsx" },
--   },
-- })

require('telescope').setup{
  defaults = {
    wrap_results = true
  }
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fm', builtin.marks, {})
vim.keymap.set("n", "<leader>fdt", "<cmd>Telescope tailiscope categories<cr>")

require('telescope').load_extension('fzf')
require('telescope').load_extension('tailiscope')

require('neoscroll').setup({
  -- All these keys will be mapped to their corresponding default scrolling animation
  mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>'},
})

require('gitsigns').setup({
  on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, {expr=true})

      map('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, {expr=true})

      -- Actions
      map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
      map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
      map('n', '<leader>hS', gs.stage_buffer)
      map('n', '<leader>hu', gs.undo_stage_hunk)
      map('n', '<leader>hR', gs.reset_buffer)
      map('n', '<leader>hp', gs.preview_hunk)
      map('n', '<leader>hb', function() gs.blame_line{full=true} end)
      map('n', '<leader>tb', gs.toggle_current_line_blame)
      map('n', '<leader>hd', gs.diffthis)
      map('n', '<leader>hD', function() gs.diffthis('~') end)
      map('n', '<leader>td', gs.toggle_deleted)

      -- Text object
      map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
})

-- require("neodev").setup({
--   library = { plugins = { "nvim-dap-ui" }, types = true },
-- })

local dap, dapui = require("dap"), require("dapui")
dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

dap.adapters.chrome = {    
  -- executable: launch the remote debug adapter - server: connect to an already running debug adapter    
  type = "executable",    
  -- command to launch the debug adapter - used only on executable type    
  command = "node",    
  args = { os.getenv("HOME") .. "/.vim/plugged/vimspector/gadgets/macos/debugger-for-chrome/out/src/chromeDebug.js" }    
}

require("dap-vscode-js").setup({
  debugger_path = "/Users/aaron/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
  adapters = { 'pwa-node', 'pwa-chrome' }, -- which adapters to register in nvim-dap
})

-- https://alpha2phi.medium.com/neovim-for-beginners-javascript-typescript-debugging-bd0fc8e16657
for _, language in ipairs({ "typescript", "typescriptreact", "javascript", "javascriptreact" }) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach to Node Server",
      processId = require'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
      sourceMaps = true,
    },
    -- TODO: Get chrome working for dap-vscode-js
    -- {
    --   type = "pwa-chrome",
    --   name = "Attach to Chrome",
    --   request = "attach",
    --   -- program = "${file}",
    --   cwd = vim.fn.getcwd(),
    --   sourceMaps = true,
    --   protocol = "inspector",
    --   port = 9222,
    --   webRoot = "${workspaceFolder}",
    -- },
    -- {
    --   type = "pwa-chrome",
    --   request = "launch",
    --   name = "Launch Dashboard",
    --   url = "http://localhost:3000",
    --   -- webRoot = "${workspaceRoot}",
    -- },
    {
        type = "chrome",
        request = "attach",
        name = "Attach Chrome",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}"
    },
    {
      type = "pwa-node",
      name = "Run Jest Current File",
      request = "launch",
      runtimeExecutable = "node",
      runtimeArgs = {
        "${workspaceFolder}/node_modules/jest/bin/jest.js",
        "--runInBand",
        "${file}",
      },
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
      sourceMaps = true,
    },
    {
      type = "pwa-node",
      name = "Run Mocha All Tests",
      request = "launch",
      runtimeExecutable = "node",
      runtimeArgs = {
        "${workspaceFolder}/node_modules/mocha/bin/mocha",
      },
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
      sourceMaps = true,
    }
  }
end

vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end)
vim.keymap.set('n', '<leader>dl', function() require('dap').run_last() end)
vim.keymap.set('n', '<leader>db', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<leader>dB', function() require('dap').clear_breakpoints() end)
vim.keymap.set('n', '<leader>dn', function() require('dap').step_over() end)
vim.keymap.set('n', '<leader>di', function() require('dap').step_into() end)
vim.keymap.set('n', '<leader>do', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<leader>de', function() require('dapui').close() end)

EOF
endif
