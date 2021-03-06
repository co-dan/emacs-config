;; Programming stuff

(require 'flycheck)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Paredit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'paredit)
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)


;; Geiser

(setq geiser-active-implementations '(racket))
(add-hook 'scheme-mode-hook 'geiser-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Haskell mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq exec-path (cons "/Users/dan/.stack/programs/x86_64-osx/ghc-7.10.2/bin/" exec-path))

;; (add-to-list 'load-path "~/projects/haskell-mode/")
(require 'haskell-mode-autoloads)
;; (add-to-list 'Info-default-directory-list "~/projects/haskell-mode/")
;; ;;(setq haskell-font-lock-symbols nil)
(add-hook 'haskell-mode-hook 'font-lock-mode)
(setq haskell-program-name "/Users/dan/.stack/programs/x86_64-osx/ghc-7.10.2/bin/ghci")
(setq inferior-haskell-find-project-root nil)
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
(require 'flycheck-haskell)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup))
;; (add-hook 'haskell-mode-hook 'flycheck-mode)

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
(setq shm-program-name "/Users/dan/.local/bin/structured-haskell-mode")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Git & other VCS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-x g") 'magit-status)
(setq magit-auto-revert-mode nil)

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
;; (setq proof-prog-name "/Users/dan/projects/HoTT/hoqtop")
;; (setq coq-compile-before-require t)
;; (setq coq-holes-minor-mode nil)
;; (setq coq-one-command-per-line nil)
;; (setq coq-prog-args (quote ("-emacs")))
;; (setq proof-auto-action-when-deactivating-scripting (quote retract))
;; (setq proof-autosend-enable nil)
;; (setq proof-electric-terminator-enable nil)
;; (setq proof-shell-fiddle-frames nil)
;; (setq proof-splash-enable t)
;; (setq proof-sticky-errors t)
(add-hook 'proof-goals-mode-hook (lambda () (setq proof-eagerly-raise nil)))
(add-hook 'proof-response-mode-hook (lambda () (setq proof-eagerly-raise nil))) 
(setq coq-prog-args
      '("-emacs"
        "-R" "/Users/dan/projects/HoTT/theories" "HoTT"))
;; (setq coq-prog-args
;;       (append
;;        '("-R" "/Users/dan/projects/math-classes/src" "MathClasses"
;;          "-R" "/Users/dan/projects/coq-categories" "Cat")
;;        '("-emacs")))

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
;; Agda

(load-file (let ((coding-system-for-read 'utf-8))
                (shell-command-to-string "agda-mode locate")))
;; (setq agda2-highlight-face-groups '(default-faces)) ;; readable fontface
(require 'zenburn-theme )
(zenburn-with-color-variables
  (custom-set-faces
   `(agda2-highlight-datatype-face ((t (:inherit font-lock-type-face))))
   `(agda2-highlight-field-face ((t (:foreground ,zenburn-green+2))))
   `(agda2-highlight-function-face ((t (:foreground ,zenburn-cyan))))
   `(agda2-highlight-inductive-constructor-face ((t (:foreground ,zenburn-yellow-1))))
   `(agda2-highlight-keyword-face ((t (:inherit font-lock-keyword-face))))
   `(agda2-highlight-module-face ((t (:inherit font-lock-variable-name-face))))
   `(agda2-highlight-number-face ((t (:foreground ,zenburn-green+4))))
   `(agda2-highlight-operator-face ((t (:foreground ,zenburn-cyan))))
   `(agda2-highlight-primitive-face ((t (:foreground ,zenburn-fg :weight bold))))
   `(agda2-highlight-primitive-type-face ((t (:inherit font-lock-variable-name-face :weight bold))))
   `(agda2-highlight-error-face ((t (:foreground ,zenburn-red-1 :weight bold :underline t))))
   '(agda2-highlight-record-face ((t (:foreground "SkyBlue2"))))
   '(proof-locked-face ((t (:background "gray10"))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; JavaScript

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
