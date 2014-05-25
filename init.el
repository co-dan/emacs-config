(add-to-list 'load-path "~/.emacs.d/")
(require 'better-defaults)

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


