if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
  set lines=75 columns=100
  set guifont=Bitstream\ Vera\ Sans\ Mono\ 9
else
  " This is console Vim
  colorscheme ir_black
  set ttymouse=xterm "
"  set nuw=6
endif

"set wrap
"set wrapmargin=1
  
" From HERE to OTHER (below) see http://www.guckes.net/vim/setup.html
set nocp
set ai
" Add cursor "ruler"
set ru 
set vb
set wmnu
set noeb
" Always show status line
set ls=2
" shorten messages
set shm=at
" allow scrolling to end of line and then start of next line
set ww=<,>,h,l

" Setup viminfo to allow sessions: 
set vi=%,'50 
set vi+=\"100,:100 
set vi+=n~/.viminfo

" OTHER: 
if version >= 600
  filetype plugin indent on
endif

syntax on
set et
set sw=4
set tabstop=4
set smarttab
"set noautoindent
"set number

"au FileType python source ~/.vim/python.vim
set mouse=a
"filetype plugin on
"filetype indent on
"let g:gtex_flavor='latex'
"set guicursor=o:hor5

"au BufNewFile,BufRead *.cu   setf cu
"au fileType cu source cpp.vim

au BufNewFile,BufRead *.cl set filetype=cpp
au BufNewFile,BufRead *.tex set number
" au FileType c,cl,cpp source ~/.vim/opencl.vim


"---------------------
"" Settings for Fortran
"---------------------
""
:let fortran_have_tabs=1
:let fortran_more_precise=1
:let fortran_do_enddo=1
"   to instruct the syntax script to define fold regions for program units,
"   that is main programs starting with a program statement, subroutines,
"   function subprograms, block data subprograms, interface blocks, and modules.
" :let fortran_fold=1
"   fold regions will also be defined for do loops, if blocks, and select
"   case constructs.
" :let fortran_fold_conditionals=1
" :let fortran_fold_multilinecomments=1
:let fortran_dialect='f95'
:let fortran_free_source=1



" Autoload session information when vim is quit with qa
"
" " Creates a session
function! MakeSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:sessionfile = b:sessiondir . '/session.vim'
  exe "mksession! " . b:sessionfile
endfunction

" Updates a session, BUT ONLY IF IT ALREADY EXISTS
function! UpdateSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe "mksession! " . b:sessionfile
    echo "updating session"
  endif
endfunction

" Loads a session if it exists
function! LoadSession()
  if argc() == 0
    let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
    let b:sessionfile = b:sessiondir . "/session.vim"
    if (filereadable(b:sessionfile))
      exe 'source ' b:sessionfile
    else
      echo "No session loaded."
    endif
  else
    let b:sessionfile = ""
    let b:sessiondir = ""
  endif
endfunction

au VimEnter * :call LoadSession()
au VimLeave * :call UpdateSession()
map <leader>m :call MakeSession()<CR>

source ~/.vim/custom_mswin.vim

