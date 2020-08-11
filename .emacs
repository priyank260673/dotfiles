;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp/evil")
(add-to-list 'load-path "~/.emacs.d/lisp/color-theme")
;;(add-to-list 'load-path "~/.emacs.d/lisp/avy/")
;;(add-to-list 'load-path "~/.emacs.d/lisp/ace-window/")
(require 'evil)
(evil-mode 1)
;;(require 'avy)
;;(require 'ace-window)
(require 'color-theme)

(global-set-key (kbd "M-o") 'ace-window)

(eval-after-load "color-theme"
				 '(progn
					(color-theme-initialize)
					(color-theme-dark-laptop)))
;;(color-theme-charcoal-black)))
;;(load-theme 'idea-darkula t)

;; Go to line
;;(global-set-key "\C-l" 'goto-line)

;; auto complete word
;;(global-set-key [backtab] 'dabbrev-expand)
(global-set-key [backtab] 'hippie-expand)

;; Switching between split windows
(global-set-key "\C-l" 'next-multiframe-window)
(global-set-key "\C-h" 'previous-multiframe-window)


;; turn off dedicated-windows
(defun toggle-current-window-dedication ()
  (interactive)
  (let* ((window    (selected-window))
		 (dedicated (window-dedicated-p window)))
	(set-window-dedicated-p window (not dedicated))
	(message "Window %sdedicated to %s"
			 (if dedicated "no longer " "")
			 (buffer-name))))

;; compilation/debuggin setting
(global-set-key [f5] 'shrink-window-horizontally)
(global-set-key [f6] 'enlarge-window-horizontally)
(global-set-key [f7] 'next-buffer)
(global-set-key [f8] 'previous-buffer)
(global-set-key [f9] 'gud-break)
(global-set-key [f10] 'gud-remove)
(global-set-key [f11] 'toggle-current-window-dedication)

;; ipp files needs to be in c*mode otherwise debugger
;; will open up another source frame
(add-to-list 'auto-mode-alist '("\\.ipp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.ipp\\'" . c-mode))

(global-linum-mode 1)
(setq linum-format "%4d ")

;;;; Put full path name
(defvar mode-line-buffer-identification-default
    mode-line-buffer-identification
	  "Original value of `mode-line-buffer-identification'.")

(setq-default mode-line-buffer-identification '(:eval 
		(if (buffer-file-name) 
		  (abbreviate-file-name (buffer-file-name))
		  mode-line-buffer-identification-default)))

;; Only open one source buffer window while debugging
(add-to-list 'display-buffer-alist
			 (cons 'cdb-source-code-buffer-p
				   (cons 'display-source-code-buffer nil)))
(defun cdb-source-code-buffer-p (bufName action)
  "Return whether BUFNAME is a source code buffer."
  (let ((buf (get-buffer bufName)))
	(and buf
		 (with-current-buffer buf
							  (derived-mode-p buf 'c++-mode 'c-mode 'csharp-mode 'nxml-mode)))))

(defun display-source-code-buffer (sourceBuf alist)
  "Find a window with source code and set sourceBuf inside it."
  (let* ((curbuf (current-buffer))
		 (wincurbuf (get-buffer-window curbuf))
		 (win (if (and wincurbuf
					   (derived-mode-p sourceBuf 'c++-mode 'c-mode 'nxml-mode)
					   (derived-mode-p (current-buffer) 'c++-mode 'c-mode 'nxml-mode))
				wincurbuf
				(get-window-with-predicate
				  (lambda (window)
					(let ((bufName (buffer-name (window-buffer window))))
					  (or (cdb-source-code-buffer-p bufName nil)
						  (assoc bufName display-buffer-alist)
						  ))))))) ;; derived-mode-p doesn't work inside this, don't know why...
	(set-window-buffer win sourceBuf)
	win))

(require 'gud)

; invoke
(global-set-key [f8] 'gdb)

; GDB layout
(defadvice gdb-setup-windows (after activate)
		   (gdb-setup-my-windows)
		   )

(defun gdb-setup-my-windows ()
  (set-window-dedicated-p (selected-window) nil)
  (switch-to-buffer gud-comint-buffer)
  (delete-other-windows)
  (let
	((win0 (selected-window))             ; breakpoints
	 (win1 (split-window-horizontally
			 (floor (* 0.506 (window-width)))))   ; source + i/o
	 ;;(win2 (split-window-vertically
	;;		 (floor (* 0.5 (window-body-height))))) ; gdb
	 ;;(win3 (split-window-vertically
	;;		 (floor (* 0.5 (window-body-height))))) ; locals
	 ;;(win4 (split-window-vertically
	;;		 (floor (* 0.6 (window-body-height))))) ; stack
	 )
	; configurating right window
	(select-window win1)
	(let
	  ((winSrc (selected-window)) ; source
	   (winIO (split-window-vertically (floor (* 0.7 (window-body-height))))) ; I/O
	   )
	  (set-window-buffer winIO (gdb-get-buffer-create 'gdb-inferior-io))
	  (set-window-buffer
		winSrc
		(if gud-last-last-frame
		  (gud-find-file (car gud-last-last-frame))
		  (if gdb-main-file
			(gud-find-file gdb-main-file)
			(list-buffers-noselect))))
	  (setq gdb-source-window winSrc)
	  (set-window-dedicated-p winIO t)
	  )
	;;(set-window-buffer win0 (gdb-get-buffer-create 'gdb-breakpoints-buffer))
	;; (set-window-buffer win0 (gdb-get-buffer-create 'gdb-locals-buffer))
	;;(set-window-buffer win3 (gdb-get-buffer-create 'gdb-locals-buffer))
	;;(set-window-buffer win4 (gdb-get-buffer-create 'gdb-stack-buffer))
	(select-window win0)
	)
  )

; GDB variables
(setq gdb-many-windows t)
(setq gdb-show-main t)
(setq gdb-show-changed-values t)
(setq gdb-use-colon-colon-notation t)
(setq gdb-use-separate-io-buffer nil)
(setq gdb-delete-out-of-scope t)
(setq gdb-speedbar-auto-raise t)

;;;;;;;;;
;; Highlight current line in source
(defvar gud-overlay
  (let* ((ov (make-overlay (point-min) (point-min))))
	(overlay-put ov 'face 'secondary-selection)
	ov)
  "Overlay variable for GUD highlighting.")

(defadvice gud-display-line (after my-gud-highlight act)
		   "Highlight current line."
		   (let* ((ov gud-overlay)
				  (bf (gud-find-file true-file)))
			 (with-current-buffer bf
								  (move-overlay ov (line-beginning-position) (line-beginning-position 2)
												(current-buffer)))))

;; Alt-x key binding
;; (global-set-key [f12] 'execute-extended-command)
;; display line numbers
;;(global-linum-mode t)
;; follow focus with mouse
(setq mouse-autoselect-window t)

(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))
(global-set-key [f12] 'show-file-name) ; Or any other key you want

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  '(gdb-enable-debug t)
  '(gdb-many-windows t)
  '(gdb-stopped-functions nil)
  '(gud-gud-gdb-command-name "gdb --fullname")
  '(gud-tooltip-mode t)
  '(package-selected-packages (quote (idea-darkula-theme evil color-theme)))
  '(scroll-bar-mode nil)
  '(tool-bar-mode nil)
  '(tooltip-mode t)
  '(transient-mark-mode nil))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  )

;; C-x 1 - zoom in, C-c <left Arrow> zoom out
(when (fboundp 'winner-mode)
  (winner-mode 1))
