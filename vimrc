" If installed using git
set rtp+=~/.fzf
filetype on
let mapleader="§"
let maplocalleader="§"


"let g:pathogen_disabled = ['ale']
execute pathogen#infect()
autocmd BufWritePost .vimrc source %

let loaded_matchit = 1


" Colors
set t_Co=256
colorscheme spacegray

" Spaces, indents and Tabs
set encoding=utf8
set shiftwidth=2 softtabstop=2 tabstop=2 softtabstop=2 tabstop=2   " Tabs under smart indent
set expandtab
set nowrap  " Line wrapping off
filetype indent on
set textwidth=0 wrapmargin=0 "Turns off automatic newLines

" Special Rules for some filetypes
autocmd BufRead,BufNewFile *.xml set noexpandtab

" UI Config
set number
set showcmd
set wildmenu " Shows autocomplete in CommandLine
syntax on
syntax enable

set showmatch  " Show matching brackets.  set mat=5  " Bracket blinking.

set list
set lcs=tab:\▸\ ,eol:$,trail:~,extends:>,precedes:< " Show $ at end of line and trailing space as ~
set viminfo^=!

set novisualbell  " No blinking .
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.
set statusline+=%F

" Searching
set incsearch
set hlsearch"

" Folding
set foldenable
set foldmethod=indent
autocmd BufWinEnter * let &foldlevel = max(map(range(1, line('$')), 'foldlevel(v:val)')) "With this, everything is unfolded at start
set foldnestmax=100

" Movement
" move vertically by visual line
nnoremap j gj
nnoremap k gk
" Map Buffer movement to Ctrl instead of ctrl+w
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Use one of the following to define the camel characters.
" Stop on capital letters.
" let g:camelchar = "A-Z"
" Also stop on numbers.
" let g:camelchar = "A-Z0-9"
" Include '.' for class member, ',' for separator, ';' end-statement,
" and <[< bracket starts and "'` quotes.
let g:camelchar = "A-Z0-9_.,;:{([<`'\""
" nnoremap <silent><Left> :<C-u>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%^','bW')<CR>
" nnoremap <silent><Right> :<C-u>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%$','W')<CR>
" inoremap <silent><Left> <C-o>:call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%^','bW')<CR>
" inoremap <silent><Right> <C-o>:call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%$','W')<CR>
" vnoremap <silent><Left> :<C-U>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%^','bW')<CR>v`>o
" vnoremap <silent><Right> <Esc>`>:<C-U>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%$','W')<CR>v`<o
" " also allow it as movement in commands
" onoremap <silent><Left> :<C-u>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%^','bW')<CR>
" onoremap <silent><Right> :<C-u>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%$','W')<CR>

" Move CamelCase with H & L but only as movement
onoremap <silent>H :<C-u>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%^','bW')<CR>
onoremap <silent>L :<C-u>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%$','W')<CR>

" nnoremap <silent><C-Down> :tjump <C-r><C-w><CR>
" nnoremap <silent><C-Up> :stjump <C-r><C-w><CR>
" nnoremap <silent><S-Down> :tnext<CR>
" nnoremap <silent><S-Up> :tprevious<CR>

" Custom Functions
"
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

" Closes all Buffers bit the current one
function! CloseAllBuffersButCurrent()
  let curr = bufnr("%")
  let last = bufnr("$")

  if curr > 1    | silent! execute "1,".(curr-1)."bd"     | endif
  if curr < last | silent! execute (curr+1).",".last."bd" | endif
endfunction

nmap <Leader><F4> :call CloseAllBuffersButCurrent()<CR>


" Autogroups
augroup configgroup
    autocmd!
    autocmd BufWritePre *.rb,*.php,*.py,*.js,*.txt,*.hs,*.java,*.md call <SID>StripTrailingWhitespaces()
    autocmd FileType ruby map <F9> :RuboCop -a<CR>
    autocmd BufWritePre *.rb :normal call Preserve(gg=G)
    " autocmd BufWritePost *.rb :RuboCop -s
augroup END

let g:airline_section_c = '%F'

" Change which file opens after executing :Rails command
let g:rails_default_file='config/database.yml'

" Tab

set cf  " Enable error files & error jumping.
set clipboard+=unnamed  " Yanks go on clipboard instead.
set history=10000 " Number of things to remember in history.
set undodir=~/.vim/tmp/undo/
set undofile
set autowrite  " Writes on make/shell commands
set ruler  " Ruler on
set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay)
"
" Formatting (some of these are for coding in C and C++)
set bs=2  " Backspace over everything in insert mode
set nocp incsearch
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case
set formatoptions=tcqr
set cindent
set smarttab
" Visual
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1
" Ruby syntax check with F9
" Remove Trailing Whitespaces with F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

set pastetoggle=<F10>

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  " Integrate ag into ACK
  let g:ackprg = 'ag --vimgrep'
endif

" Show Invisibles

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" map alt + p to search buffers (CtrlP plugin)
let g:ctrlp_map = '<ESC>p'
let g:ctrlp_cmd = 'CtrlPBuffer'


" Save all swapfiles in this directory, not in the project folder
set backupdir=~/.vim/swap_files/
set directory=~/.vim/swap_files/
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

nnoremap <F1> :UndotreeToggle<cr>

" A wrapper function to restore the cursor position, window position,
" and last search after running a command.
function! Preserve(command)
  let l:save = winsaveview()
  execute a:command
  call winrestview(l:save)
  " Save the last search
  " let last_search=@/
  " " Save the current cursor position
  " let save_cursor = getpos(".")
  " " Save the window position
  " normal H
  " let save_window = getpos(".")
  " call setpos('.', save_cursor)
  "
  " " Do the business:
  " execute a:command
  "
  " " Restore the last_search
  " let @/=last_search
  " " Restore the window position
  " call setpos('.', save_window)
  " normal zt
  " " Restore the cursor position
  " call setpos('.', save_cursor)
endfunction

cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

" FZF Better for Searching big projects than Ctrl + P
if executable('fzf')
  autocmd VimEnter * nnoremap <C-p> :FZF <CR>
endif

let g:ale_statusline_format = ['E %d', 'W %d', '- ok']
" let g:ale_sign_column_always = 1
" lint only on save
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
" You can disable this option too
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0

call airline#parts#define_function('ALE', 'ALEGetStatusLine')
call airline#parts#define_condition('ALE', 'exists("*ALEGetStatusLine")')
let g:airline_section_error = airline#section#create_left(['ALE'])

" let g:UltiSnipsExpandTrigger="§"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<S-tab>"


" --------- NEO Complete -------------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 1
let g:neocomplete#disable_auto_complete=1

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ neocomplete#start_manual_complete()
function! s:check_back_space() "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
inoremap <expr><s-TAB>  pumvisible() ? "\<C-p>" : "\<s-TAB>"

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
