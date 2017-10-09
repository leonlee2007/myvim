" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set nobackup		" keep a backup file
endif
set history=500		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif


" 获取当前路径，将$HOME转化为~
function! CurDir()	
	let curdir = substitute(getcwd(), $HOME, "~", "g")
	return curdir
endfunction


" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  set ts=2
  set sw=2
	set expandtab
  set smartindent
  set cindent
  syn on
  set number

  " status line
  set laststatus=2   " always show status line
  "set statusline+=%f " show filename in status line
  highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue
  set statusline=[%n]\|pwd:%{CurDir()}\ File:%f%m%r%h\ \|%=\|\ %l,%c\ %p%%\ \|%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}\ 

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")


" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif


" taglist
nnoremap <silent> <F9> :TlistToggle<CR>
let Tlist_Auto_Open = 0
let Tlist_Use_Right_Window = 1
let Tlist_Use_SingleClick = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_WinWidth = 80
"colorscheme molokai
"set wildignore+=*/tmp/*,*/prof_output/*,*/ebin/*,*.so,*.swp,*.zip     " Linux/MacOSX
"let g:ctrlp_user_command = 'ag -g \.erl$ %s'
"let g:ctrlp_user_command = 'find %s -type f | grep "\.csv$\|\.lua$\|\.log$\|\.proto$\|\.hrl$\|\.erl$"' "linux有效， mac只认最后一项
"let g:ctrlp_user_command = 'find %s -type f  -name *.erl -o -name *.hrl -o -name *.log -o -name *.proto'
"noremap <c-a> :%ArrangeColumn<cr>

let g:ctrlp_user_command = 'find %s -type f  -name "*.erl" -o -name "*.hrl" -o -name "*.log" -o -name "*.proto" -o -name "*.sh" ' "mac和linux 有效
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:30,results:45'

"let g:UltiSnipsExpandTrigger  = "<c-b>"

let mapleader = ","

"inoremap <leader>w <Esc>:%s/\<<c-r>=expand("<cword>")<cr>\>/<c-r>=expand("<cword>")<cr>/g<Left><Left>
"nnoremap <leader>w :%s/\<<c-r>=expand("<cword>")<cr>>/<c-r>=expand("<cword>")<cr>/g<Left><Left>
"inoremap <leader>wc <Esc>:%s/\<<c-r>=expand("<cword>")<cr>\>/<c-r>=expand("<cword>")<cr>/gc<Left><Left><Left>
"nnoremap <leader>wc :%s/\<<c-r>=expand("<cword>")<cr>\>/<c-r>=expand("<cword>")<cr>/gc<Left><Left><Left>
"inoremap <leader>= <esc>ggvG= 
"nnoremap <leader>= ggvG=
inoremap <leader>a <esc>ggvG 
nnoremap <leader>a ggvG
inoremap <leader>h <esc>:nohl<cr> 
nnoremap <leader>h :nohl<cr>
xnoremap <leader>h :nohl<cr>

inoremap <leader>f <Esc>:grep -r '<c-r><c-w>' .<cr><cr>:cw<cr><cr>
nnoremap <leader>f :grep -r '<c-r><c-w>' .<cr><cr>:cw<cr><cr>
xnoremap <leader>f y:grep -r '<c-r>0' .<cr><cr>:cw<cr><cr>

inoremap <leader>fc <Esc>:grep -r -C1 '<c-r><c-w>' .<cr><cr>:cw<cr><cr>
nnoremap <leader>fc :grep -r -C1 '<c-r><c-w>' .<cr><cr>:cw<cr><cr>
xnoremap <leader>fc y:grep -r -C1 '<c-r>0' .<cr><cr>:cw<cr><cr>

inoremap <leader>w <Esc>:%s/<c-r>=expand("<cword>")<cr>/<c-r>=expand("<cword>")<cr>/g<Left><Left>
nnoremap <leader>w :%s/<c-r>=expand("<cword>")<cr>>/<c-r>=expand("<cword>")<cr>/g<Left><Left>
inoremap <leader>wc <Esc>:%s/\<<c-r>=expand("<cword>")<cr>\>/<c-r>=expand("<cword>")<cr>/gc<Left><Left><Left>
nnoremap <leader>wc :%s/\<<c-r>=expand("<cword>")<cr>\>/<c-r>=expand("<cword>")<cr>/gc<Left><Left><Left>
inoremap <leader>wn <Esc>:%s/\<<c-r>=expand("<cword>")<cr>\>//gn<cr>
nnoremap <leader>wn :%s/\<<c-r>=expand("<cword>")<cr>\>//gn<cr>

inoremap <leader>e <Esc>:CtrlPMRUFiles<cr>
nnoremap <leader>e :CtrlPMRUFiles<cr>
inoremap <leader>r <Esc>:CtrlPBufTag<cr>
nnoremap <leader>r :CtrlPBufTag<cr>
inoremap <leader>t <Esc>:CtrlPBuffer<cr>
nnoremap <leader>t :CtrlPBuffer<cr>
inoremap <leader>" <Esc>:s/<c-r><c-w>/"<c-r><c-w>"/<cr>
nnoremap <leader>" :s/<c-r><c-w>/"<c-r><c-w>"/<cr>
xnoremap <leader>" y:s/<c-r>0/"<c-r>0"/<cr>
"inoremap <tab> :<Esc>CtrlPBuffer<cr> 
"nnoremap <tab> :CtrlPBuffer<cr>

"set path+=~/p4/trunk/server/common/**/
"set path+=common/**/
set path+=**/

xnoremap * y/<c-r>0<cr>
xnoremap # y?<c-r>0<cr>
