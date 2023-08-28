set nocompatible
filetype off

call plug#begin('~/.vim/plugins')

" Yank copies text to local system clipboard over ssh
Plug 'ojriques/vim-oscyank'
"Automatically copy remote buffer when it changes
autocmd TextYankPost * :execute 'OSCYankRegister 0'
" Copy autocmd/ cut into a non standard buffer
" reg 0 holds the last copied selection from yank. Vim's default behavior is to copy any
" text deleted from a selection to the system clipboard which is not the expected copy/
" paste behavior (when trying to paste multiple times, will overrite the paste with the
" last deleted text). By using 0, only explicit yank commands will overwrite the copy
" register. This also works for movements such as yiw.
" Mappings are:
" y -> copy
" d -> cut
" x -> delete (no copy)
" p -> paste
vnoremap p "0p
nnoremap p "0p
nnoremap P "0P
" d does not copy by default
nnoremap <silent> d :set opfunc=CopyCut<CR>g@
function! CopyCut(type)
    silent exec 'normal! `[v`]"0d'
endfunction
nnoremap dd "0dd
vnoremap d "0d

Plug 'ycm-core/YouCompleteMe'
let g:ycm_add_prev_iew_to_completeopt = 0
let g:ycm_max_num_candidates = 20
" Hovering over a token opens its docstring
let g:ycm_auto_hover = ''
" Show error as popup on hover
let g:ycm_show_detailed_diag_in_popup=1

Plug 'preservim/nerdtree'
let NERDTreeMapOpenSplit='s'
let NERDTreeMapOpenVSplit='d'

" Only open NERDTree when in repo
autocmd VimEnter * if stridx(getcwd(), 'REPLACE_WITH_NAME') != -1 | NERDTree | wincmd p | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
" Requires a weird delay for tabc because vim doesn't allow closing in BufEnter https://groups.google.com/g/vim_dev/c/Cw8McBH6DDM
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call timer_start(10, {-> execute('tabc') }) | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Sync NERDTree to current file
function! SyncTree()
    if &modifiable && exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1) && strlen(expand'%')) > 0 && !&diff && bufname('%') !~# 'NERD_tree'
        try
            NERDTreeFind
            if bufname('%') =~# 'NERD_tree'
                setlocal cursorline                    
                wincmd p
            endif
        endtry
    endif
endfunction
autocmd BufEnter * silent! call SyncTree()
" At startup BufEnter doesn't really work due to not everything loading, so
" call it at startup with a delay
autocmd VimEnter * call timer_start(100, { tid -> execute('call SyncTree()')})

Plug 'junegunn/fzf', { 'do': { -> fzf#install() })
Plug 'junegunn/fzf.vim',
let g:fzf_layout = { 'window': { 'width: 0.9, 'height': 0.9 } }
" Remap commands for opening file in fzf preview
" By default open in split
let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-s': 'split',
    \ 'ctrl-r': 'vsplit',
    \ 'ctrl-e': 'edit',
    \ 'enter': 'vsplit' }
" Open files with preview
" Don't use 'sink': 'vsplit' as it does not allow use of fzf_action mapping
command ! -bang -nargs=? -complete=dir Files call fzf#vim#files('', fzf#vim#with_preview({
    \'source': 'find . -type f | awk ''!/.git\//'' | awk ''{print substr$1, 3);}''',
    \}))
nnoremap \f :Files<CR>
command ! -bang -nargs=? -complete=dir FZFEdit call fzf#vim#files('', fzf#vim#with_preview({
    \'source': 'find . -type f | awk ''!/.git\//'' | awk ''{print substr$1, 3);}''',
    \'sink': 'edit',
    \}))
nnoremap \e :FZFEdit<CR>

" Open changed files in current git commit
command ! -bang -nargs=? -complete=dir Changed call fzf#vim#files('', fzf#vim#with_preview({
    \'source': '{ git log --pretty="format:" --name-only -n 1; git status --porcelain | sed s/^...\\; } | sort | uniq',
    \}))
nnoremap \c :Changed<CR>

" Parses the visual range input and sends to ripgrep
" Or uses empty string if no selection
function! RipGrepHelper() ranage
    let l:search=""
    " Only use selection if 1 line is selected, search won't handle multiline strings
    if a:firstline == a:lastline
        " Read text and clear whitespace
        let l:search=substitute(getline("'<")[getpost("'<")[2]-1:getpos("'>")[2]-1], '^\s*\(.\{-}\)\s*$', '\1', '')
    endif
    " Visual range marks will retain last selection and affect the next call, so they are cleared
    silent! execute "delm <>"
    call fzf#vim#grep(
    \ "rg --column --line-number --no-heading --color=always --smart-case
    \ -g='!*.js' -g='!*.ts' -g='!*.json' -g='!*.yaml' -g='!*.lock' -g='!*.html'
    \ -- ".shellescape(l:search), 1, fzf#vim#with_preview(), 0)
endfunction
command! -bang -nargs=? -range Rg <line1>,<line2> call RipGrepHelper()
nnoremap \r :Rg<CR>

Plug 'justinmk/vim-sneak'
" s__, s-> 2 chars goes to next match
" S to search backwards, ; next match , prev match
let g:sneak#s_next = 1
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

"Highlights the text that is yanked
Plug 'machakann/vim-highlightedyank'

" Smooth scroll screen
Plug 'psliwka/vim-smoothie'
nnoremap <S-J> <cmd>call smoothie#do("20\<C-E>") <CR>
nnoremap <S-K> <cmd>call smoothie#do("20\<C-Y>") <CR>
" scroll search results to midscreen
nnoremap n nzz
nnoremap N Nzz

" Toggle full screen of split
Plug 'regedarek/ZoomWin'
nmap <c-w>p <Plug>ZoomWin

Plug 'junegunn/rainbow_parentheses.vim'
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
autocmd VimEnter * RainbowParentheses

Plug 'jiangmiao/auto-pairs'
let g:AutoPairs={'(':')', '[':']', '{':'}', '<':'>', "'''":"'''", '"""':'"""'}

Plug 'itchyny/lightline.vim'
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'gitbrnach': 'gitbranch#name',
      \   'filename': 'LightlineFilename',
      \ },
      \ }
function! LightlineFilename()
    let root = fnamemodify(get(b:, 'gitbranch_path'), ':h:h')
    let path = expand('%:p')
    if path[:len(root)-1] ==# root
        return path[len(root)+1:]
    endif
    return expand('%')
endfunction

" Colorscheme
Plug 'sickill/vim-monokai'

call plug#end()

set autoindent
set backspace=indent,eol,start
set clipboard=unnamedplus
set completeopt-=preview
set expandtab
set is hls
set laststatus=2
set mouse=a
set noshowmode
set number
set scrolloff=10
set tabstop=2 shiftwidth=2 expandtab
set shortmess+=c
set showcmd
set signcolumn=yes
set splitright
set splitbelow
set t_Co=256
set tabstop=2
set ttimeout
set ttimeoutlen=50
set ttymouse=sgr
set updatetime=100

" Save .swp files in differet dir to avoid polluting working dir
:silent call system('mkdir -p ~/.vim/swp')
set backupdir=~/.vim/swp/
set directory=~/.vim/swp/
" Vim saves undo history for files
:silent call system ('mkdir -p ~/.vim/undo')
set undodir=~/.vim/undo
set undofile
" Scroll mouse under cursor instead of selected window
set scrollfocus=scf
" Allow cursor to move past end of line onto newline char
set virtualedit=onemore
" Disable middle click paste
map <MiddleMouse> <NOP>
imap <MiddleMouse> <NOP>
" Space/backspace shouldn't mouse mouse in normal mode
nnoremap <Space> <NOP>
nnoremap <Backspace> <NOP>

nnoremap <F2> :nohl<CR>
nnoremap <silent> <F3> :setlocal spell! spelllang=en_us<CR>
set pastetoggle=<F4>

" Autoreload vimrc on write
augroup myvimrc
    au!
    au BufWritePost .vimrc so ~/.vimrc
augroup END

syntax on
colorscheme sublinemonokai
