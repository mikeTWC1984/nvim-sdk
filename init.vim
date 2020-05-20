

call plug#begin('~/.config/nvim/plugged')

   Plug 'neoclide/coc.nvim', {'branch': 'release'}
   "Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
   Plug 'sheerun/vim-polyglot'
   Plug 'vim-airline/vim-airline'
   Plug 'vim-airline/vim-airline-themes'

   Plug 'tpope/vim-fugitive'
   Plug 'airblade/vim-gitgutter'
   Plug 'scrooloose/nerdtree'
   Plug 'mhinz/vim-startify'
   "Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
   "Plug 'junegunn/fzf.vim'

   Plug 'NLKNguyen/papercolor-theme'
   Plug 'morhetz/gruvbox'
   Plug 'jacoborus/tender.vim'
   Plug 'mhartington/oceanic-next'
   Plug 'lifepillar/vim-solarized8'
 
   Plug 'ryanoasis/vim-devicons'
   Plug 'vwxyutarooo/nerdtree-devicons-syntax'

 call plug#end()

" ------------------- COC.NVIM SETTINGS   -------------------

let g:coc_global_extensions=['coc-powershell', 'coc-snippets', 'coc-json', 'coc-omnisharp']

" some floating window alternatives:
"call coc#config("diagnostic.virtualText", "true")
"call coc#config("diagnostic.messageTarget", "echo")

call coc#config("diagnostic.errorSign", ">>")
call coc#config("diagnostic.warningSign", "!!")
call coc#config("diagnostic.checkCurrentLine", "true")

"  use custom pwsh binaries 
"call coc#config("powershell.powerShellExePath", "/path/to/powershell/pwsh")

" ------------------- BASIC SETTINGS -------------------------------------------

set hidden
set ignorecase "ignores case for searches. Use \C in search pattern to enable case 
"set encoding = utf8
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
set textwidth=100

" ------------------- WINDOWS-STYLE MAPPINGS (copy/paste/select all)  -------------
" --- for Undo/Redo use u / ctrl+r keys 

vnoremap <C-X> "+x
vnoremap <S-Del> "+x
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y
"<C-V> is typically use to get in Visual Block mode, but you can use <C-Q> instead
map <C-V> "+gP  
map <C-A> ggVG <CR>
cmap <C-V>      <C-R>+
cmap <S-Insert>     <C-R>+

" switch to normal mode from terminal mode with Esc
tnoremap <Esc> <C-\><C-n> 

" save file with ctrl+S
inoremap <silent><c-s> <c-o>:update<cr>
nnoremap <silent><c-s> :<c-u>update<cr>
" ctrl V paste in insert mode
inoremap <c-v> <esc>:set paste<cr>a<c-r>=getreg('+')<cr><esc>:set nopaste<cr>mi`[=`]`ia

" -------------- ISE SETTINGS --------------------

set termguicolors
"set t_Co=256

filetype plugin indent on

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

"start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | startinsert | else | stopinsert | endif 

"this prevents :term to exit on buffer switch
autocmd TermOpen * set bufhidden=hide

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
nnoremap <F4> :call TogglePwsh()<CR>

"set darkblue background for PWSH console. Works only if termguicolors is set
"also, make sure your colorscheme support termgui (true colors) too
hi BlueBg guibg=#000080 guifg=white
au TermOpen pwsh* :set winhighlight=Normal:BlueBg

" ------- NERDTREE ---------------------------"

map <F2> :NERDTreeToggle<CR>
highlight! link NERDTreeFlags NERDTreeDir

let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 1
let g:DevIconsDefaultFolderOpenSymbol='' " symbol for open folder (f07c). Use a or doubleclick to toggle (not enter)
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol='' " symbol for closed folder (f07b)



" Startup Screen
let g:startify_custom_header = [
          \'    ██████╗ ██╗    ██╗███████╗██╗  ██╗██╗███████╗███████╗',
          \'    ██╔══██╗██║    ██║██╔════╝██║  ██║██║██╔════╝██╔════╝',
          \'    ██████╔╝██║ █╗ ██║███████╗███████║██║███████╗█████╗  ',
          \'    ██╔═══╝ ██║███╗██║╚════██║██╔══██║██║╚════██║██╔══╝  ',
          \'    ██║     ╚███╔███╔╝███████║██║  ██║██║███████║███████╗',
          \'    ╚═╝      ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚═╝╚══════╝╚══════╝',
          \'    neovim + coc.nvim + coc-powershell + vimplug',
          \]
 
let g:startify_custom_footer = [
      \'',
      \' -------------------- Basic Navigation ------------------',
      \' [Mouse] - navigate, select, click, resize',
      \' [Tab] - switch tabs (buffers)', 
      \' [F2] - Toggle file browser (NERDTree) ',
      \' [F4] - Toggle Powershell Integrated Console (PSIC) ',
      \' [F5] - execute current file in PSIC (use ctrl to execute in separate window ',
      \' [F8] - execute selection in PSIC, or jump into PSIC if nothing selected ',
      \' [F9] - close current tab (buffer) ',
      \' [F12] - close window without saving changes (use ctrl to close all windows) ',
      \' [Ctrl + Arrows] - navigate windows  ',
      \' [Shift + Arrows] - resize window',
      \'',
      \' --- to see this menu again run :Startify ---',
    \]

hi StartifyFooter guifg=#ff6633 guibg=NONE gui=NONE

" Nerdtree/Startify auto open/close 
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Startify | endif
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | wincmd l | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" highlight ps1 files in nerdtree 
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
call NERDTreeHighlightFile('ps1', 'none', 'none', 'cyan', 'none')

" NerdTree autorefresh (not recommended)
"autocmd BufWritePost * NERDTreeFocus | execute 'normal R' | wincmd p



"------------------------- F-Mappings -------------------------------------------------------------------

map <F8> :CocCommand powershell.evaluateSelection <CR>
map <F5> :CocCommand powershell.execute <CR>
" ctrl + F5 - execute file in a new terminal window 
map <F29>  :w <bar> :vs <bar> let c="term pwsh -NoExit -f " . expand('%:p') <bar> execute c <CR>

imap <C-j> <Plug>(coc-snippets-expand)
"nnoremap <C-j> :CocList snippets <CR>

" close window/all windows without saving changes
map<F12> :q!<CR> 
map<F36> :qa!<CR>  

" navigate/close buffers (tabs)
nnoremap <Tab> :bn! <CR>
nnoremap <S-Tab> :bp! <CR>

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

map <F9> :call CloseTab() <CR>
"map <F33> :bn!# <bar> bd!# <CR>


"toggle numbers
map <F7> :set rnu! <bar> :set nu!<CR>


"------------- NAVIGATION ---------------------
"
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
" Download and install Nerd Fonts https://www.nerdfonts.com/font-downloads
" You can also install powerline fonts (sudo apt-get install fonts-powerline)
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
"let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_nr_format = '%s: '
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_buffers = 1

" this will hide terminal buffers from (buffer) tabline
let g:airline#extensions#tabline#ignore_bufadd_pat = 'gundo|undotree|vimfiler|tagbar|nerd_tree|startify|!|term'


