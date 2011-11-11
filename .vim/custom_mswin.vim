" Set options and add mapping such that Vim behaves a lot like MS-Windows
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2006 Apr 02

" bail out if this isn't wanted (mrsvim.vim uses this).
if exists("g:skip_loading_mswin") && g:skip_loading_mswin
  finish
endif

" set the 'cpoptions' to its Vim default
if 1	" only do this when compiled with expression evaluation
  let s:save_cpo = &cpoptions
endif
set cpo&vim

" set 'selection', 'selectmode', 'mousemodel' and 'keymodel' for MS-Windows
" disabled because it provides shift highlight but does not keep 'v' visual
" select and visual mode gg=G
"behave mswin

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

" backspace in Visual mode deletes selection
vnoremap <BS> d

" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X> "+x
vnoremap <S-Del> "+x

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y

" CTRL-V and SHIFT-Insert are Paste
map <C-V>		"+gP
map <S-Insert>		"+gP

cmap <C-V>		<C-R>+
cmap <S-Insert>		<C-R>+

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.

exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

imap <S-Insert>		<C-V>
vmap <S-Insert>		<C-V>

" Use CTRL-Q to do what CTRL-V used to do
noremap <C-Q>		<C-V>

" Use CTRL-S for saving, also in Insert mode
noremap <C-S>		:update<CR>
vnoremap <C-S>		<C-C>:update<CR>
inoremap <C-S>		<C-O>:update<CR>

" For CTRL-V to work autoselect must be off.
" On Unix we have two selections, autoselect can be used.
if !has("unix")
  set guioptions-=a
endif

" CTRL-Z is Undo; not in cmdline though
"noremap <C-Z> u
"inoremap <C-Z> <C-O>u

" CTRL-Y is Redo (although not repeat); not in cmdline though
noremap <C-Y> <C-R>
inoremap <C-Y> <C-O><C-R>

" Alt-Space is System menu
if has("gui")
  noremap <M-Space> :simalt ~<CR>
  inoremap <M-Space> <C-O>:simalt ~<CR>
  cnoremap <M-Space> <C-C>:simalt ~<CR>
endif

" CTRL-A is Select all
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG

" CTRL-Tab is Next window
noremap <C-Tab> <C-W>w
inoremap <C-Tab> <C-O><C-W>w
cnoremap <C-Tab> <C-C><C-W>w
onoremap <C-Tab> <C-C><C-W>w

" CTRL-F4 is Close window
noremap <C-F4> <C-W>c
inoremap <C-F4> <C-O><C-W>c
cnoremap <C-F4> <C-C><C-W>c
onoremap <C-F4> <C-C><C-W>c

" tab navigation with arrow keys and CTRL-T to open new, CTRL-W to close
" CTRL-L to change the uri
" NOTE: we also support changing tabs and creating new ones when in 
" command mode (look at the "cmap"s)
map <C-left> :tabprevious<CR>
nmap <C-left> :tabprevious<CR>
cmap <C-left> <C-u>:tabprevious<CR>
imap <C-left> <Esc>:tabprevious<CR>i

map <C-right> :tabnext<CR>
nmap <C-right> :tabnext<CR>
cmap <C-right> <C-u>:tabnext<CR>
imap <C-right> <Esc>:tabnext<CR>i

map <C-S-left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nmap <C-S-left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
cmap <C-S-left> <C-u>:execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
imap <C-S-left> <Esc>:execute 'silent! tabmove ' . (tabpagenr()-2)<CR>i

map <C-S-right> :execute 'silent! tabmove ' . tabpagenr()<CR>
nmap <C-S-right> :execute 'silent! tabmove ' . tabpagenr()<CR>
cmap <C-S-right> <C-u>:execute 'silent! tabmove ' . tabpagenr()<CR>
imap <C-S-right> <Esc>:execute 'silent! tabmove ' . tabpagenr()<CR>i


map <C-up> :tabfirst<CR>
cmap <C-up> <C-u>:tabfirst<CR>
nmap <C-up> <Esc>:tabfirst<CR>

map <C-down> :tablast<CR>
cmap <C-down> <C-u>:tablast<CR>
nmap <C-down> <Esc>:tablast<CR>

nmap <C-t> :tabnew<CR>:e  
cmap <C-t> <C-u>:tabnew<CR>:e  
imap <C-t> <Esc>:tabnew<CR>:e  

map <C-w> :tabclose<CR>
cmap <C-w> <C-u>:tabclose<CR>
nmap <C-w> <Esc>:tabclose<CR>

map <C-l> :e   
cmap <C-l> <C-u>:e  
nmap <C-l> <Esc>:e  

map <C-\> :AT<CR> 
cmap <C-\> <C-u>:AT<CR>
nmap <C-\> <Esc>:AT<CR>

" Get some support for window commands: 
" traverse to the next window split
map <Tab> :wincmd w<CR> 

" restore 'cpoptions'
set cpo&
if 1
  let &cpoptions = s:save_cpo
  unlet s:save_cpo
endif



