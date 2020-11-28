;;;
;;;  Emacs 27 initialize file
;;;

;;; Japanese Encoding Setting 
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8-unix)
(set-buffer-file-coding-system 'utf-8-unix)
(setq file-name-coding-system 'utf-8)
(setq inhibit-startup-message t)

;起動時のディスプレイサイズ変更
(setq initial-frame-alist
      '((top . 1) (left . 1) (width . 110) (height . 60)))

(when (eq window-system 'ns)
  ;;
  ;; MacOSX setting
  ;;
  (create-fontset-from-ascii-font
   "Menlo-14:weight=normal:slant=normal"
   nil
   "menlokakugo")

  (set-fontset-font
   "fontset-menlokakugo"
   'unicode
   (font-spec :family "Hiragino Maru Gothic ProN")
   nil
   'append)

  (add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))
  (setq face-font-rescale-alist '(("Hiragino.*" . 1.2)))

  ;; Command-Key and Option-Key
  (setq ns-command-modifier (quote meta))
  (setq ns-alternate-modifier (quote super))

  ;; Path setting
  (setq load-path (cons (expand-file-name "~/Library/Emacs/lisp") load-path))
  (setq load-path (cons "." load-path))
  (setq exec-path
	(append (list  "/usr/local/bin") exec-path))
  (setenv "PATH" (concat '"/usr/local/bin" (getenv "PATH")))

  ;; 初期位置
  (cd "~/Desktop/")
  
  (defun make-backup-file-name (filename)
    (concat "~/.Trash/" (file-name-nondirectory filename) "~"))

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;; End of MacOSX Emacs setting
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  )

;; Mac OS Xの場合のファイル名の設定
(when (eq system-type 'darwin)
  (require 'ucs-normalize)
  (set-file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs))


;;;;;;;;;; Beep OFF
(setq visible-bell t)

;;;;;;;;;;;;;; 見た目の設定
(set-frame-parameter nil 'alpha 95)	;背景の透明度
(tool-bar-mode -1)			;ツールバー非表示

(show-paren-mode 1)			;対応する括弧を光らせる
(blink-cursor-mode t) ;;; カーソルの点滅を止める
(column-number-mode t) ;;; カーソルの位置が何文字目かを表示する
(line-number-mode t) ;;; カーソルの位置が何行目かを表示する
(global-linum-mode t) ;;; 左側に行番号を表示
(auto-compression-mode t)        ;;日本語infoの文字化け防止
(set-scroll-bar-mode 'right)     ;;スクロールバーを右に表示
(setq scroll-step 1)

;;;;;;;;;;;;; 補完機能
(setq completion-ignore-case t) ;; 補完時に大文字小文字を区別しない
;;(load "complete")
;; (partial-completion-mode 1)  ;; 強力な補完機能を使う
;;(icomplete-mode 1) ;;; 補完可能なものを随時表示、少しうるさい

;;;;;;;;;;;;;; その他
(put 'eval-expression 'disabled nil)
;;(recentf-mode)	;;; 最近使ったファイルを保存(M-x recentf-open-filesで開く)
(server-start)	;;; for emacsclient
;(setq visible-bell t)           ;;警告音を消す
;(setq kill-whole-line t)        ;;カーソルが行頭にある場合も行全体を削除

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Global key set
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-key global-map "\C-h" 'backward-delete-char)
(define-key global-map "\M-n" 'next-error)
(define-key global-map "\M-p" 'goto-line)
(define-key global-map "\M-o" 'what-line)
(define-key global-map "\M-h" 'help-command)
(define-key global-map "\M-n" 'linum-mode)
(define-key global-map [(delete)] 'delete-char)

;; Home and End keys
(define-key global-map [(home)] 'beginning-of-buffer)
(define-key global-map [(end)] 'end-of-buffer)

;;; Auto-backup OFF
(setq auto-save-default nil)
(setq make-backup-files nil)
(setq backup-by-copying nil)

(setq auto-save-interval 360000)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-region 'disabled nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  Loading Emacs Lisps
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Indented text mode
;;
(autoload 'indented-text-mode "indented-text-mode" "Normal text" t)
(setq auto-mode-alist (cons '("\\.txt$" . indented-text-mode) auto-mode-alist))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Package setting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;
;;; C-MODE Hoook
;;;
(defun my-c-mode-hook ()
;;  (c-set-style "linux")
  (c-set-style "k&r")
;;  (c-set-style "bsd")
;;  (c-set-style "gnu")
  (setq tab-width 8)
;;  (setq tab-width 4)
  (setq c-basic-offset tab-width)
  (c-toggle-hungry-state 1)
  )
(add-hook 'c-mode-hook 'my-c-mode-hook)

;;;
;;; Text mode hook
;;;
(setq text-mode-hook '(lambda ()
			(turn-on-auto-fill)
			(set-fill-column 7／4)))

;;;
;;; css-mode
;;;
(autoload 'css-mode "css-mode")
(setq auto-mode-alist       
      (cons '("\\.css\\'" . css-mode) auto-mode-alist))
(setq css-mode-hook '(lambda ()
		       (setq cssm-indent-function #'cssm-c-style-indenter)))

;;;
;;; ruby-mode
;;;
(autoload 'ruby-mode "ruby-mode")
(setq auto-mode-alist       
      (cons '("\\.rb\\'" . ruby-mode) auto-mode-alist))

;;;
;;; php-mode
;;;
(autoload 'php-mode "php-mode")
(setq auto-mode-alist       
      (cons '("\\.php\\'" . php-mode) auto-mode-alist))
(setq php-mode-hook '(lambda ()
		       (setq c-basic-offset 8)))

;;;
;;; JavaScript mode
;;;
;(load-library  "cc-mode");
;(autoload 'javascript-mode  "javascript-cust"  "javascript mode" t nil)
;(setq auto-mode-alist
;      (cons '("\\.js$" . javascript-mode) auto-mode-alist))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

