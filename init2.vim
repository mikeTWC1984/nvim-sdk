call plug#begin('~/.vim/plugged')

 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'sheerun/vim-polyglot'
 Plug 'vim-airline/vim-airline'
 Plug 'vim-airline/vim-airline-themes'
 Plug 'tpope/vim-fugitive'
 Plug 'tpope/vim-commentary'
 Plug 'airblade/vim-gitgutter'
 Plug 'scrooloose/nerdtree'
 Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
 Plug 'junegunn/fzf.vim'
 Plug 'OmniSharp/omnisharp-vim'
 Plug 'vim-ctrlspace/vim-ctrlspace'
 Plug 'w0rp/ale'
 Plug 'tpope/vim-dispatch'
 Plug 'Shougo/vimproc.vim', {'do' : 'make'}
 Plug 'mhinz/vim-startify'
 
 Plug 'NLKNguyen/papercolor-theme'
 Plug 'morhetz/gruvbox'
 Plug 'jacoborus/tender.vim'
 Plug 'mhartington/oceanic-next'
 Plug 'lifepillar/vim-solarized8'
 
 Plug 'ryanoasis/vim-devicons'
 Plug 'vwxyutarooo/nerdtree-devicons-syntax'

 "Plug 'sillybun/vim-repl'

 call plug#end()

 "TODOList
 "F4 - only for powershell files

"BASIC SETTINGS
"call coc#config("powershell.powerShellExePath", "/home/mike/ppw/pwsh")

set hidden
set textwidth=100
set ignorecase "ignores case for searches. Use \C in search pattern to enable case 
set infercase
set encoding=utf8
set termguicolors
"set t_Co=256
filetype plugin indent on

set autoindent
set expandtab
set shiftwidth=2
set mouse=a "enables mouse in all modes. Hold shift to avoid getting into visual mode
set relativenumber
set number
set splitbelow
set splitright
set updatetime=100
set ttimeoutlen=50

tnoremap <Esc> <C-\><C-n> 

" WINDOWS-STYLE MAPPINGS (copy/paste/select all)
" Use u and ctrl-r for undo/redo
vnoremap <C-X> "+x
vnoremap <S-Del> "+x
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y
"<C-V> is a shortcut for Visual Block mode, but you can use <C-Q> instead
map <C-V> "+gP  
map <C-A> ggVG <CR>
cmap <C-V>      <C-R>+
cmap <S-Insert>     <C-R>+


"COLORSCHEMES
"colorscheme tender
"colorscheme OceanicNext
colorscheme gruvbox
"colo PaperColor

"set bg=light
set bg=dark


" TERMINAL SETTINGS
" unlist terminal buffer to skip it while navigating tab. You can use
" pwsh instead of * to apply this just to pwsh console
au TermOpen * if bufwinnr('') > 0 | setlocal nobuflisted | endif

autocmd TermOpen * set bufhidden=hide "this prevents :term to exit on buffer switch

au BufEnter * if &buftype == 'terminal' | startinsert | else | stopinsert | endif

"toggle PWSH integrated console (F4)
function! TogglePwsh()
   let bname = bufname('term:*pwsh')
   let bnr = bufwinnr(bname)
   if bnr > 0
      :exe bnr . "wincmd c"
   else
      :exe 'split | :resize -10 | :b ' . bname
      call feedkeys("\<esc>")
   endif
endfunction

function! ShowPwsh()
   let bname = bufname('term:*pwsh')
   if bufwinnr(bname) == -1
      :exe 'split | :resize -10 | :b ' . bname
      call feedkeys("\<esc>")
   endif
endfunction

function! RunPwsh()
   :exe ':CocCommand powershell.evaluateSelection'
   let bname = bufname('term:*pwsh')
   if bufwinnr(bname) == -1
      :exe 'split | :resize -10 | :b ' . bname
      call feedkeys("\<esc>")
   endif
endfunction

augroup pscbindings
  autocmd! 
  autocmd Filetype ps1 nmap <buffer> <F4> :call TogglePwsh()<CR>
  autocmd Filetype cs nmap <buffer> <F4> :CocCommand terminal.Toggle  <CR>
  "autocmd FileType ps1 nmap <buffer> <F8>:CocCommand powershell.evaluateSelection<CR>
  "autocmd FileType py vmap <buffer> <F8>  :CocCommand python.execSelectionInTerminal<CR>
augroup end
 



autocmd FileType ps1 setlocal commentstring=#\ %s
autocmd FileType cs setlocal commentstring=//\ %s

"nnoremap <F4> :call TogglePwsh()<CR>

"set darkblue background for PWSH console. Works only if termguicolors is set
"make sure your colorscheme support termgui (true colors) too

hi BlueBg guibg=#000080 guifg=white
au TermOpen * set winhighlight=Normal:BlueBg
au TermClose * close 
"augroup terminal
"        autocmd!
"        autocmd TermClose * if getline('$') == 'Exit' | close | endif
"augroup end



" ------- NERDTREE / Startify ---------------------------"

map <F2> :NERDTreeToggle<CR>
highlight! link NERDTreeFlags NERDTreeDir

let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 1
let g:DevIconsDefaultFolderOpenSymbol='' " symbol for open folder (f07c). Use a or doubleclick to toggle (not enter)
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol='' " symbol for closed folder (f07b)

" Startup Screen
let g:ascii_art = [
          \'    ██████╗ ██╗    ██╗███████╗██╗  ██╗██╗███████╗███████╗',
          \'    ██╔══██╗██║    ██║██╔════╝██║  ██║██║██╔════╝██╔════╝',
          \'    ██████╔╝██║ █╗ ██║███████╗███████║██║███████╗█████╗  ',
          \'    ██╔═══╝ ██║███╗██║╚════██║██╔══██║██║╚════██║██╔══╝  ',
          \'    ██║     ╚███╔███╔╝███████║██║  ██║██║███████║███████╗',
          \'    ╚═╝      ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚═╝╚══════╝╚══════╝',
          \'    neovim + coc.nvim + coc-powershell + vimplug',
          \]
"let g:startify_custom_header = g:ascii_art
let g:startify_custom_footer = [
      \'',
      \' -------------------- Basic Navigation ------------------',
      \' [Mouse] - navigate, select, click, resize',
      \' [Tab] - switch tabs (buffers)', 
      \' [F2] - Open/Close file browser (NERDTree) ',
      \' [F4] - Toggle Powershell Integrated Console (PSIC) ',
      \' [F5] - execute current file in PSIC (use ctrl to execute in separate window ',
      \' [F8] - execute selection in PSIC, or jump into PSIC if nofing selected ',
      \' [F9] - close current tab (buffer) ',
      \' [F12] - close window without saving changes (use ctrl to close all windows) ',
      \' [Ctrl + Arrows] - navigate windows  ',
      \' [Shift + Arrows] - resize window',
      \'',
      \' --- to see this menu again run :Startify ---',
    \]
hi StartifyFooter guifg=#ff6633 guibg=NONE gui=NONE

" Auto open/close 
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Startify | endif
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | wincmd l | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif



" highlight ps1 files 
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
call NERDTreeHighlightFile('ps1', 'none', 'none', 'cyan', 'none')

" autorefresh
"autocmd BufWritePost * NERDTreeFocus | execute 'normal R' | wincmd p

"------------------------------------------------------------------------------------------------------


"autocmd FileType py vnoremap <F6>  :CocCommand python.execSelectionInTerminal<CR>
autocmd FileType ps1 map <buffer> <F8>  :CocCommand powershell.evaluateSelection<CR>
autocmd FileType python map <buffer> <F8>  :CocCommand python.execSelectionInTerminal<CR>

map <F5> :CocCommand powershell.execute <CR>
map <F29>  :w <bar> :vs <bar> let c="term pwsh -NoExit -f " . expand('%:p') <bar> execute c <CR>

"nnoremap <C-j> :CocList snippets <CR>
"inoremap <C-j> <Plug>(coc-snippets-expand)
imap <C-j> <Plug>(coc-snippets-expand)
nnoremap <C-j> :CocList snippets <CR>


" close window/all windows without saving changes
map<F12> :q!<CR> 
map<F36> :qa!<CR>  

" navigate/close buffers (tabs)

set confirm 
function! CloseTab()
  if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    :exe 'enew | bp | bd# | :Startify'
  elseif len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 0
    call feedkeys("\<esc>")
    :exe 'q'
  else
    :exe 'bp | bd#'
  endif
endfunction

map <silent><F9> :call CloseTab() <CR>
"map <F33> :bn!# <bar> bd!# <CR>
nnoremap <Tab> :bn! <CR>
nnoremap <S-Tab> :bp! <CR>

"toggle numbers
map <F7> :set rnu! <bar> :set nu!<CR>

" resize window with Shift+Arrow
map <S-Right> <C-w><<CR>
map <S-Left> <C-w>><CR>
map <S-Up> <C-w>-<CR>
map <S-Down> <C-w>+<CR>

"Switch between windows with Ctrl+Arrow
nmap <silent> <C-Up> :wincmd k<CR>
nmap <silent> <C-Down> :wincmd j<CR>
nmap <silent> <C-Left> :wincmd h<CR>
nmap <silent> <C-Right> :wincmd l<CR>


" Fonts 
" Install powerline fonts (sudo apt-get install fonts-powerline)
" Download and install Nerd Fonts https://www.nerdfonts.com/font-downloads
"set guifont=Liberation\ Mono\ for\ Powerline\ 11
set guifont=DejaVu\ Sans\ Mono\ Nerd\ Font\ 14
"set guifont=DroidSansMono\ Nerd\ Font:h14

" TAB COMPLETION
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


" AIRLINE
set laststatus=2
set noshowmode
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts=1
let g:airline_inactive_collapse=1
let g:airline_inactive_alt_sep=0
let g:airline_detect_modified=1
let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#fugitiveline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline_detect_spell=1
let g:airline_detect_spelllang=1
let g:airline_exclude_preview = 1
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_nr_format = '%s: '
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_buffers = 1

"this will remove terminal from airline tabline
let g:airline#extensions#tabline#ignore_bufadd_pat = 'gundo|undotree|vimfiler|tagbar|nerd_tree|startify|!|term'


"let g:OmniSharp_server_stdio = 0
"let g:OmniSharp_server_use_mono = 1
"let g:OmniSharp_server_path = '~/.omnisharp/omnisharp-roslyn/run'
"let g:OmniSharp_server_use_mono = 1


" Timeout in seconds to wait for a response from the server
"let g:OmniSharp_timeout = 5

" Don't autoselect first omnicomplete option, show options even if there is only
" one (so the preview documentation is accessible). Remove 'preview' if you
" don't want to see any documentation whatsoever.
"set completeopt=longest,menuone,preview

" Fetch full documentation during omnicomplete requests.
" By default, only Type/Method signatures are fetched. Full documentation can
" still be fetched when you need it with the :OmniSharpDocumentation command.
"let g:omnicomplete_fetch_full_documentation = 1

" Set desired preview window height for viewing documentation.
" You might also want to look at the echodoc plugin.
"set previewheight=5

" Tell ALE to use OmniSharp for linting C# files, and no other linters.
"let g:ale_linters = { 'cs': ['OmniSharp'] }

" Update symantic highlighting on BufEnter and InsertLeave
"let g:OmniSharp_highlight_types = 2


" Contextual code actions (uses fzf, CtrlP or unite.vim when available)
"nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>
" Run code actions with text selected in visual mode to extract method
"xnoremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>

" Rename with dialog
"nnoremap <Leader>nm :OmniSharpRename<CR>
"nnoremap <F2> :OmniSharpRename<CR>
" Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
"command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

"nnoremap <Leader>cf :OmniSharpCodeFormat<CR>

" Start the omnisharp server for the current solution
"nnoremap <Leader>ss :OmniSharpStartServer<CR>
"nnoremap <Leader>sp :OmniSharpStopServer<CR>

"function! CocNvimHighlight()
"            highlight CocErrorHighlight ctermfg=Red  guifg=#ff0000
"            highlight CocWarningHighlight ctermfg=Red  guifg=#ff0000
"            highlight CocInfoHighlight ctermfg=Red  guifg=#ff0000
"            highlight CocHintHighlight ctermfg=Red  guifg=#ff0000
"            highlight CocErrorLine ctermfg=Red  guifg=#ff0000
"            highlight CocWarningLine ctermfg=Red  guifg=#ff0000
"            highlight CocInfoLine ctermfg=Red  guifg=#ff0000
"            highlight CocHintLine ctermfg=Red  guifg=#ff0000
"
"            highlight CocHighlightText  guibg=#111111 ctermbg=223
"	endfunction
"
"        autocmd VimEnter function CocNvimHighlight()


" use <tab> for trigger completion and navigate to the next complete item

" use <tab> for trigger completion and navigate to the next complete item




