;; Programming stuff

(require 'flycheck)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Haskell mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq exec-path (cons "/Applications/ghc-7.8.2.app/Contents/bin/" exec-path))
(setq exec-path (cons "/Users/dan/Library/Haskell/bin/" exec-path))

;; (add-to-list 'load-path "~/projects/haskell-mode/")
(require 'haskell-mode-autoloads)
;; (add-to-list 'Info-default-directory-list "~/projects/haskell-mode/")
;; ;;(setq haskell-font-lock-symbols nil)
(add-hook 'haskell-mode-hook 'font-lock-mode)
(setq haskell-program-name "/Applications/ghc-7.8.2.app/Contents/bin/ghci")
(setq inferior-haskell-find-project-root nil)
(define-key haskell-mode-map (kbd "C-,") 'haskell-move-nested-left)
(define-key haskell-mode-map (kbd "C-.") 'haskell-move-nested-right)
;; ;; (add-hook 'haskell-mode-hook 'imenu-add-menubar-index)

;; ;; Ghc mod
(setq load-path (cons "/Users/dan/Library/Haskell/ghc-7.8.2/lib/ghc-mod-4.1.3/share" load-path))
(autoload 'ghc-init "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))
;; ;;(setq haskell-mode-hook (cdr (reverse haskell-mode-hook)))
(setq ghc-ghc-options '("-i ~/Library/Haskell/ghc-7.8.2/lib"))
(setq ghc-module-command "/Users/dan/Library/Haskell/bin/ghc-mod")

(flycheck-define-checker haskell-ghcmod
                         "A Haskell syntax and type checker using ghc-mod"
                         :command ("ghc-mod" "check" source-inplace)
                         :error-patterns
                         ((warning line-start (file-name) ":" line ":" column ":"
                                   (or " " "\n    ") "Warning:" (optional "\n")
                                   (one-or-more " ")
                                   (message (one-or-more not-newline)
                                            (zero-or-more "\n"
                                                          (one-or-more " ")
                                                          (one-or-more not-newline)))
                                   line-end)
                          (error line-start (file-name) ":" line ":" column ":"
                                 (or (message (one-or-more not-newline))
                                     (and "\n" (one-or-more " ")
                                          (message (one-or-more not-newline)
                                                   (zero-or-more "\n"
                                                                 (one-or-more " ")
                                                                 (one-or-more not-newline)))))
                                 line-end))
                         :modes haskell-mode
                         ;; :next-checkers ((warnings-only . haskell-hlint))
                         )

;;(add-to-list 'flycheck-checkers 'haskell-ghcmod)

;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'flycheck-mode)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)

(defun haskell-style ()
  "Sets the current buffer to use Haskell Style. Meant to be
added to `haskell-mode-hook'"
  (interactive)
  (setq tab-width 4
        haskell-indentation-layout-offset 4
        haskell-indentation-left-offset 4
        haskell-indentation-ifte-offset 4))

(add-hook 'haskell-mode-hook 'haskell-style)

;; ;;(setq haskell-stylish-on-save t)

;;; Structured haskell mode

(add-to-list 'load-path "/Users/dan/projects/structured-haskell-mode/elisp")
(require 'shm)
(add-hook 'haskell-mode-hook 'structured-haskell-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Git & other VCS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-x g") 'magit-status)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HTML/CSS/bla-bla
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'auto-mode-alist '("\\.html?$" . sgml-mode))
(require 'mustache-mode)
(autoload 'sgml-close-tag "sgml-mode")
(add-hook 'mustache-mode-hook
          (lambda ()
            (esk-prog-mode-hook)
            (setq comment-start-skip "\\(\\(^\\|[^\\\\\n]\\)\\(\\\\\\\\\\)*\\);+ *")))
(define-key mustache-mode-map (kbd "C-c /") 'sgml-close-tag)
(define-key mustache-mode-map (kbd "RET") nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; SML
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setenv "PATH" (concat "/usr/local/Cellar/smlnj/110.75/libexec/bin:" (getenv "PATH")))
(setq exec-path (cons "/usr/local/Cellar/smlnj/110.75/libexec/bin" exec-path))
(add-to-list 'auto-mode-alist '("\\.\\(sml\\|sig\\)\\'" . sml-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Proof General/Coq
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load-file "~/ProofGeneral/generic/proof-site.el")
(setq coq-prog-args '("-emacs"))
;; ;; (setq coq-prog-args
;; ;;       '("-emacs-U"
;; ;;         "-R" "/Users/dan/projects/coq-categories" "Cat"))
;; (setq coq-prog-args
;;       (append
;;        '("-R" "/Users/dan/projects/math-classes/src" "MathClasses"
;;          "-R" "/Users/dan/projects/coq-categories" "Cat")
;;        '("-emacs-U")))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; Flymake
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (global-set-key "\M-n" 'flymake-goto-next-error)
;; (global-set-key "\M-p" 'flymake-goto-prev-error)
;; (global-set-key "\M-?" 'flymake-display-err-menu-for-current-line)

;; (custom-set-faces
;;  '(flymake-errline ((t (:background "firebrick"))))
;;  '(flymake-warnline ((t (:foreground "RoyalBlue3")))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; JavaScript

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
