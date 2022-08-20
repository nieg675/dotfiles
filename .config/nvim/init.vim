call plug#begin()
Plug 'NLKNguyen/papercolor-theme'
Plug 'mhinz/vim-grepper'
Plug 'elixir-editors/vim-elixir'
Plug 'ekalinin/Dockerfile.vim'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/romainl/vim-cool'
call plug#end()

if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

syntax on
set termguicolors
set background=light
colorscheme PaperColor

set number relativenumber

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   "rg --column --line-number --no-heading --color=always --smart-case -- ".shellescape(<q-args>), 1,
  \   fzf#vim#with_preview('right:hidden', 'ctrl-/'), <bang>0)

let $FZF_DEFAULT_COMMAND='find . \( -name debug -o -name build -o -name target -o -name _build -o -name deps -o -name node_modules -o -name .git \) -prune -o -print'

imap jk <Esc>
nnoremap <silent> <C-Up> :cn<CR>
nnoremap <silent> <C-Down> :cp<CR>
nmap <C-Y> ;Files<CR>
nmap <C-P> ;Rg<CR>
nnoremap f /
nnoremap t  ?
nnoremap ; :
nnoremap : ;


cnoreabbrev g G
cnoreabbrev rg GrepperRg
nnoremap <C-J> :cnext<cr>
nnoremap <C-K> :cprev<cr>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set clipboard=unnamedplus

set laststatus=2
set statusline=
set statusline+=%F
set statusline+=\ 
set statusline+=%{b:gitbranch}
set statusline+=%=
set statusline+=%P

function! StatuslineGitBranch()
  let b:gitbranch=""
  if &modifiable
    try
      let l:dir=expand('%:p:h')
      let l:gitrevparse = system("git -C ".l:dir." rev-parse --abbrev-ref HEAD")
      if !v:shell_error
        let b:gitbranch="(".substitute(l:gitrevparse, '\n', '', 'g').") "
      endif
    catch
    endtry
  endif
endfunction

augroup GetGitBranch
  autocmd!
  autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
augroup END

"	https://www.tdaly.co.uk/projects/vim-statusline-generator/
"	https://www.johnhawthorn.com/2012/09/vi-escape-delays
	"	eksperiment med alt

