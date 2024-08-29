(setq custom-file "~/.emacs.d/custom.el")
(load custom-file t)

(setq backup-directory-alist
      `(("." . "~/.emacs.d/backups"))
      auto-save-file-name-transforms
      `(("." "~/.emacs.d/auto-save-list/" t)))

;; Melpa
;; https://melpa.org/#/getting-started
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

(use-package helm
  :ensure t)

(use-package magit
  :ensure t)

(use-package company
  :ensure t
  :hook (emacs-lisp-mode . company-tng-mode)
  :config
  (setq company-idle-delay 0.5
	company-minimum-prefix-length 2))

(use-package projectile
  :ensure t
  :bind-keymap
  ("C-c p" . projectile-command-map))

(use-package eglot
  :ensure t
  :demand t
  :bind (:map eglot-mode-map
	      ("C-c f" . eglot-format-buffer)))

(use-package rust-mode
  :ensure t)

(use-package rust-ts-mode
  :ensure t
  :after (eglot)
  :hook ((rust-ts-mode . eglot-ensure)
	 (rust-ts-mode . company-tng-mode))
  :config
  (add-to-list 'auto-mode-list '("\\.rs\\'" . rust-ts-mode))
  (add-to-list 'eglot-server-programs '(rust-ts-mode . ("rust-analyzer"))))

(use-package vertico
  :ensure t
  :config
  (vertico-mode 1))

(setq-default fill-column 80)
(add-hook 'prog-mode-hook
	  (defun wes/prog-mode-hook ()
	    (display-line-numbers-mode)
	    (display-fill-column-indicator-mode)))

(desktop-save-mode 1)

(load-theme 'tango-dark)

;; Disable all bars
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq inhibit-slash-screen t)
(setq use-file-dialog nil)

;; improve scrolling behavior
(setq scroll-step 1
      scroll-conservatively 1)

;; Nov.el
;; https://depp.brause.cc/nov.el/
(use-package nov
  :ensure t
  :hook (('nov-mode-hook . 'wes/nov-font)
	 ('nov-mode-hook . 'visual-line-mode)
	 ('nov-mode-hook . 'visual-fill-column))
  :config
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
  (setq fill-column 120
	nov-text-width (- fill-column 2)
	visual-fill-column-center-text t))

(defun wes/nov-font ()
  (interactive)
  (face-remap-add-relative 'variable-pitch :family "Noto Serif"
			   :height 1.2))

;; Window Management
(global-set-key (kbd "M-o") 'other-window)
;; Global Imenu
(global-set-key (kbd "M-i") 'imenu)
