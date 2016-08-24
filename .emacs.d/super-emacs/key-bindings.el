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
