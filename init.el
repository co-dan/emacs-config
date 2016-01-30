(load-file "~/.emacs.d/better-defaults.el")

(defun esk-eval-after-init (form)
    "Add `(lambda () FORM)' to `after-init-hook'.

If Emacs has already finished initialization, also eval FORM immediately."
    (let ((func (list 'lambda nil form)))
      (add-hook 'after-init-hook func)
      (when after-init-time
        (eval form))))

(setq esk-system-config (concat user-emacs-directory system-name ".el")
        esk-user-config (concat user-emacs-directory user-login-name ".el")
        esk-user-dir (concat user-emacs-directory user-login-name))

(add-to-list 'load-path esk-user-dir)


(esk-eval-after-init
 '(progn
    (when (file-exists-p esk-system-config) (load esk-system-config))
    (when (file-exists-p esk-user-config) (load esk-user-config))
    (when (file-exists-p esk-user-dir)
      (mapc 'load (directory-files esk-user-dir t "^[^#].*el$")))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-math-list
   (quote
    (("," LaTeX-math-bf "boldface" nil)
     ("." "circ" "Composition" nil)
     ("o" "models" "Modal" nil)
     ("8" "Box" "Modal" "□")
     ("9" "Diamond" "Modal" "◇")
     ("=" "approx" nil nil))))
 '(agda2-highlight-face-groups (quote default-faces))
 '(coq-compiler "/Users/dan/projects/HoTT/hoqc")
 '(coq-prog-args (quote ("-emacs")) t)
 '(coq-prog-name "/Users/dan/projects/HoTT/hoqtop")
 '(erc-modules
   (quote
    (autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring smiley stamp track)))
 '(geiser-default-implementation (quote racket))
 '(proof-assistants (quote (coq)))
 '(proof-shell-fiddle-frames nil)
 '(safe-local-variable-values
   (quote
    ((eval let
           ((default-directory
              (locate-dominating-file buffer-file-name ".dir-locals.el")))
           (make-local-variable
            (quote coq-prog-name))
           (setq coq-prog-name
                 (expand-file-name "../hoqtop"))))))
 '(tex-bibtex-command "biber"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
