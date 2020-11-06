set encoding=utf-8
scriptencoding utf-8
set fileformats=unix,dos,mac
set title

" misc
"--------------------------------------------------------
set title "編集中のファイル名を表示
syntax on "コードの色分け
set tabstop=8 " tabをスペース4つ分に設定
set expandtab
set softtabstop=2
set shiftwidth=2
set smartindent "オートインデント
set autoindent
set number " 行番号を表示する
set scrolloff=5  " 常に数行表示する

" 対応括弧に<と>のペアを追加
set matchpairs& matchpairs+=<:>

"閉括弧が入力された時、対応する括弧を強調する
" set showmatch
"
""新しい行を作った時に高度な自動インデントを行う
set smarttab

" コマンドライン補完を拡張モードにする
set wildmenu

" ウィンドウの幅より長い行は折り返して、次の行に続けて表示する
set wrap

" 全角スペースの表示
"highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
"match ZenkakuSpace /　/
augroup highlightIdegraphicSpace
  autocmd!
  "autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen gui=reverse guifg=DarkMagenta
  "autocmd VimEnter,WinEnter * match IdeographicSpace /　/
  autocmd ColorScheme,VimEnter * highlight def link IdeographicSpace Visual
  autocmd VimEnter,WinEnter * let w:m1 = matchadd("IdeographicSpace", "　")
augroup END

" ステータスラインを常に表示
set showtabline=2
set laststatus=2
set noshowmode

" 起動時のメッセージを表示しない
set shortmess+=I

" Windows環境で、パスを/にする
set shellslash

" 挿入モード時のIMEモードデフォルトを0:OFFにする
set iminsert=0

" 検索時のIMEモードデフォルトを-1:iminsertを参照 にする
set imsearch=-1


" search
" ======================================================
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る
"インクリメンタルサーチを行う
set incsearch

" 検索結果をハイライトする
set hlsearch

" /と?のどちらでも、nで前方検索、Nで後方検索にする
nnoremap <expr> n <SID>search_forward_p() ? 'nzv' : 'Nzv'
nnoremap <expr> N <SID>search_forward_p() ? 'Nzv' : 'nzv'
vnoremap <expr> n <SID>search_forward_p() ? 'nzv' : 'Nzv'
vnoremap <expr> N <SID>search_forward_p() ? 'Nzv' : 'nzv'

function! s:search_forward_p()
  return exists('v:searchforward') ? v:searchforward : 1
endfunction

""変更中のファイルでも、保存しないで他のファイルを表示する
set hidden

" grep検索を設定する
set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m,%f
set grepprg=grep\ -nh


" " 検索結果のハイライトをEsc連打でクリアする
nnoremap <ESC><ESC> :nohlsearch<CR>
" mapping関連カスタマイズ
map \ <leader>

" ビープ音を鳴らさない
set vb t_vb=

" ビジュアルベルを無効にする
set novisualbell

" バックスペースキーで削除できるものを指定
" indent  : 行頭の空白
" eol     : 改行
" start   : 挿入モード開始位置より手前の文字
set backspace=indent,eol,start

" backup
" =================================================

" バックアップをとらない
set nobackup

" スワップファイルの作成は行わない
set noswapfile

" undoファイルを作成しない
set noundofile

" viminfoファイルのパスを指定
set viminfo+=n~/.vim/viminfo

" マウスモード有効
if has('mouse')
  set mouse=a
  if has('mouse_sgr')
    set ttymouse=sgr
  elseif v:version > 703 || v:version is 703 && has('patch632') " I couldn't use has('mouse_sgr') :-(
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  endif
endif

" Input support
" ================================================

" 改行時の自動コメントをやめる
autocmd FileType * setlocal formatoptions-=troqwa
" タブを表示するときの幅
set tabstop=4
" タブを挿入するときの幅
set shiftwidth=4
" タブをスペースとして扱う
set expandtab
" 
set softtabstop=2

" Vimの外部で変更されたことが判明したとき、自動的に読み直す
set autoread

" 使わないキーはNopにする
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q gq

" C-<BS>で削除できるようにする
inoremap <C-BS> <C-W>


" Plugin support
" ================================================
call plug#begin()
Plug 'lambdalisue/fern.vim'
Plug 'tyru/caw.vim'
Plug 'tpope/vim-surround'
Plug 't9md/vim-quickhl'
Plug 'mbbill/undotree'
Plug 'thinca/vim-quickrun'
Plug 'itchyny/lightline.vim'
Plug 'mattn/vim-lexiv'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
Plug 'previm/previm'
Plug 'tyru/open-browser.vim'
Plug 'mattn/vim-lsp-settings'  " 言語サーバのインストール自動化
Plug 'prabirshrestha/vim-lsp'  " VimのLSクライアントプラグイン
Plug 'vim-scripts/Zenburn'
call plug#end()

" :PlugInstallでプラグインインストール

" https://github.com/lambdalisue/fern.vim

" let g:zenburn_high_Contrast=1
" colorscheme zenburn
colorscheme default

if &term =~ "xterm-256color" || "screen-256color"
  set t_Co=256
  set t_Sf=[3%dm
  set t_Sb=[4%dm
elseif &term =~ "xterm-color"
  set t_Co=8
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif

" 色を変更
"autocmd ColorScheme * highlight Comment cterm=NONE ctermbg=DarkCyan
autocmd ColorScheme * highlight Visual ctermbg=DarkBlue
autocmd ColorScheme * highlight IncSearch term=reverse cterm=reverse gui=bold guifg=#ff0000

" カレント行ハイライトON
set cursorline
" アンダーラインを引く(color terminal)
highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
" CtrlP
" https://github.com/ctrlpvim/ctrlp.vim
" =========================================
" C-p で起動
nnoremap [CtrlP] <Nop>
nmap <Leader>p [CtrlP]
nnoremap [CtrlP]f :<C-u>CtrlP<CR>
nnoremap [CtrlP]b :<C-u>:CtrlPBuffer<CR>
" nnoremap [CtrlP]m :<C-u>:CtrlPMRU<CR>
nnoremap [CtrlP]m :<C-u>:CtrlPMixed<CR>

" fzf
" https://github.com/junegunn/fzf.vim
" =========================================
let g:fzf_preview_window = 'right:60%'
" let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'
" let $FZF_DEFAULT_COMMAND = 'find . -type f -not -path "*/\.git/*" -not -path "*/\.cache/*"'
" let $FZF_DEFAULT_COMMAND = 'find . -type f -regextype egrep -not -regex ".*/(\.git|\.cache)/.*"'
let $FZF_DEFAULT_COMMAND = 'find . -type f -not -regex ".*/\(\.git\|\.cache\)/.*"'
nnoremap [FZF] <Nop>
nmap <Leader>f [FZF]
nnoremap [FZF]f :<C-u>Files<CR>
nnoremap [FZF]g :<C-u>GFiles<CR>
" :FZFMru 最近使ったファイルの一覧
nnoremap [FZF]m :<C-u>FZFMru<CR>
" :Buffers バッファに展開されているファイルの一覧
nnoremap [FZF]b :<C-u>Buffers<CR>

" 検索対象をVimのカレントディレクトリ配下に限定する
let g:fzf_mru_relative = 1

" vim-lsp
" ========================================
let g:lsp_highlight_references_enabled=1  " vim-lspのシンボルハイライトを有効化

" LightLine
" https://github.com/itchyny/lightline.vim
" =========================================
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'tabline': {
  \    'left': [['cwd'], ['tabs']],
  \    'right': [['close'], ['gitbranch', 'wifi', 'battery']],
  \ },
  \ 'component_function': {
  \    'cws': 'getcwd',
  \    'gitbranch': 'gitbranch#name',
  \    'wifi': 'wifi#component',
  \    'battery': 'battery#component',
  \ },
  \}
if !has('gui_running')
  set t_Co=256
endif
