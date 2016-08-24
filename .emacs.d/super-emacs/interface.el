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
(load-theme 'material t)

;Enable Line numbers globally
(global-linum-mode t)
(setq linum-format "%d ")

;Disable ring bell function
(setq ring-bell-function 'ignore)

;Spaceline Skin
(require 'spaceline-config)
(spaceline-helm-mode)
