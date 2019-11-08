" vim: foldmarker={,} foldlevel=0 foldmethod=marker
" Plugins {
" PYTHONPATH mainly used for YCM to find python lib
  let mapleader=","

  call plug#begin('~/.vim/plugged')

  Plug 'vim-airline/vim-airline'
  Plug 'ctrlpvim/ctrlp.vim' | Plug 'tacahiroy/ctrlp-funky'
  Plug 'vim-scripts/a.vim'
  Plug 'jiangmiao/auto-pairs'
  Plug 'scrooloose/nerdcommenter'
  Plug 'majutsushi/tagbar'
  Plug 'alvan/vim-closetag'
  Plug 'mileszs/ack.vim'
  Plug 'easymotion/vim-easymotion'
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'junegunn/vim-easy-align'
  Plug 'Valloric/ListToggle'
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'Valloric/YouCompleteMe'
  Plug 'fatih/vim-go', { 'for': 'go' }
  Plug 'nanotech/jellybeans.vim'

  call plug#end()

  let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
  let g:ycm_always_populate_location_list=1
  let g:ycm_confirm_extra_conf = 0
  let g:ycm_key_invoke_completion = '<C-j>'
  "let g:ycm_register_as_syntastic_checker=1
  let g:ycm_show_diagnostics_ui = 0
  let g:ycm_enable_diagnostic_signs = 0
  let g:ycm_enable_diagnostic_highlighting = 0
  "Don't use preview window actually
  "let g:ycm_autoclose_preview_window_after_completion=1
  let g:ycm_goto_buffer_command = 'new-tab'
  nnoremap <silent><leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
  "use vim-go to do the goto function
  au FileType go nnoremap <leader>g :tab split <CR>:exec "GoDef"<CR>
  nnoremap <F12> :YcmDiags<CR>
  let g:ycm_server_keep_logfiles = 1

  if has('gui_running')
    let g:airline_powerline_fonts = 1
  else
    let g:airline_left_sep=''
    let g:airline_right_sep=''
  endif

  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#show_tab_nr = 0

  let g:EasyMotion_leader_key = '<space>'
  nnoremap <silent><leader>t :TagbarToggle<CR>
  let g:tagbar_iconchars          = ['+', '-']
  let g:tagbar_autofocus = 1
  let g:indent_guides_auto_colors = 0
  let g:indent_guides_start_level = 2
  let g:indent_guides_guide_size  = 1
  "Config for python highlight
  let g:python_version_2     = 1
  let g:cpp_class_scope_highlight = 1
  let g:cpp_experimental_template_highlight = 1

  set completeopt=menu,menuone
  map <C-K> :pyf ~/.vim/clang-format/clang-format.py<CR>
  imap <C-K> <c-o>:pyf ~/.vim/clang-format/clang-format.py<CR>
  let g:clang_format_fallback_style = 'Google'

  vmap <Enter> <Plug>(EasyAlign)

  noremap <silent><C-u> :tabp<CR>
  noremap <silent><C-i> :tabn<CR>

  "CtrlP
  let g:ctrlp_map='<c-p>'
  let g:ctrlp_cmd='CtrlP'
  let g:ctrlp_working_path_mode='ra'
  let g:ctrlp_by_filename=1
  nnoremap <Leader>fu :CtrlPFunky<Cr>
  " narrow the list down with a word under cursor
  nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
  set wildignore+=*/install/*,mk,mk50,mk51,mk50m,mk51m

  "ack-ag
  if executable('ag')
    let g:ackprg = 'ag --vimgrep'
  endif
  nnoremap <silent><leader>a :Ack!<CR>

" }
" General {
  filetype plugin indent on
  syntax enable
  set laststatus=2 "the status line
  "%F filename
  "%m whether the file is changed
  "%r whether the file is readonly
  "%Y filetype
  "%{&fileformat}
  "%b the ASCII of current char in oct
  "%B the ASCII of current char in hex
  "%l current line number
  "%c current column number
  "%p persent of file
  "%% persent sign
  "%L total lines
  "%h help file flag
  "set statusline=%<%.40f%m%r,\ %Y,\ %{&fileformat}\ [%l-%c,\ %p%%,\ TOTAL\ %L\]\ %=%{strftime(\"%H:%M\ %Y-%m-%d\")}
  "set statusline=\ %Y\ \|
  "set statusline+=\ %{&fileformat}\ \|
  "set statusline+=\ %<%.40f%r%m
  "set statusline+=\ %=\ %l/%L\ -\ %c\
  set statusline=\ %<%.60f%r%m
  "set statusline+=\ %<%.40{getcwd()}\
  set statusline+=\ %=%l/%L\ -\ %c\ \|
  set statusline+=\ %Y\ \|
  set statusline+=\ %{&fileformat}\
  "set statusline=%<%.40F%m%r,\ %Y,\ %{&fileformat}\ [%l-%c,\ %p%%,\ TOTAL\ %L\]\ %=%{strftime(\"%H:%M\ %Y-%m-%d\")}
  "set statusline=%<%F%m%r,%Y,%{&fileformat}\ [%l-%c,\ %p%%,\ TOTAL\ %L\]
  "set statusline=%<%F%m%r,%Y,%{&fileformat}\ CWD:%<%{CurDir()}\ [%l-%c,\ %p%%,\ TOTAL\ %L\]
" }
" Undo Files {
  if v:version >= 703
    set undodir=~/.vim/undofiles
    set undofile
  endif
" }
" Fold {
  let g:xml_syntax_folding=1
  "set foldmethod=syntax
  "set foldmethod=indent   "fold based on indent
  "set foldnestmax=10       "deepest fold is 3 levels
  "set nofoldenable
  "nnoremap <space> za
" }
" Indent {
  set autoindent
  set cindent
  set smartindent
  set imcmdline
  set expandtab "use spaces instead of tab
  set smarttab
  set softtabstop=2
  set shiftwidth=2
  set tabstop=2
" }
" Common {
  set ttyfast
  set lazyredraw
  set hid "You can change file in same buf without saving
  set nu
  "set rnu "show the relativenumber of lines
  set ignorecase "ig case when searching
  set hlsearch "highlight search
  set incsearch "increasing search You know it!
  "nnoremap n nzz
  "nnoremap N Nzz
  set showmatch "show the brackets matches
  let g:rehash256 = 1
  set t_Co=256 "make the colorscheme more beautiful
  set background=dark "I like it
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
	let g:jellybeans_use_term_italics = 1
  colorscheme jellybeans
  "colorscheme xoria256
  "colorscheme molokai
  "colorscheme gruvbox
  "colorscheme lucius
  "colorscheme github
  set conceallevel=2
  set concealcursor=vin
  set history=50
  set showcmd "show command
  set backspace=indent,eol,start
  set termencoding=utf-8
  set encoding=utf-8
  set shell=/bin/bash
  "set tw=78 "auto new line
  set autoread "reload the file when changed
  set ffs=unix,dos,mac
  set scrolljump=5
  set scrolloff=3
  set tabpagemax=16
  "set nowrap
  if version>=700
    set showtabline=2
  endif
  set lazyredraw
  set ttyfast
  set ttyscroll=3
  set wildmenu "wild menu~~~"
  set wildignore+=*.o,*~,*.pyc
  if has("win16") || has("win32") || has("win64")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
  else
    set wildignore+=.git\*,.hg\*,.svn\*
  endif
  set wildmode=longest:full,full
  set nobackup
  set nowritebackup
  set noswapfile
  "set mouse=a "use mouse
  "just save
  "highlight current line
  set cursorline
  "makefile will use tab
  autocmd FileType makefile setlocal noexpandtab
  autocmd BufEnter * silent! lcd %:p:h
" }
" Key Binding {
  inoremap <silent>jk <esc>
  inoremap <esc> <nop>
  inoremap <C-c> <nop>
  inoremap <C-[> <nop>

  "disable the arrow keys
  nnoremap <up> <nop>
  inoremap <up> <nop>
  vnoremap <up> <nop>
  nnoremap <down> <nop>
  inoremap <down> <nop>
  vnoremap <down> <nop>
  nnoremap <left> <nop>
  inoremap <left> <nop>
  vnoremap <left> <nop>
  nnoremap <right> <nop>
  inoremap <right> <nop>
  vnoremap <right> <nop>
  nnoremap ; za
" }
" Resize Window {
  nmap <C-w>= :res +10<cr>
  nmap <C-w>- :res -10<cr>
  nmap <C-w>> :vertical resize +10<cr>
  nmap <C-w>< :vertical resize -10<cr>
" }
