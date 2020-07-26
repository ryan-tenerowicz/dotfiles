set nocompatible
filetype off
set autoindent
set backspace=indent,eol,start
set clipboard=unnamedplus
set completeopt-=preview
set expandtab
set laststatus=2
set mouse=a
set noshowmode
set number relativenumber
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
set updatetime=100

color molokai

command W w

nnoremap <S-J> <C-E><C-E><C-E><C-E><C-E><C-E><C-E>
nnoremap <S-K> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>

nnoremap h :wincmd h<CR>
nnoremap j :wincmd j<CR>
nnoremap k :wincmd k<CR>
nnoremap l :wincmd l<CR>

inoremap <silent> h <ESC>:wincmd h<CR>
inoremap <silent> j <ESC>:wincmd j<CR>
inoremap <silent> k <ESC>:wincmd k<CR>
inoremap <silent> l <ESC>:wincmd l<CR>

nnoremap 1 1gt
nnoremap 2 2gt
nnoremap 3 3gt
nnoremap 4 4gt
nnoremap 5 5gt
nnoremap 6 6gt
nnoremap 7 7gt
nnoremap 8 8gt
nnoremap 9 9gt
nnoremap 0 0gt

nnoremap <silent> <F2> :nohl<CR>
set pastetoggle=<F3>

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
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}'], ['<', '>']]
autocmd VimEnter * RainbowParentheses

Plug 'jiangmiao/auto-pairs'
let g:AutoPairs={'(':')', '[':']', '{':'}', '<':'>', "'''":"'''"}

Plug 'justinmk/vim-sneak'
let g:sneak#s_next = 1
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

Plug 'ycm-core/YouCompleteMe'
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_confirm_extra_conf=0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_key_list_select_completion = ['<TAB>']
let g:ycm_key_list_previous_completion = ['<S-TAB>']
let g:ycm_key_list_stop_completion = ['<UP>', '<DOWN>']
let g:ycm_seed_identifiers_with_syntax = 0
let g:ycm_collect_identifiers_from_tags_files = 1
nnoremap <silent> <C-g> :YcmCompleter GoTo<CR>
nnoremap <silent> <C-f> :YcmCompleter GoToReferences<CR>
nnoremap <silent> <C-i> :YcmCompleter GoToInclude<CR>

Plug 'dense-analysis/ale'
let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1
let g:ale_linters = {
    \'python': ['bandit', 'mypy', 'flake8', 'vulture'],
    \}
let g:ale_fixers = {
    \'*': ['remove_trailing_lines', 'trim_whitespace'],
    \'python': ['yapf', 'isort', 'add_blank_lines_for_python_control_statements'],
    \}

"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"highlight CocHighlightRead ctermfg=81
""autocmd CursorHold * silent call CocActionAsync('highlight')
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


Plug 'psliwka/vim-smoothie'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-unimpaired'
Plug 'suan/vim-instant-markdown', {'rtp': 'after'}
Plug 'tpope/vim-surround'

call plug#end()
filetype plugin indent on
syntax on
