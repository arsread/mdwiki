set nocompatible               " be iMproved
filetype off                   " required!       


set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


" let Vundle manage Vundle
" required! 
Plugin 'gmarik/vundle'

" original repos on github
"Plugin 'scrooloose/nerdtree'
Plugin 'Lokaltog/vim-powerline'

" vim-scripts repos
" which you can fin in http://vim-scripts.org/vim/scripts.html
Plugin 'taglist.vim' 
Plugin 'The-NERD-tree'
Plugin 'SuperTab'  
Plugin 'Auto-Pairs'  
Plugin 'echofunc.vim'  
Plugin 'rainbow_parentheses.vim'  
Plugin 'vimomni'
Plugin 'XML-Completion'
Plugin 'html-xml-tag-matcher'
Plugin 'HTML-AutoCloseTag'
Plugin 'phpcomplete.vim'
Plugin 'javacomplete'
Plugin 'Python-mode-klen'
Plugin 'python-imports.vim'
Plugin 'Emmet.vim'
Plugin 'minibufexpl.vim'
Plugin 'c.vim'

"Plugins for Latex
"Plugin 'tex.vim'

"Plugin 'lsdr/monokai'
"Plugin 'Powerline'  

"indent
call vundle#end()
filetype plugin indent on

"AutoCompelete
autocmd FileType python setlocal et sta sw=4 sts=4
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascrīpt set omnifunc=javascrīptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType java set omnifunc=javacomplete#Complete

"line num on
set nu

"set wrap
set wrap

"syntax on
syntax on

"configuration for solarized
set background=dark
colorscheme solarized

"foldup
set fdm=marker

"shortcut for plugins
nmap <F2> :NERDTreeToggle<CR>
nmap <F3> :TlistToggle<CR>
nmap <F4> :!ctags -R --fields=+lS<CR>
imap <c-a> <C-x><C-o>
map <c-h> :bp<CR>
map <c-l> :bn<CR>

"Taglist setting
let Tlist_Auto_Open=1
let Tlist_Use_Right_Window=1
let Tlist_Show_One_File=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Exit_OnlyWindow=1

"NerdTree setting
hi treeDir guifg=#ff0000 guibg=#00ff00 
let NERDTreeWinPos="left"
let NERDChristmasTree=1 

"Power-line settings
  "256 color
set t_Co=256
  "recommend for powerline
set nocompatible
set laststatus=2
set encoding=utf8
  "choose theme
let g:Powerline_symbols = 'compatible'

"auto-pairs settings
let g:AutoPairs = {'[':']', '{':'}', "'":"'",'"':'"', '`':'`'}

"echofunc settings
let g:EchoFuncKeyPrev = '<C-k>'
let g:EchoFuncKeyNext = '<C-j>'

"desertpython auto-import setting
let g:PythonAutoAddImports = 1

"python mode setting
let g:pymode_rope = 1
let g:pymode_rope_map_space = 0
"let g:pymode_rope_autocomplete_map = '<C-k>'
			
"rainbow parentheses
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
