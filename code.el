;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Haskell mode
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load "~/projects/haskell-mode/haskell-site-file")
;(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(setq haskell-font-lock-symbols nil)

(setq haskell-program-name "ghci")
(setq inferior-haskell-find-project-root nil)
;(require 'haskell-indent)

(setq exec-path (cons "~/Library/Haskell/bin" exec-path))
(setq load-path (cons "~/Library/Haskell/ghc-7.6.3/lib/ghc-mod-2.0.3/share" load-path))
(autoload 'ghc-init "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))
;;(setq haskell-mode-hook (cdr haskell-mode-hook))
;;(setq ghc-ghc-options '("-i ~/Library/Haskell/ghc-7.6.3/lib"))
;;(setq ghc-module-command "ghc-mod")
(setq ghc-module-command "~/vado-ghc-mod.sh")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; F# mode
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq load-path (cons "~/fsharp/fsharp-mode" load-path))
(setq auto-mode-alist (cons '("\\.fs[iylx]?$" . fsharp-mode) auto-mode-alist))
(autoload 'fsharp-mode "fsharp" "Major mode for editing F# code." t)
(autoload 'run-fsharp "inf-fsharp" "Run an inferior F# process." t)
(setq inferior-fsharp-program "fsharpi --readline-")
(setq fsharp-compiler "fsharpc")

;;; SML
(load "~/sml/sml-mode/sml-mode-startup")
(setenv "PATH" (concat "/usr/local/Cellar/smlnj/110.75/libexec/bin" (getenv "PATH")))
(setq exec-path (cons "/usr/local/Cellar/smlnj/110.75/libexec/bin" exec-path))
(add-to-list 'auto-mode-alist '("\\.\\(sml\\|sig\\)\\'" . sml-mode))

;; Scala

(add-to-list 'load-path "~/projects/scala/scala-dist/tool-support/src/emacs")
(require 'scala-mode-auto)
(add-hook 'scala-mode-hook '(lambda () (scala-mode-feature-electric-mode)))
;; Proof General

(load-file "~/ProofGeneral/generic/proof-site.el")

;; Twelf

;; (setq twelf-root "/home/dan/twelf/twelf/")
;; (load (concat twelf-root "emacs/twelf-init.el")) 

;; Flymake

(global-set-key "\M-n" 'flymake-goto-next-error)
(global-set-key "\M-p" 'flymake-goto-prev-error)
(global-set-key "\M-?" 'flymake-display-err-menu-for-current-line)

