;Change title-bar text
(setq frame-title-format
      "emacs")

;Disable menu-bar
(menu-bar-mode -1)

;Disable tool-bar
(tool-bar-mode -1)

;Disable scroll-bar
(scroll-bar-mode -1)

;Activate material theme
(load-theme 'solarized-dark t)

;Enable Line numbers globally
(global-linum-mode t)
(setq linum-format "%d ")

;Disable ring bell function
(setq ring-bell-function 'ignore)

;Spaceline Skin
(require 'spaceline-config)
(spaceline-helm-mode)

;;Yes or no dialogs accept y-or-n
(fset 'yes-or-no-p 'y-or-n-p)

;Load package.el
(require 'package)

;Add melpa to list of repositories
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") 
             t)

;Initialize package.el
(package-initialize)

;;PYTHON
(elpy-enable)
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;;virtualenvwrapper
(require 'virtualenvwrapper)
(venv-initialize-eshell)
(venv-initialize-interactive-shells)
(setq venv-location "~/Documents/Environments/")

;;(elpy-use-ipython)

(use-package ox-reveal
:ensure ox-reveal)
(setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/")
(setq org-reveal-mathjax t)

(use-package htmlize
:ensure t)

;Create repositories cache, if required
(when (not package-archive-contents)
  (package-refresh-contents))

;Declare a list of required packages
(defvar super-emacs--required-packages
  '(helm
    multiple-cursors
    ace-jump-mode
    powerline
    switch-window
    buffer-move
    auto-complete
    ztree
    undo-tree
    material-theme
    meta-presenter
    myterminal-controls
    theme-looper))

;Install required packages
(mapc (lambda (p)
        (package-install p))
      super-emacs--required-packages)

;Load default auto-complete configs
(ac-config-default)

;Start undo-tree
(global-undo-tree-mode)

;Set up ace-jump-mode
(autoload 'ace-jump-mode 
  "ace-jump-mode" 
  "Emacs quick move minor mode"
  t)
(autoload 'ace-jump-mode-pop-mark 
  "ace-jump-mode" 
  "Ace jump back:-"
  t)

;Enable powerline
(powerline-center-theme)
(setq powerline-arrow-shape 'curve)

;;Default Fonts
(set-default-font "Source Code Pro" nil t)
(set-face-attribute 'default nil :height 100)

;Configure theme-looper
(theme-looper-set-theme-set '(deeper-blue
                              wheatgrass
                              wombat
                              material
                              monokai
                              zenburn))
(theme-looper-set-customizations 'powerline-reset)

;Configure myterminal-controls
(myterminal-controls-set-controls-data
 '(("t" "Change color theme" theme-looper-enable-next-theme)
   ("r" "Reload file" super-emacs-reload-current-file)))

;Set up helm-mode
(helm-mode 1)
(helm-autoresize-mode 1)
(setq helm-split-window-in-side-p
      t)

;;Smartparens
(require 'smartparens-config)
(add-hook 'python-mode-hook #'smartparens-mode)
(add-hook 'emacs-lisp-mode-hook #'smartparens-mode)

(defvar emacs--my-keyboard-bindings 
  '(("C-}" . mc/mark-next-like-this)
    ("C-{" . mc/mark-previous-like-this)
    ("C-|" . mc/mark-all-like-this)
    ("C->" . ace-jump-mode)
    ("C-<" . ace-jump-mode-pop-mark)
    ("M-/" . undo-tree-visualize)
    ("C-\"" . theme-looper-enable-next-theme)
    ("C-M-'" . myterminal-controls-open-controls)
    ("C-c M-x" . execute-extended-command)
    ("M-x" . helm-M-x)
    ("C-x b" . helm-mini)
    ("C-x C-b" . helm-buffers-list)
    ("C-x C-f" . helm-find-files)
    ("C-x C-r" . helm-recentf)
    ("M-y" . helm-show-kill-ring)
    ("C-M-z" . switch-window)
    ("C-S-<up>" . buf-move-up)
    ("C-S-<down>" . buf-move-down)
    ("C-S-<left>" . buf-move-left)
    ("C-S-<right>" . buf-move-right)
    ("<f5>" . super-emacs-reload-current-file)))

(defun emacs-apply-keyboard-bindings (pair)
  "Apply keyboard-bindings for supplied list of key-pair values"
  (global-set-key (kbd (car pair))
                  (cdr pair)))

(mapc 'emacs-apply-keyboard-bindings
      emacs--my-keyboard-bindings)

;Swiper
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(global-set-key "\C-s" 'swiper)

;;Helm
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)


;;Windmove
(global-set-key (kbd "<C-S-left>")  'windmove-left)
(global-set-key (kbd "<C-S-right>") 'windmove-right)
(global-set-key (kbd "<C-S-up>")    'windmove-up)
(global-set-key (kbd "<C-S-down>")  'windmove-down)

(global-unset-key (vector (list 'shift 'left)))
(global-unset-key (vector (list 'shift 'right)))
(global-unset-key (vector (list 'shift 'up)))
(global-unset-key (vector (list 'shift 'down)))

(defun super-emacs-reload-current-file ()
  "Reload the file loaded in current buffer from the disk"
  (interactive)
  (cond (buffer-file-name (progn (find-alternate-file buffer-file-name)
                                 (message "File reloaded")))
        (t (message "You're not editing a file!"))))

;Disable splash message, start *scratch* buffer by default
(setq initial-buffer-choice 
      t)
(setq initial-scratch-message 
      "")

;Enforce spaces for indentation, instead of tabs
(setq-default indent-tabs-mode 
              nil)

;Enable show-paren-mode
(show-paren-mode)

;Enable winner-mode
(winner-mode t)

;;Disable Line numbers for .org files
(defun nolinum()
  (interactive)
  (message "Deactivated linum mode")
  (global-linum-mode 0)
  (linum-mode 0)
  )
(global-set-key (kbd "<f6>") 'nolinum)
(add-hook 'org-mode-hook 'nolinum)


;;Org-mode Bullets
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; fontify code in code blocks
(setq org-src-fontify-natively t)
