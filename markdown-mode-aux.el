;;; -*- mode: emacs-lisp; coding: iso-2022-7bit -*-

;; Ref.: Emacs and alists
;;       http://blog.plover.com/2008/01/24/
;; (setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist)) ; 複数の拡張子をmarkdown-modeに認識させたいときは push を使うこと
(push '("\\.md" . markdown-mode) auto-mode-alist)
(push '("\\.mdwn" . markdown-mode) auto-mode-alist)

(setq markdown-hr-string "- - - - - - - - - -")
(setq markdown-italic-underscore t)
(setq markdown-enable-math t)

(setq markdown-command "/usr/local/bin/markdown") ; C-c C-c e で起動 (== M-x markdown-export)

;; [OSX] S-<tab> が C-y (yank) になる問題への対策
;; Ref.: http://groups.google.com/group/gnu.emacs.help/browse_thread/thread/094d5a87076987ec?pli=1
;;       Emacs 23 for OSX 固有の問題?
(define-key markdown-mode-map (kbd "<S-tab>") 'markdown-shifttab) ; org-modeと同様のグローバルトグルに設定されるように上書き

;; 箇条書き入力支援
;; Ref.: Emacs Lisp Idioms (for writing interactive commands) - Get Current Word or Line
;;       http://xahlee.org/emacs/elisp_idioms.html
;;       Inconsistent Behavior for 'line
;;       http://xahlee.blogspot.com/2011/02/emacs-lisp-using-thing-at-point.html

(setq markdown-aux-unordered-list-item-string "*   ")

(defun markdown-aux-insert-unordered-list-item ()
  "Insert `markdown-aux-unordered-list-item-string'."
  (interactive)
  (beginning-of-line)										; 行頭へ移動
  (let (line-length line-blank)
	(setq line-length 										; 現在の行の文字数
		  (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
	(setq line-blank (looking-at "^[ \t]*$"))				; 空白文字だけなら t. Ref.: delete-blank-lines (simple.el)
	(end-of-line)											; 変なところで改行しないように行末へ移動
	(if (or (equal 0 line-length) line-blank)				; 空行、または空白文字だけの行なら
		(insert markdown-aux-unordered-list-item-string)	; 　すぐに文字列入力
	  (newline)												; 空行ではないなら改行して
	  (funcall indent-line-function)						; 　インデントしてから
	  (insert markdown-aux-unordered-list-item-string))		; 　文字列入力
	(end-of-line)))											; 行末(==箇条書きの先頭位置)へカーソルを移動

(defun markdown-aux-insert-ordered-list-number ()
  (interactive)
  (let (paragraph-string)
	(setq paragraph-string (thing-at-point 'paragraph))
	(if paragraph-string
		(if (string-match "^[ \t]*\\([0-9]+\\)\.[ \t]+" paragraph-string)
			(let (olnum line-length line-blank)
			  (setq olnum (string-to-number (match-string 1 paragraph-string)))
			  (setq line-length (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
			  (setq line-blank (looking-at "^[ \t]*$"))
			  (end-of-line)
			  (if (or (equal 0 line-length) line-blank)
				  (insert (format "%d.  " (+ 1 olnum)))
				(newline)
				(funcall indent-line-function)
				(insert (format "%d.  " (+ 1 olnum))))
			  (end-of-line))
		  (message "not in ordered list paragraph"))
	  (insert "1.  "))))

;; キーバインド設定例 : .emacs に下記をコピーすること
;; (define-key markdown-mode-map (kbd "M-<RET>") 'markdown-aux-insert-unordered-list-item)
;; (define-key markdown-mode-map "\C-c\C-eu" 'markdown-aux-insert-unordered-list-item)
;; (define-key markdown-mode-map "\C-c\C-eo" 'markdown-aux-insert-ordered-list-number)

(provide 'markdown-mode-aux)
