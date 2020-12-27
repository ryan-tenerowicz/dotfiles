set nocompatible
filetype off
set autoindent
set backspace=indent,eol,start
set clipboard=unnamedplus
set completeopt-=preview
set expandtab
set is hls
set laststatus=2
set mouse=a
set noshowmode
set number relativenumber
set scrolloff=0
set shiftwidth=2
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

color molokai

autocmd InsertLeave * :normal `^

nnoremap <S-J> 6<C-E>
nnoremap <S-K> 6<C-Y>

nnoremap <silent> H :wincmd h<CR>
nnoremap <silent> J :wincmd j<CR>
nnoremap <silent> K :wincmd k<CR>
nnoremap <silent> L :wincmd l<CR>

nnoremap ! 1gt
nnoremap @ 2gt
nnoremap # 3gt
nnoremap $ 4gt
nnoremap % 5gt
nnoremap ^ 6gt
nnoremap & 7gt
nnoremap * 8gt
nnoremap ( 9gt
nnoremap ) 0gt

nnoremap <Space> <NOP>

nnoremap <F2> :nohl<CR>
nnoremap <silent> <F3> :setlocal spell! spelllang=en_us<CR>
set pastetoggle=<F4>

call plug#begin('~/.vim/plugins')
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'
command Split :call fzf#run({
    \'source': 'find . -type f | awk ''!/.git\//'' | awk ''{print substr($1, 3);}''',
    \'down': '30%',
    \'sink': 'split'
    \})

command Vsplit :call fzf#run({
    \'source': 'find . -type f | awk ''!/.git\//'' | awk ''{print substr($1, 3);}''',
    \'down': '30%',
    \'sink': 'vertical split'
    \})
command Edit :call fzf#run({
    \'source': 'find . -type f | awk ''!/.git\//'' | awk ''{print substr($1, 3);}''',
    \'down': '30%',
    \'sink': 'edit'
    \})
command Tab :call fzf#run({
    \'source': 'find . -type f | awk ''!/.git\//'' | awk ''{print substr($1, 3);}''',
    \'down': '30%',
    \'sink': 'tabedit'
    \})

Plug 'junegunn/rainbow_parentheses.vim'
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
autocmd VimEnter * RainbowParentheses

Plug 'jiangmiao/auto-pairs'
let g:AutoPairs={'(':')', '[':']', '{':'}', '<':'>', "'''":"'''", '"""':'"""'}

Plug 'justinmk/vim-sneak'
let g:sneak#s_next = 1
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"let g:coc_user_config = {
"  \ 'coc.preferences.jumpCommand': 'vsplit',
"  \ 'suggest.maxCompleteItemCounPE-LIMt': 10,
"  \ 'diagnostic.errorSign': 'E',
"  \ 'diagnostic.warningSign': 'W',
"  \ 'languageserver': {
"  \   'ciderlsp': {
"  \     'command': '/google/bin/releases/editor-devtools/ciderlsp',
"  \     'args': [
"  \       '--tooltag=coc-nvim',
"  \       '--noforward_sync_responses'
"  \     ],
"  \     'filetypes': [
"  \       'borg',
"  \       'c',
"  \       'cpp',
"  \       'go',
"  \       'java',
"  \       'proto',
"  \       'python',
"  \       'textproto'
"  \     ]
"  \   }
"  \ }
"  \}
"highlight CocHighlightRead ctermfg=81
"
"autocmd CursorHold * silent call CocActionAsync('highlight')
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"function! s:check_back_space() abort
"    let col = col('.') - 1
"    return !col || getline('.')[col - 1]  =~# '\s'
"endfunction
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
"nmap <silent> <C-g> <Plug>(coc-definition)
"nmap <silent> <C-f> <Plug>(coc-references)


Plug 'vim-syntastic/syntastic'
let g:syntastic_check_on_open = 1
let g:syntastic_auto_jump = 0

Plug 'psliwka/vim-smoothie'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'

call plug#end()

filetype plugin indent on
syntax on
