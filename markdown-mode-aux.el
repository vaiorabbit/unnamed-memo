;;; -*- mode: emacs-lisp; coding: iso-2022-7bit -*-

;; Ref.: Emacs and alists
;;       http://blog.plover.com/2008/01/24/
;; (setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist)) ; $BJ#?t$N3HD%;R$r(Bmarkdown-mode$B$KG'<1$5$;$?$$$H$-$O(B push $B$r;H$&$3$H(B
(push '("\\.md" . markdown-mode) auto-mode-alist)
(push '("\\.mdwn" . markdown-mode) auto-mode-alist)

(setq markdown-hr-string "- - - - - - - - - -")
(setq markdown-italic-underscore t)
(setq markdown-enable-math t)

(setq markdown-command "/usr/local/bin/markdown") ; C-c C-c e $B$G5/F0(B (== M-x markdown-export)

;; [OSX] S-<tab> $B$,(B C-y (yank) $B$K$J$kLdBj$X$NBP:v(B
;; Ref.: http://groups.google.com/group/gnu.emacs.help/browse_thread/thread/094d5a87076987ec?pli=1
;;       Emacs 23 for OSX $B8GM-$NLdBj(B?
(define-key markdown-mode-map (kbd "<S-tab>") 'markdown-shifttab) ; org-mode$B$HF1MM$N%0%m!<%P%k%H%0%k$K@_Dj$5$l$k$h$&$K>e=q$-(B

;; $B2U>r=q$-F~NO;Y1g(B
;; Ref.: Emacs Lisp Idioms (for writing interactive commands) - Get Current Word or Line
;;       http://xahlee.org/emacs/elisp_idioms.html
;;       Inconsistent Behavior for 'line
;;       http://xahlee.blogspot.com/2011/02/emacs-lisp-using-thing-at-point.html

(setq markdown-aux-unordered-list-item-string "*   ")

(defun markdown-aux-insert-unordered-list-item ()
  "Insert `markdown-aux-unordered-list-item-string'."
  (interactive)
  (beginning-of-line)										; $B9TF,$X0\F0(B
  (let (line-length line-blank)
	(setq line-length 										; $B8=:_$N9T$NJ8;z?t(B
		  (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
	(setq line-blank (looking-at "^[ \t]*$"))				; $B6uGrJ8;z$@$1$J$i(B t. Ref.: delete-blank-lines (simple.el)
	(end-of-line)											; $BJQ$J$H$3$m$G2~9T$7$J$$$h$&$K9TKv$X0\F0(B
	(if (or (equal 0 line-length) line-blank)				; $B6u9T!"$^$?$O6uGrJ8;z$@$1$N9T$J$i(B
		(insert markdown-aux-unordered-list-item-string)	; $B!!$9$0$KJ8;zNsF~NO(B
	  (newline)												; $B6u9T$G$O$J$$$J$i2~9T$7$F(B
	  (funcall indent-line-function)						; $B!!%$%s%G%s%H$7$F$+$i(B
	  (insert markdown-aux-unordered-list-item-string))		; $B!!J8;zNsF~NO(B
	(end-of-line)))											; $B9TKv(B(==$B2U>r=q$-$N@hF,0LCV(B)$B$X%+!<%=%k$r0\F0(B

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

;; $B%-!<%P%$%s%I@_DjNc(B : .emacs $B$K2<5-$r%3%T!<$9$k$3$H(B
;; (define-key markdown-mode-map (kbd "M-<RET>") 'markdown-aux-insert-unordered-list-item)
;; (define-key markdown-mode-map "\C-c\C-eu" 'markdown-aux-insert-unordered-list-item)
;; (define-key markdown-mode-map "\C-c\C-eo" 'markdown-aux-insert-ordered-list-number)

(provide 'markdown-mode-aux)
