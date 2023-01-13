set nocompatible

"============================= VIM-PLUG ========================================

call plug#begin()

Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-eunuch'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'

Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'

Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'jparise/vim-graphql'
Plug 'prettier/vim-prettier'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'puremourning/vimspector'

Plug 'EdenEast/nightfox.nvim'
Plug 'sainnhe/everforest'

" Plugins I've used but haven't wanted installed recently
" Plug 'leafgarland/typescript-vim'
"Plug 'preservim/tagbar'
"Plug 'ludovicchabant/vim-gutentags'
"Plug 'dense-analysis/ale'
"Plug 'quramy/tsuquyomi'
"Plug 'suan/vim-instant-markdown', {'rtp': 'after'}
"Plug 'janko/vim-test'
"Plugin 'vim-airline/vim-airline'
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

call plug#end()

"============================ PERSONAL SETTINGS ================================

filetype plugin on
syntax on

" Enable mouse
" set mouse=a

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

" TODO: Fix background on diagnostics
set statusline=*
set statusline+=\ %{GetDiagnosticHeader()}
set statusline+=%#ERROR#%{GetDiagnosticStatus('error','E')}%*
set statusline+=%#WARNING#%{GetDiagnosticStatus('warning','W')}%*
set statusline+=%#INFORMATION#%{GetDiagnosticStatus('information','I')}%*
set statusline+=%#HINT#%{GetDiagnosticStatus('hint','H')}%*
set statusline+=%{GetDiagnosticSeparator()}
set statusline+=%{GetCocStatus()}
set statusline+=%f
set laststatus=2

" https://www.reddit.com/r/vim/comments/sby64c/highlight_only_foreground_of_status_line_text/
let hl_base = 'StatusLine'
let base_bg = synIDattr(synIDtrans(hlID(hl_base)), 'bg')
let v:colornames['aaron_statusline_bg'] = base_bg

" hi StatusLine ctermfg=247
" hi ERROR ctermfg=160
" hi WARNING ctermfg=178
" hi INFORMATION ctermfg=20
" hi HINT ctermfg=107
hi ERROR guifg=#DE1F1F guibg=aaron_statusline_bg
hi WARNING guifg=#F0F02D guibg=aaron_statusline_bg
hi INFORMATION guifg=#4273E5 guibg=aaron_statusline_bg
hi HINT guifg=#7BD546 guibg=aaron_statusline_bg

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

" Not sure what these ones are for
"cnoremap <C-p> <Up>
"cnoremap <C-n> <Down>

" fzf
nmap <C-p> :FZF<CR>
nmap <C-s> :Fa<CR>

nnoremap <silent> <Leader>vd :exe "vertical resize -5"<CR>
nnoremap <silent> <Leader>vi :exe "vertical resize +5"<CR>
nnoremap <silent> <Leader>sd :exe "resize -5"<CR>
nnoremap <silent> <Leader>si :exe "resize +5"<CR>

nnoremap <silent> <Leader>k :set cursorcolumn!<Bar>set cursorline!<CR>

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
nmap <Leader>w <Plug>(easymotion-w)
nmap <Leader>b <Plug>(easymotion-b)

map <silent> <C-n> :NERDTreeToggle<CR>

nmap <C-l> :TagbarToggle<CR>

" tsuquyomi
"autocmd FileType typescript nmap <buffer> <Leader>r <Plug>(TsuquyomiRenameSymbol)
"autocmd FileType typescript nmap <buffer> <Leader>R <Plug>(TsuquyomiRenameSymbolC)
" autocmd FileType typescript nmap <buffer> <Leader>f <Plug>(TsuquyomiReferences)
"autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>

" COC
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<Tab>"
nmap <silent> <Leader>t <Plug>(coc-type-definition)

nmap <silent> gd <Plug>(coc-declaration)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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
nnoremap <Leader>dd :call vimspector#Launch()<CR>
nnoremap <Leader>de :call vimspector#Reset()<CR>
nnoremap <Leader>dc :call vimspector#Continue()<CR>

nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>

nmap <Leader>dk <Plug>VimspectorRestart
nmap <Leader>dh <Plug>VimspectorStepOut
nmap <Leader>dl <Plug>VimspectorStepInto
nmap <Leader>dj <Plug>VimspectorStepOver

" Open go to definition in new tab
" :nnoremap <silent><C-]> <C-w><C-]><C-w>T

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

"=========================== VIMSPECTOR SETTINGS "===============================
let g:vimspector_base_dir='/Users/aaron/.vim/plugged/vimspector'
