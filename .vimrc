" dein.vim settings {{{
" install dir {{{
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" }}}

" dein installation check {{{
if &runtimepath !~# '/dein.vim'
 if !isdirectory(s:dein_repo_dir)
   execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
 endif
 execute 'set runtimepath^=' . s:dein_repo_dir
endif
" }}}

" begin settings {{{
if dein#load_state(s:dein_dir)
 call dein#begin(s:dein_dir)
 " .toml file
 let s:rc_dir = expand('~/.vim')
 if !isdirectory(s:rc_dir)
   call mkdir(s:rc_dir, 'p')
 endif
 let s:toml = s:rc_dir . '/dein.toml'
 " read toml and cache
 call dein#load_toml(s:toml, {'lazy': 0})
 " end settings
 call dein#end()
 call dein#save_state()
endif
" }}}

" plugin installation check {{{
if dein#check_install()
 call dein#install()
endif
" }}}

" plugin remove check {{{
let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
 call map(s:removed_plugins, "delete(v:val, 'rf')")
 call dein#recache_runtimepath()
endif
" }}}
" }}}

" enable colorscheme {{{
syntax enable
colorscheme zenburn
" }}}

nmap <C-p> <Plug>AirlineSelectPrevTab
nmap <C-n> <Plug>AirlineSelectNextTab
map <Leader> <Plug>(easymotion-prefix)
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_idx_format = {'0': '0 ', '1': '1 ', '2': '2 ', '3': '3 ', '4': '4 ', '5': '5 ', '6': '6 ', '7': '7 ', '8': '8 ', '9': '9 '}
set ttimeoutlen=50

" ddc
call ddc#custom#patch_global('sources', [
  \ 'around',
  \ 'vim-lsp',
  \ 'file'
  \ ])
call ddc#custom#patch_global('sourceOptions', {
  \ '_': {
  \   'matchers': ['matcher_head'],
  \   'sorters': ['sorter_rank'],
  \   'converters': ['converter_remove_overlap'],
  \ },
  \ 'around': {'mark': 'Around'},
  \ 'vim-lsp': {
  \   'mark': 'LSP',
  \   'matchers': ['matcher_head'],
  \   'forceCompletionPattern': '\.|:|->|"\w+/*',
  \  },
  \ 'file': {
  \   'mark': 'file',
  \   'isVolatile': v:true, 
  \   'forceCompletionPattern': '\S/\S*'
  \ }})
call ddc#enable()
