
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
(global-set-key [f3] 'shrink-window)
(global-set-key [f4] 'enlarge-window)
(global-set-key [f5] 'shrink-window-horizontally)
(global-set-key [f6] 'enlarge-window-horizontally)

(global-set-key [f7] 'next-buffer)
(global-set-key [f8] 'previous-buffer)
(global-set-key [f9] 'gud-break)
(global-set-key [f10] 'gud-remove)
(global-set-key [f11] 'toggle-current-window-dedication)

;; gdb setup windows
;;(defadvice gdb-setup-windows (around setup-more-gdb-windows activate)
;; ad-do-it
;; (split-window-horizontally)
;; (other-window 1)
;; (gdb-set-window-buffer
;;  (gdb-get-buffer-create 'gdb-some-buffer-type)))
(defun gdb-setup-windows ()
  "Layout the window pattern for `gdb-many-windows'."
  (gdb-display-locals-buffer)
  (gdb-display-stack-buffer)
  (delete-other-windows)
  (gdb-display-breakpoints-buffer)
  (delete-other-windows)
  ;; Don't dedicate.
  (switch-to-buffer gud-comint-buffer)
  (let ((win0 (selected-window))
		(win1 (split-window nil ( / ( * (window-height) 3) 4)))
		(win2 (split-window nil ( / (window-height) 3)))
		(win3 (split-window-right)))
	(gdb-set-window-buffer (gdb-locals-buffer-name) nil win3)
	(select-window win2)
	(set-window-buffer
	  win2
	  (if gud-last-last-frame
		(gud-find-file (car gud-last-last-frame))
		(if gdb-main-file
		  (gud-find-file gdb-main-file)
		  ;; Put buffer list in window if we
		  ;; can't find a source file.
		  (list-buffers-noselect))))
	(setq gdb-source-window (selected-window))
	(let ((win4 (split-window-right)))
	  (gdb-set-window-buffer
		(gdb-get-buffer-create 'gdb-inferior-io) nil win4))
	(select-window win1)
	(gdb-set-window-buffer (gdb-stack-buffer-name))
	(let ((win5 (split-window-right)))
	  (gdb-set-window-buffer (if gdb-show-threads-by-default
							   (gdb-threads-buffer-name)
							   (gdb-breakpoints-buffer-name))
							 nil win5))
	(select-window win0)))

(setq gdb-display-locals-buffer t)

;;(setq gdb-many-windows t)
;;(setq gdb-setup-windows t)

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

;; format title bar to show full path of current file
(setq-default frame-title-format
			  (list '((buffer-file-name " %f"
										(dired-directory
										  dired-directory
										  (revert-buffer-function " %b"
																  ("%b - Dir:  " default-directory)))))))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  '(gdb-enable-debug t)
  '(gdb-stopped-functions nil)
  '(gud-gud-gdb-command-name "gdb --fullname")
  '(gud-tooltip-mode t)
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

