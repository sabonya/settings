set ts=2 sw=2 sts=2
set showmode
"set noautoindent
set autoindent
set number
set showmatch
set list
set expandtab
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<
set ignorecase
highlight SpecialKey ctermbg=lightgrey ctermfg=white
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white
match ZenkakuSpace /　/
set ambiwidth=double
set bg=dark
set laststatus=2
set statusline=%{expand('%:p:t')}\ %<[%{expand('%:p:h')}]%=\ %m%r%y%w[%{&fenc!=''?&fenc:&enc}][%{&ff}][%3l,%3c,%3p]
"set statusline=%{GetEFstatus()}
