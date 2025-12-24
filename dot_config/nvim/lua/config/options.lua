vim.opt.fileencoding = "utf-8" -- Encoding
vim.opt.swapfile = false -- スワップファイルを作成しない
vim.opt.hidden = true

-- カーソル表示
vim.opt.cursorline = true
-- vim.opt.cursorcolumn = true

-- クリップボードをシステムと共有する
vim.opt.clipboard:append({ "unnamedplus" })
vim.opt.cmdheight = 1

-- メニューとコマンド
vim.opt.wildmenu = true -- コマンドラインで補完
vim.opt.cmdheight = 1 -- コマンドラインの表示行数
vim.opt.laststatus = 3 -- グローバルステータスラインを使用
vim.opt.showcmd = true -- コマンドラインに入力されたコマンドを表示

-- 検索・置換え
vim.opt.hlsearch = true -- ハイライト検索を有効
vim.opt.incsearch = true -- インクリメンタルサーチを有効
vim.opt.matchtime = 1 -- 入力された文字列がマッチするまでにかかる時間

-- カラースキーム
vim.opt.termguicolors = true -- 24 ビットカラーを使用
vim.opt.background = "dark" -- ダークカラーを使用する

-- インデント
vim.opt.shiftwidth = 2 -- シフト幅を4に設定する
vim.opt.tabstop = 2 -- タブ幅を4に設定する
vim.opt.expandtab = true -- タブ文字をスペースに置き換える
vim.opt.autoindent = true -- 自動インデントを有効にする
vim.opt.smartindent = true -- インデントをスマートに調整する

-- 表示
vim.opt.number = true -- 行番号を表示
vim.opt.wrap = true -- テキストの自動折り返しを無効に
vim.opt.showtabline = 2 -- タブラインを表示
-- （1:常に表示、2:タブが開かれたときに表示）
vim.opt.visualbell = true -- ビープ音を表示する代わりに画面をフラッシュ
vim.opt.showmatch = true -- 対応する括弧をハイライト表示

-- インタフェース
vim.opt.termguicolors = true
vim.opt.winblend = 0 -- ウィンドウの不透明度
vim.opt.pumblend = 0 -- ポップアップメニューの不透明度
vim.opt.showtabline = 2 -- タブラインを表示する設定
vim.opt.signcolumn = "yes" -- サインカラムを表示

---- 行番号の色を変更（色は適宜変更してください）
vim.cmd("highlight LineNr guifg=#8a70ac")

-- カーソルの形状
vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

-- ビジュアルモードで行末の右側も選択可能にする
vim.opt.virtualedit:append("block")

-- signcolumnの優先順位（エラー/警告/ヒントの表示順）
vim.diagnostic.config({ severity_sort = true })

-- クリップボード設定
vim.g.clipboard = {
	name = "OSC 52",
	copy = {
		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
	},
	paste = {
		["+"] = require("vim.ui.clipboard.osc52").paste("+"),
		["*"] = require("vim.ui.clipboard.osc52").paste("*"),
	},
}

-- smartcase
vim.opt.ignorecase = true
vim.opt.smartcase = true
