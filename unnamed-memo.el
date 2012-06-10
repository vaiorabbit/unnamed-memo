;;; -*- mode: emacs-lisp; coding: iso-2022-7bit -*-

(defvar unnamed-memo-default-filename "~/memo/%Y/%Y-%m-%d-%H%M%S.")
(defvar unnamed-memo-default-suffix "mdwn")
(defvar unnamed-memo-default-header "<!-- -*- mode:markdown; coding:utf-8; -*- -->\n\n")
(defvar unnamed-memo-default-time-format "[%Y-%m-%d %H:%M:%S(%a)]")

(defun unnamed-memo-aux-new-file-sequence (time)
  (setq buffer-file-coding-system 'utf-8)
  (insert unnamed-memo-default-header)
  (insert (format-time-string (concat "#  " unnamed-memo-default-time-format " #\n") time))
  (previous-line)
  (forward-char 2))

(defun unnamed-memo-create ()
  "Create new memo file."
  (interactive)
  (let (time memo-file memo-directory)
	(setq time (current-time))
	(setq memo-file (concat (format-time-string unnamed-memo-default-filename time) unnamed-memo-default-suffix))
	(setq memo-directory (file-name-directory memo-file))
	(make-directory memo-directory t)
	(find-file-other-window memo-file)
	(unnamed-memo-aux-new-file-sequence time)))

(defun unnamed-memo-close ()
  "Save and close current memo file."
  (interactive)
  (let (suffix-regexp)
	(setq suffix-regexp (format "\\.%s" unnamed-memo-default-suffix))
	(when (string-match suffix-regexp (buffer-file-name))
	  (save-buffer)
	  (kill-buffer))))

(defun unnamed-memo-insert-dtime ()
  (interactive)
  (insert (format-time-string unnamed-memo-default-time-format (current-time))))


;; キーバインド設定例 : .emacs に下記をコピーすること
;; (global-set-key "\C-cmm" 'unnamed-memo-create)
;; (global-set-key "\C-cmc" 'unnamed-memo-close)
;; (global-set-key "\C-cmt" 'unnamed-memo-insert-time)

(provide 'unnamed-memo)
