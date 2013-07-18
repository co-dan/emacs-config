;; Main configuration entry point

(setenv "PATH" "/Users/dan/Library/Haskell/bin:/Users/dan/.cabal/bin:/usr/local/sbin:/usr/local/bin:/usr/local/Cellar/smlnj/110.75/libexec/bin:/Users/dan/racket/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/git/bin:/usr/texbin:/Users/dan/.rvm/bin:/Users/dan/.rvm/bin")

(menu-bar-mode 1)
(scroll-bar-mode -1)
(tooltip-mode 1)
(setq column-number-mode t)

;; Mac-specific options
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)
(set-default-font "Monaco-16")

;; Aquamacs settings
(set-default-font "Monaco-16")
(when (boundp 'aquamacs-version)
  (tabbar-mode -1)		     ; no tabbar
  (one-buffer-one-frame-mode -1)       ; no one-buffer-per-frame
;; (setq special-display-regexps nil)   ; do not open certain buffers in special windows/frames
(aquamacs-autoface-mode -1)
  )

;; Bells & whistles
(setq visible-bell nil) ;; Be less annoying plz
(setq ring-bell-function (lambda nil (message "")))

(add-to-list 'custom-theme-load-path "~/.emacs.d/dan/emacs-color-theme-solarized")
(load-theme 'solarized-dark t)

;; IDO
(setq ido-everywhere t)

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
(desktop-save-mode 1)

(global-linum-mode 1)
(column-number-mode 1)

;; Change 'yes' to 'y' and 'no' to 'n'
(fset 'yes-or-no-p 'y-or-n-p)




