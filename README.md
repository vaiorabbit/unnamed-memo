<!-- -*- mode:markdown; coding:utf-8; -*- -->

*   Created: 2012-02-23 (Thu)
*   Last Modified: 2012-06-10 (Sun)

## Summary ##

*   markdown-mode-aux.el
	*   markdown-mode に必須の設定と拡張機能を提供
		*   markdown-aux-insert-unordered-list-item : Command+[ENTER] 一発でインデントを考慮して箇条書き行頭文字を入力
*   unnamed-memo.el
	*   ファイル名と保存場所を日付/時刻から自動的に決めてテキストファイルを開く機能を提供 (markdown-mode の利用が前提)


## Usage ##

    (require 'markdown-mode)
    
	(require 'markdown-mode-aux)
    (define-key markdown-mode-map (kbd "M-<RET>") 'markdown-aux-insert-unordered-list-item)
    (define-key markdown-mode-map "\C-c\C-eu" 'markdown-aux-insert-unordered-list-item)
    (define-key markdown-mode-map "\C-c\C-eo" 'markdown-aux-insert-ordered-list-number)
    
    (require 'unnamed-memo)
    (global-set-key "\C-cmm" 'unnamed-memo-create)
    (global-set-key "\C-cmc" 'unnamed-memo-close)
    (global-set-key "\C-cmd" 'unnamed-memo-insert-dtime)

	
## Reference ##

*   markdown-mode.el
	*   http://jblevins.org/git/markdown-mode.git
