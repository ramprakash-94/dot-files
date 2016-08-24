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


;;PYTHON
(elpy-enable)
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
(elpy-use-ipython)

;;Smartparens
(require 'smartparens-config)
(add-hook 'python-mode-hook #'smartparens-mode)
