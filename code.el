;; Programming stuff

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Haskell mode
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/projects/haskell-mode/")
(require 'haskell-mode-autoloads)
(add-to-list 'Info-default-directory-list "~/projects/haskell-mode/")
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(setq haskell-font-lock-symbols t)
(add-hook 'haskell-mode-hook 'font-lock-mode)
(setq haskell-program-name "ghci")
(setq inferior-haskell-find-project-root nil)
(define-key haskell-mode-map (kbd "C-,") 'haskell-move-nested-left)
(define-key haskell-mode-map (kbd "C-.") 'haskell-move-nested-right)

(add-hook 'haskell-mode-hook 'imenu-add-menubar-index)

(setq exec-path (cons "~/Library/Haskell/bin" exec-path))
(setq load-path (cons "/Users/dan/projects/ghc-mod/elisp" load-path))
(autoload 'ghc-init "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))
;;(setq ghc-ghc-options '("-i ~/Library/Haskell/ghc-7.6.3/lib"))
;;(setq ghc-module-command "/Users/dan/Library/Haskell/bin/ghc-mod")
;;(setq ghc-module-command "/Users/dan/vado-ghc-mod.sh")


;;; SML
(setenv "PATH" (concat "/usr/local/Cellar/smlnj/110.75/libexec/bin:" (getenv "PATH")))
(setq exec-path (cons "/usr/local/Cellar/smlnj/110.75/libexec/bin" exec-path))
(add-to-list 'auto-mode-alist '("\\.\\(sml\\|sig\\)\\'" . sml-mode))

;; Proof General
(load-file "~/ProofGeneral/generic/proof-site.el")


;; Flymake
(global-set-key "\M-n" 'flymake-goto-next-error)
(global-set-key "\M-p" 'flymake-goto-prev-error)
(global-set-key "\M-?" 'flymake-display-err-menu-for-current-line)

(custom-set-faces
 '(flymake-errline ((t (:background "firebrick"))))
 '(flymake-warnline ((t (:background "RoyalBlue3")))))

