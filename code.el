;; Programming stuff

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Haskell mode
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq exec-path (cons "~/Library/Haskell/bin" exec-path))

(add-to-list 'load-path "~/projects/haskell-mode/")
(require 'haskell-mode-autoloads)
(add-to-list 'Info-default-directory-list "~/projects/haskell-mode/")
;;(setq haskell-font-lock-symbols nil)
(add-hook 'haskell-mode-hook 'font-lock-mode)
(setq haskell-program-name "/usr/local/bin/ghci")
(setq inferior-haskell-find-project-root nil)
(define-key haskell-mode-map (kbd "C-,") 'haskell-move-nested-left)
(define-key haskell-mode-map (kbd "C-.") 'haskell-move-nested-right)
;; (add-hook 'haskell-mode-hook 'imenu-add-menubar-index)

;; ;; Ghc mod
(setq load-path (cons "/Users/dan/projects/ghc-mod/elisp" load-path))
(autoload 'ghc-init "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))
;; ;;(setq haskell-mode-hook (cdr (reverse haskell-mode-hook)))
;; ;;(setq ghc-ghc-options '("-i ~/Library/Haskell/ghc-7.6.3/lib"))
(if (file-accessible-directory-p "~/mnt/ghcjs1/dev")
    (setq ghc-module-command "/Users/dan/vado-ghc-mod.sh")
    (setq ghc-module-command "/Users/dan/Library/Haskell/bin/ghc-mod"))

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
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

;;(setq haskell-stylish-on-save t)

;; Git & other VCS
(global-set-key (kbd "C-x g") 'magit-status)

;; HTML/CSS/bla-bla
(add-to-list 'auto-mode-alist '("\\.html?$" . sgml-mode))
(require 'mustache-mode)
(autoload 'sgml-close-tag "sgml-mode")
(add-hook 'mustache-mode-hook
          (lambda ()
            (esk-prog-mode-hook)
            (setq comment-start-skip "\\(\\(^\\|[^\\\\\n]\\)\\(\\\\\\\\\\)*\\);+ *")))
(define-key mustache-mode-map (kbd "C-c /") 'sgml-close-tag)
(define-key mustache-mode-map (kbd "RET") nil)

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
 '(flymake-warnline ((t (:foreground "RoyalBlue3")))))


;; Other
;; (setq ruby-mode-hook nil)



;; JavaScript

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
