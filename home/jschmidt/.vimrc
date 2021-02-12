syntax on
set background=dark
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set ruler
:set encoding=utf-8
:set fileencoding=utf-8

" no mo' ^M
:set ff=unix

" forgot to "sudo vim"? try :w!!
cmap w!! w !sudo tee "%" >/dev/null

" mmm... fuzzy...
"set rtp+=~/.fzf

filetype plugin indent on

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

" toggle line numbers
:nmap <F12> :set invnumber<CR>

" Always show statusline (2nd line is airline-purty
set laststatus=2

"set mapleader
:let mapleader = " "

"Goyo / Limelight
nmap <leader>g :Goyo<CR>
nmap <leader>l :Limelight!!<CR>

let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" here be the magic:
execute pathogen#infect()

"""""""""""""""""""""""""""
" NERDTree
map <C-n> :NERDTreeToggle<CR>
" to auto-start NERDTree:
"autocmd vimenter * NERDTree
" open when vim is called by itself
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close if NERDTree is the only tab left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" quit when opening a file to edit
let NERDTreeQuitOnOpen = 1
" Automatically delete the buffer of the file you just deleted
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
" defaults below...
"let NERDTreeDirArrows = 1
"let g:NERDTreeDirArrowExpandable = '▸'
"let g:NERDTreeDirArrowCollapsible = '▾'
"""""""""""""""""""""""""""

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" fugitive
set statusline=%{fugitive#statusline()}
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gt :Gcommit -v -q %:p<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>go :Git checkout<Space>
"nnoremap <leader>gps :Dispatch! git push<CR>
nnoremap <leader>gps :Git push<CR>
"nnoremap <leader>gpl :Dispatch! git pull<CR>
nnoremap <leader>gpl :Git pull<CR>

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
nnoremap <leader>sc :SyntasticCheck<CR>
nnoremap <leader>sn :lnext<CR>
nnoremap <leader>sp :lprevious<CR>

" GitGutter
nnoremap <leader>gg :GitGutterToggle<CR>

" tabularize hotkeys
"vmap <leader>a=> :Tabularize /=><CR>
"nmap <leader>a: :Tabularize /:\zs<CR>
"vmap <leader>a: :Tabularize /:\zs<CR>
nmap <leader>a=> :Tabularize /=><CR>
vmap <leader>a=> :Tabularize /=><CR>

" snipMate
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['ruby'] = 'ruby,rails'

" vimux settings
"let g:VimuxHeight = "15"
let g:VimuxUseNearestPane = 0
"nnoremap <leader>e :VimuxRunCommand(" cl;ssh eviloreo;e")<CR>
"nnoremap <leader>f :VimuxRunCommand(" cl;ssh flames;e")<CR>
"nnoremap <leader>t :VimuxRunCommand(" sudo top;exit")<CR>
"nnoremap <leader>s :VimuxPromptCommand("ssh ")<CR>
"nnoremap <leader>m :VimuxPromptCommand("make ")<CR>

" cleanup whitespace
nnoremap <leader>ws :%s/\s\+$//<CR>
nnoremap <leader>tb :%s/\t/\ \ /g<CR>
"""""""""""""""""""""""""""

"set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points
" Move normally between wrapped lines
"nmap j gj
"nmap k gk


" %F(Full file path)
" %m(Shows + if modified - if not modifiable)
" %r(Shows RO if readonly)
" %<(Truncate here if necessary)
" \ (Separator)
" %=(Right align)
" %l(Line number)
" %v(Column number)
" %L(Total number of lines)
" %p(How far in file we are percentage wise)
" %%(Percent sign)
set statusline=%F%m%r%<\ %=%l,%v\ [%L]\ %p%%

" Change the highlighting so it stands out
hi statusline ctermbg=white ctermfg=black

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" folding settings
"set foldmethod=expr
"set foldexpr=^#
"set foldnestmax=10      "deepest fold is 10 levels
"set nofoldenable        "dont fold by default
"set foldlevel=1         "this is just what i use


" buffer fun """""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden
" To open a new empty buffer
nmap <leader>bn :enew<cr>
nmap <leader>n :bnext<CR>
nmap <leader>p :bprevious<CR>
" Close the current buffer and move to the previous one
nmap <leader>bq :bp <BAR> bd #<CR>
" resize splits
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
" buffer fun """""""""""""""""""""""""""""""""""""""""""""""""""""""""


" vim-airline
let w:airline_disabled = 0
let g:airline_inactive_collapse=1

" enable/disable fugitive/lawrencium integration
let g:airline#extensions#branch#enabled = 1

" change the text for when no branch is detected
"let g:airline#extensions#branch#empty_message = ''

let g:airline_powerline_fonts = 1

" fonts partially messed up? uncomment
"if !exists('g:airline_symbols')
"  let g:airline_symbols = {}
"endif
"let g:airline_symbols.space = "\ua0"


" tmuxline.vim
let g:airline#extensions#tmuxline#enabled = 1
let g:airline#extensions#tmuxline#snapshot_file = "~/.tmuxline"

" I likey my arrows (but not if my font sucks)
let g:tmuxline_powerline_separators = 1

let g:airline#extensions#syntastic#enabled = 1

let g:airline#extensions#tagbar#enabled = 1

let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#symbol = '⥆ '
let g:airline#extensions#whitespace#show_message = 1


" tabline
" enable/disable enhanced tabline.
let g:airline#extensions#tabline#enabled = 1

" show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" enable/disable displaying buffers with a single tab.
let g:airline#extensions#tabline#show_buffers = 1

" enable/disable displaying tabs, regardless of number.
let g:airline#extensions#tabline#show_tabs = 1

" enable/disable display preview window buffer in the tabline.
let g:airline#extensions#tabline#exclude_preview = 1

" promptline
let g:airline#extensions#promptline#enabled = 1
let g:promptline_powerline_symbols = 1
let g:airline#extensions#promptline#snapshot_file = "~/.shell_prompt.sh"

"let g:promptline_preset = 'clear'
"let g:promptline_preset = 'full'
"let g:promptline_preset = 'powerlineclone'
"let g:promptline_preset = {
"  \'a' : [ promptline#slices#user() ],
"  \'b' : [ promptline#slices#host({ 'only_if_ssh': 1 }) ],
"  \'c' : [ promptline#slices#cwd() ],
"  \'y' : [ promptline#slices#vcs_branch() ],
"  \'z' : [ promptline#slices#git_status() ],
"  \'warn' : [ promptline#slices#last_exit_code() ]}
let g:promptline_preset = {
  \'a' : [ '\A', promptline#slices#host({ 'only_if_ssh': 0 }) ],
  \'b' : [ promptline#slices#python_virtualenv(), promptline#slices#user() ],
  \'c' : [ promptline#slices#cwd({ 'dir_limit': 8 }) ],
  \'y' : [ promptline#slices#vcs_branch() ],
  \'z' : [ promptline#slices#git_status() ],
  \'warn' : [ promptline#slices#last_exit_code() ]}

"colorscheme murphy
"let g:airline_theme='random'
"colorscheme greff
"let g:airline_theme='alduin'
"let g:airline_theme='atomic'
"let g:airline_theme='aurora'
"colorscheme pw
"let g:airline_theme='badcat'
"colorscheme badwolf
"let g:airline_theme='badwolf'
"colorscheme pw
"colorscheme greff
"let g:airline_theme='base16'
"let g:airline_theme='base16_atelierdune'
"colorscheme base16-atelierdune
"let g:airline_theme='base16_bright'
"let g:airline_theme='base16_monokai'
"let g:airline_theme='behelit'
"let g:airline_theme='blueline'
"let g:airline_theme='bubblegum'
"colorscheme bubblegum
"let g:airline_theme='cobalt2'
"colorscheme cobalt
"let g:airline_theme='cool'
"colorscheme cool
"let g:airline_theme='distinguished'
"colorscheme distinguished
"let g:airline_theme='durant'
"let g:airline_theme='fairyfloss'
"colorscheme grb256
"colorscheme greff
"let g:airline_theme='hybrid'
"let g:airline_theme='hybridline'
"let g:airline_theme='i3wm'
"let g:airline_theme='jellybeans'
"colorscheme jellybeans
"let g:airline_theme='kalisi'
"colorscheme kalisi
"let g:airline_theme='kolor'
"colorscheme kolor
"let g:airline_theme='laederon'
"colorscheme twilight256
"let g:airline_theme='light'
"let g:airline_theme='lucius'
"colorscheme lucius
"let g:airline_theme='luna'
"colorscheme luna
"let g:airline_theme='minimalist'
"colorscheme pw
"let g:airline_theme='molokai'
"colorscheme molokai
"colorscheme monokai-chris
"let g:airline_theme='monochrome'
"let g:airline_theme='murmur'
"colorscheme muon
"colorscheme grb256
"let g:airline_theme='onedark'
"let g:airline_theme='papercolor'
"colorscheme ...
"let g:airline_theme='peaksea'
"colorscheme peaksea
"let g:airline_theme='powerlineish'
"colorscheme greff
"let g:airline_theme='qwq'
"let g:airline_theme='ravenpower'
"let g:airline_theme='raven'
"let g:airline_theme='serene'
"let g:airline_theme='sierra'
"let g:airline_theme='silver'
"let g:airline_theme='simple'
"let g:airline_theme='sol'
"let g:airline_theme='solarized'
"colorscheme solarized
"let g:airline_theme='term'
"colorscheme greenvision
"colorscheme baycomb
let g:airline_theme='tomorrow'
colorscheme 256-grayvim
"let g:airline_theme='ubaryd'
"let g:airline_theme='understated'
"colorscheme understated
"let g:airline_theme='vice'
"let g:airline_theme='violet'
"let g:airline_theme='wombat'
"colorscheme wombat256
"let g:airline_theme='xtermlight'
"let g:airline_theme='zenburn'


let g:previm_open_cmd = 'open -a Safari'
augroup PrevimSettings
  autocmd!
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

set backupdir=./.backup,.,/tmp
set directory=.,./.backup,/tmp

