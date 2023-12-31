(tool-bar-mode -1)             ; Hide the outdated icons
(scroll-bar-mode -1)           ; Hide the always-visible scrollbar
(setq inhibit-splash-screen t) ; Remove the "Welcome to GNU Emacs" splash screen
(setq use-file-dialog nil)      ; Ask for textual confirmation instead of GUI

; straight.el
; https://github.com/radian-software/straight.el
(defvar bootstrap-version)
; fix issue with warning at init
; c.f. https://jeffkreeftmeijer.com/emacs-native-comp-log/
(setq straight-repository-branch "develop")
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

; configure straight.el to use use-package
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
(setq use-package-always-defer t)

(use-package emacs
  :init
  ; suppress the initial scratch message
  (setq initial-scratch-message nil)
  ; suppress the startup message
  (defun display-startup-echo-area-message ()
    (message ""))
  ; don't spell out yes or no each time
  (defalias 'yes-or-no-p 'y-or-n-p)
  ;; utf-8 all the things
  (set-charset-priority 'unicode)
  (setq locale-coding-system 'utf-8
        coding-system-for-read 'utf-8
        coding-system-for-write 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)
  (setq default-process-coding-system '(utf-8-unix . utf-8-unix))
  ; spaces > tabs
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 2)
  ; macOS keybindings
  (when (eq system-type 'darwin)
		(setq mac-command-modifier 'super)
		(setq mac-option-modifier 'meta)
		(setq mac-control-modifier 'control))
  ; add line numbers in all programming modes
  (add-hook 'prog-mode-hook 'display-line-numbers-mode)
  ; set a default font
  (set-face-attribute 'default nil
                      :font "FiraCode Nerd Font Mono"
                      :height 120))
