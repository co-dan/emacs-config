;; Main configuration entry point

;; startup
(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
(setq inhibit-startup-message t
      color-theme-is-global t
      sentence-end-double-space nil
      shift-select-mode nil
      mouse-yank-at-point t
      uniquify-buffer-name-style 'forward
      whitespace-style '(face trailing lines-tail tabs)
      whitespace-line-column 80
      ediff-window-setup-function 'ediff-setup-windows-plain
      oddmuse-directory (concat user-emacs-directory "oddmuse")
      save-place-file (concat user-emacs-directory "places")
      diff-switches "-u")

;; start emacs-server
(server-start)

(setq debug-on-error nil)

(setenv "PATH" "/Library/TeX/texbin:/Users/dan/projects/agda/.cabal-sandbox/bin:/Users/dan/Library/Haskell/bin:/Users/dan/.cabal/bin:/usr/local/sbin:/usr/local/bin:/usr/local/Cellar/smlnj/110.75/libexec/bin:/Users/dan/racket/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/git/bin:/usr/texbin:/Users/dan/.rvm/bin:/Users/dan/.rvm/bin:/Applications/ghc-7.8.2.app/Contents/bin")
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "/Library/TeX/texbin")
(add-to-list 'exec-path "/Users/dan/projects/agda/.cabal-sandbox/bin")
(add-to-list 'exec-path "/Applications/ghc-7.8.2.app/Contents/bin/")

(menu-bar-mode 1)
(scroll-bar-mode -1)
(tooltip-mode 1)
(setq column-number-mode t)
(show-paren-mode t)
(setq show-paren-style 'mixed)

;; Mac-specific options
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)
(setenv "LANG" "ru_RU.UTF-8")
(set-default-font "Monaco-18")
;; (set-face-attribute 'default nil :family "Monaco-18")
(set-fontset-font t 'unicode "Symbola" nil 'prepend)
(set-fontset-font t 'cyrillic "Menlo-16")
(setq mac-allow-anti-aliasing 't)

;; Aquamacs settings
(when (boundp 'aquamacs-version)
  (tabbar-mode -1)		     ; no tabbar
  (one-buffer-one-frame-mode -1)       ; no one-buffer-per-frame
;; (setq special-display-regexps nil)   ; do not open certain buffers in special windows/frames
(aquamacs-autoface-mode -1)
  )

;; Bells & whistles
(setq visible-bell nil) ;; Be less annoying plz
(setq ring-bell-function (lambda nil (message "")))

;;;;;;; Color themes!
(load-theme 'zenburn t)
(enable-theme 'zenburn)

;; Nyan-mode
;; https://github.com/TeMPOraL/nyan-mode.git
(add-to-list 'load-path "~/.emacs.d/dan/nyan-mode")
(require 'nyan-mode)
(define-globalized-minor-mode global-nyan-mode
  nyan-mode nyan-mode)
(global-nyan-mode 1)

;; IDO-everywhere, smex
(require 'ido)
(require 'ido-vertical-mode)
(ido-ubiquitous-mode)
(setq ido-everywhere t)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(ido-vertical-mode 1)

;; Numbered windows
;; Switching between windows with M-<n>
(require 'window-number)
(window-number-mode)
(window-number-meta-mode)


;; Put autosave files (ie #foo#) in one place, *not* scattered all over the
;; file system! (The make-autosave-file-name function is invoked to determine
;; the filename of an autosave file.)
(defvar autosave-dir nil)
(setq autosave-dir "~/emacs/autosaves")

(defun auto-save-file-name-p (filename)
  (string-match "^#.*#$" (file-name-nondirectory filename)))

(defun make-auto-save-file-name ()
  (concat autosave-dir
   (if buffer-file-name
      (concat "#" (file-name-nondirectory buffer-file-name) "#")
    (expand-file-name
     (concat "#%" (buffer-name) "#")))))

;; Put backup files (ie foo~) in one place too. (The backup-directory-alist
;; list contains regexp=>directory mappings; filenames matching a regexp are
;; backed up in the corresponding directory. Emacs will mkdir it if necessary.)
(defvar backup-dir "~/emacs/backups")
(setq backup-directory-alist (list (cons "." backup-dir)))


;; save open buffers
(setq desktop-path '("~/.emacs.d/"))
(setq desktop-base-file-name "emacs-desktop")
(desktop-save-mode 1)

(global-linum-mode 1)
(column-number-mode 1)

;; Change 'yes' to 'y' and 'no' to 'n'
(fset 'yes-or-no-p 'y-or-n-p)

(require 'god-mode)
(global-set-key (kbd "<escape>") 'god-local-mode)
(define-key god-local-mode-map (kbd "i") 'god-local-mode)
(defun my-update-cursor ()
  (setq cursor-type (if (or god-local-mode buffer-read-only)
                        'box
                      'bar)))

(add-hook 'god-mode-enabled-hook 'my-update-cursor)
(add-hook 'god-mode-disabled-hook 'my-update-cursor)
