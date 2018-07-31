; User details
(setq user-full-name "Ram Prakash")
(setq user-mail-address "reram@channing.harvard.edu")

; Package repos
(require 'package)
(setq package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")
                         ("elpa" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))
    
; Packages to install if not already installed
(setq package-list '( autopair
                      auto-complete
                      solarized-theme
                      flycheck
                      org
                      magit
		      helm
                      markdown-mode
                      writegood-mode
                      web-mode
		      elpy
		      undo-tree
                      evil
                      yaml-mode))
(package-initialize)

; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

; Initial splash screen setup
(setq inhibit-splash-screen t
      initial-scratch-message nil)

; evil
(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode 1)

; Key Bindings
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-;") 'next-multiframe-window)


; Color Scheme
(if window-system
    (load-theme 'zenburn t)
  (load-theme 'wombat t))

; Misc
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

(setq echo-keystrokes 0.1
       use-dialog-box nil)
(show-paren-mode t)

; Line number
(global-linum-mode t)   
(setq linum-format "%d ")

(when window-system (set-frame-size (selected-frame) 204 400))
(set-face-attribute 'default nil :height 160)

(require 'powerline)
(setq ns-use-srgb-colorspace nil)
(powerline-center-evil-theme)
(setq powerline-arrow-shape 'curve)
(setq powerline-default-separator-dir '(right . left))
(set-default-font "Source Code Pro for Powerline" nil t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3f44e2d33b9deb2da947523e2169031d3707eec0426e78c7b8a646ef773a2077" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(package-selected-packages
   (quote
    (material-theme monokai-theme leuven-theme org-bullets helm-ag dumb-jump zenburn-theme doom-themes evil-magit powerline-evil smart-mode-line evil yaml-mode writegood-mode web-mode undo-tree solarized-theme powerline markdown-mode magit goto-last-change flycheck autopair auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

; Undo History persistence
(global-undo-tree-mode)
(setq undo-tree-auto-save-history t)
(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
(savehist-mode 1) ; for commands in mini-buffer

; autopair
(require 'autopair)

(setq auto-window-vscroll nil)

; helm
(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)

; auto-complete
(ac-config-default)

; dumb-jump
(dumb-jump-mode 1)
(setq dumb-jump-selector 'helm)

;elpy
(elpy-enable)
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
(global-set-key (kbd "C-x .") #'elpy-goto-definition)

; key bindings for changing buffers
(global-set-key (kbd "C-h") #'previous-buffer)
(global-set-key (kbd "C-l") #'next-buffer)

; Terminal launch
(defun visit-term-buffer ()
  "Create or visit a terminal buffer."
  (interactive)
  (if (not (get-buffer "*ansi-term*"))
      (progn
        (split-window-sensibly (selected-window))
        (other-window 1)
        (ansi-term (getenv "SHELL")))
    (switch-to-buffer-other-window "*ansi-term*")))

(global-set-key (kbd "C-x t") 'visit-term-buffer)

; Auto pair mode
(autopair-mode)
