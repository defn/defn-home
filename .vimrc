" source junas
source ~/.vim/junas.vimrc

" install whatever bundles over the net
silent call Bundle(["vim-go", "vim-clojure-static", "fireplace", "vim-clojure-highlight"])
silent call Bundle(["xoria256", "Solarized"])
silent call Bundle(["surround", "repeat", "Rainbow_Parenthesis", "matchit.zip", "eregex"])

let cue_scheme=$CUE_SCHEME_VIM

if cue_scheme == 'slight'
  " use the Solarized color scheme for light
  colorscheme Solarized
  set background=light
else
  " use the xoria256 color scheme for dark
  colorscheme xoria256
  hi Folded  ctermfg=180 guifg=#dfaf87 ctermbg=234 guibg=#1c1c1c
  hi NonText ctermfg=252 guifg=#d0d0d0 ctermbg=234 guibg=#1c1c1c cterm=none gui=none
endif

set shiftround smarttab
set autoindent smartindent
set showmatch

set hidden
set nowrap
set nonumber

set history=1000
set undolevels=1000
set title
set visualbell
set noerrorbells
set t_vb=

set scrolloff=3
set nojoinspaces

set nobackup
set noswapfile

set diffopt+=iwhite
set diffexpr="-w -b -B"

set guioptions=

" to prevent screen restores
" see http://wiki.bash-hackers.org/scripting/terminalcodes#background_coloring
" set t_ti= t_te=
