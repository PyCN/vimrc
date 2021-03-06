set nocompatible             " 设置不兼容vi"
set encoding=utf-8           " 设置支持utf-8格式文件
set clipboard=unnamed        "使用系统剪切板
set nu                       "使用行号
set tabstop=4                "设置table长度"
let mapleader=";"

set nocompatible             " required
filetype off                 " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required



" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za
" see docstring
let g:SimpylFold_docstring_preview=1
Plugin 'tmhedberg/SimpylFold'



" For indent and PEP8
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2
hi BadWhitespace guifg=gray guibg=red ctermfg=gray ctermbg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
Plugin 'vim-scripts/indentpython.vim'


" For YouCompleteMe
let g:ycm_complete_in_comments = 1  "在注释输入中也能补全
let g:ycm_complete_in_strings = 1   "在字符串输入中也能补全
let g:ycm_collect_identifiers_from_comments_and_strings = 1 "收集注释中的字符串
let g:ycm_autoclose_preview_window_after_completion=1
" 回车即选中当前项
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
" 表示跳转到定义处
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" 支持在virtualenv中使用
"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
Bundle 'Valloric/YouCompleteMe'


" For syntastic 
let python_highlight_all=1
syntax on
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'


" For NERDTree
" F2开启和关闭树
map <F2> :NERDTreeToggle<CR>
let NERDTreeChDirMode=1
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
let NERDTreeWinSize=25
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd l
" 当前无文件时,nerdtree自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
Plugin 'scrooloose/nerdtree'

" A plugin of NERDTree showing git status
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
Plugin 'Xuyuanp/nerdtree-git-plugin'

" For run python
map <F5> :call RunPython()<CR>
function RunPython()
  let mp = &makeprg
  let ef = &errorformat
  let exeFile = expand("%:t")
  setlocal makeprg=python\ -u
  set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
  silent make %
  copen
  let &makeprg = mp
  let &errorformat = ef
endfunction


" 自动补全括号等以及多行注释
" <leader>cc行前注释, <leader>cu解除注释
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/nerdcommenter'

"autopep8设置"
let g:autopep8_disable_show_diff=1
let g:autopep8_max_line_length=79
Plugin 'tell-k/vim-autopep8'

" global catalog search
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*/node_modules/*,*.so,*.swp,*.zip     
let g:ctrlp_custom_ignore = {'dir':  '\v[\/]\.(git|hg|svn)$', 'file':'\v\.(exe|so|dll)$'}
Plugin 'kien/ctrlp.vim'

" For function list and macro
map <F3> :TagbarToggle<CR>
let g:tagbar_width=25
let g:tagbar_sort=1
au BufNewFile,BufRead *.py,*.c,*.cpp call tagbar#autoopen()
Plugin 'majutsushi/tagbar'
