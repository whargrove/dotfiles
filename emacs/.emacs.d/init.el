(setq custom-file "~/.emacs.d/custom.el")
(load custom-file t)

(setq backup-directory-alist
      `(("." . "~/.emacs.d/backups"))
      auto-save-file-name-transforms
      `((".*" "~/.emacs.d/auto-save-list/\\1" t)))

;; only hidpi screens so make the default font more readable
(set-face-attribute 'default nil :height 140)

;; fonts
(defvar my/fixed-width-font "JetBrains Mono")
(set-face-attribute 'default nil :font my/fixed-width-font :weight 'regular)
(set-face-attribute 'fixed-pitch nil :font my/fixed-width-font :weight 'regular)
(defvar my/variable-width-font "Iosevka Aile")
(set-face-attribute 'variable-pitch nil :font my/variable-width-font :weight 'regular)

;; Melpa
;; https://melpa.org/#/getting-started
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(use-package exec-path-from-shell
  :ensure t)
(when (daemonp)
  (exec-path-from-shell-initialize))
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; Save minibuffer command history
(savehist-mode 1)
;; Use vertico to show commands in minibuffer in a vertical list.
;; https://github.com/minad/vertico
(use-package vertico
  :ensure t
  :config
  (setq vertico-cycle t)
  (setq vertico-resize nil)
  (vertico-mode 1))

;; Fill the whitespace in minibuffer commands with description
;; https://github.com/minad/marginalia
(use-package marginalia
  :ensure t
  :config
  (marginalia-mode 1))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic)))

(use-package consult
  :ensure t
  :bind (;; A recursive grep
         ("M-s M-g" . consult-grep)
         ;; Search for files names recursively
         ("M-s M-f" . consult-find)
         ;; Search through the outline (headings) of the file
         ("M-s M-o" . consult-outline)
         ;; Search the current buffer
         ("M-s M-l" . consult-line)
         ;; Switch to another buffer, or bookmarked file, or recently
         ;; opened file.
         ("M-s M-b" . consult-buffer)))

;; Make it look nicer
(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-tomorrow-night t)
  (doom-themes-visual-bell-config)
  (setq doom-themes-treemacs-theme "doom-colors")
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

(use-package solaire-mode
  :ensure t
  :config
  (solaire-global-mode +1))

(use-package nerd-icons
  :ensure t
  :custom
  (nerd-icons-font-family "Symbols Nerd Fonts Mono"))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; Keep the menu-bar since it can be useful!
(menu-bar-mode 1)

;; Disable all bars
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq inhibit-slash-screen t)
(setq use-file-dialog nil)

;; improve scrolling behavior
(setq scroll-step 1
      scroll-conservatively 1)

;; Window Management
(global-set-key (kbd "M-o") 'other-window)
;; Global Imenu
(global-set-key (kbd "M-i") 'imenu)

(defun sudo ()
  "Use TRAMP to `sudo' the current buffer."
  (interactive)
  (when buffer-file-name
    (find-alternate-file
     (concat "/sudo:root@localhost:"
             buffer-file-name))))

;; packages begin here

(use-package notmuch
  :load-path "/usr/share/emacs/site-lisp/"
  :defer t
  :commands (notmuch notmuch-mua-new-mail))
  

;; nov.el
;; https://depp.brause.cc/nov.el/

(use-package visual-fill-column
  :ensure t)

(defun my/nov-setup ()
  (interactive)
  (unless visual-line-mode
    (visual-line-mode 1))
  (unless visual-fill-column-mode
    (run-with-idle-timer 1 nil #'visual-fill-column-mode))
  (setq-local fill-column 110
	      nov-text-width 110
	      visual-fill-column-center-text t))

(use-package nov
  :ensure t
  :hook (nov-mode . my/nov-setup)
  :config
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))

;; magit
;; https://magit.vc/
(use-package magit
  :ensure t)

;; magit-forge
;; https://magit.vc/manual/forge/
(use-package forge
  :ensure t
  :after magit)
;; TODO: use gpg
(setq auth-sources '("~/.authinfo"))

;; company
;; http://company-mode.github.io/
(use-package company
  :ensure t)
(global-company-mode)

(defun my/prog-mode-hook ()
  ; enable line numbers
  (display-line-numbers-mode 1))
(add-hook 'prog-mode-hook 'my/prog-mode-hook)

;; eglot
;; https://github.com/joaotavora/eglot
(require 'eglot)
;; define hooks to ensure eglot is enabled
(add-hook 'js-ts-mode-hook 'eglot-ensure)
(add-hook 'ts-ts-mode-hook 'eglot-ensure)

(require 'treesit)
;; javascript/typescript
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))

;; spaces (not tabs)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; TODO javascript
;; TODO python
;; TODO rust

;; org
(use-package org
  :ensure t)
(setq org-agenda-files (quote ("~/org/inbox.org"
			       "~/org/personal.org"
			       "~/org/work.org"
			       "~/org/reading.org")))
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
	      (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)"))))
(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
	      ("NEXT" :foreground "blue" :weight bold)
	      ("DONE" :foreground "forest green" :weight bold)
	      ("WAITING" :foreground "orange" :weight bold)
	      ("HOLD" :foreground "magenta" :weight bold)
	      ("CANCELLED" :foreground "forest green" :weight bold))))
(setq org-use-fast-todo-selection t)
(setq org-directory "~/org")
(setq org-default-notes-file "~/org/inbox.org")
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/org/inbox.org")
	       "* TODO %?\n%U\n%a\n"))))
(setq org-refile-targets (quote ((nil :maxlevel . 9)
				 (org-agenda-files :maxlevel . 9))))
(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-allow-creating-parent-nodes (quote confirm))
(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))
(setq ido-default-file-method 'selected-window)
(setq ido-default-buffer-method 'selected-window)
(setq org-indirect-buffer-display 'current-window)
(defun wh/verify-refile-target ()
  "Exclude TODO keywords with a DONE state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))
(setq org-refile-target-verify-function 'wh/verify-refile-target)

;; projectile

(defun my-projectile-magit-status ()
  "Open magit-status when switching to a project."
  (magit-status (projectile-project-root)))

(use-package projectile
  :ensure t
  :after magit
  :config
  (projectile-mode +1)
  (setq projectile-project-search-path '(("~/workspace" . 1)))
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  :hook
  (projectile-after-switch-project . #'my-projectile-magit-status))

;; pdf-tools
(use-package pdf-tools
  :ensure t
  :defer t
  :commands (pdf-loader-install)
  :mode "\\.pdf\\'"
  :init (pdf-loader-install)
  :config (add-to-list 'revert-without-query ".pdf"))
;; disable line numbers when viewing a PDF
(add-hook 'pdf-view-mode-hook #'(lambda () (interactive) (display-line-numbers-mode -1)))

(use-package prettier
  :ensure t
  :hook
  ((typescript-ts-mode tsx-ts-mode js-ts-mode json-ts-mode) . prettier-mode))

(use-package tempel
  :ensure t
  :bind
  (("M-+" . tempel-complete)
   ("M-*" . tempel-insert))
  :init
  (defun tempel-setup-capf ()
    (setq-local completion-at-point-functions
                (cons #'tempel-expand
                      completion-at-point-functions)))
  (add-hook 'conf-mode-hook 'tempel-setup-capf)
  (add-hook 'prog-mode-hook 'tempel-setup-capf)
  (add-hook 'text-mode-hook 'tempel-setup-capf))

(use-package tempel-collection
  :ensure t)

(use-package corfu
  :ensure t
  :init
  (global-corfu-mode))

;; packages end here

;; init.el ends here
