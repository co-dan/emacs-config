;; General stuff for writing

(setq ispell-program-name "/usr/local/bin/aspell")

;; Markdown settings
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)

(defun make-markdown-look-better ()
  (interactive)
;;  (text-scale-increase 1)
  (linum-mode -1)
  (set-window-margins nil 2 1))

(add-hook 'markdown-mode-hook 'make-markdown-look-better)

(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; LaTeX

(setq TeX-output-view-style (quote (("^pdf$" "." "open -a Preview.app %o") ("^dvi$" "^xdvi$" "open-x11 %(o?)xdvi %dS %d") ("^dvi$" "^TeXniscope$" "open -a TeXniscope.app %o") ("^pdf$" "." "open %o") ("^html?$" "." "open %o"))))

(setq TeX-view-program-list
      '(("Skim" "open -a Skim.app %o")
        ("Preview" "open -a Preview.app %o")))

(setq TeX-view-program-selection '((output-pdf "Preview")))

(defun fix-latex-cmd () 
  (setf (cadr (assoc "LaTeX" TeX-command-list)) "%`%l%(mode) -file-line-error %' %t"))

(require 'reftex)

(add-hook 'LaTeX-mode-hook 'fix-latex-cmd)
(add-hook 'LaTeX-mode-hook 'reftex-mode)
(add-hook 'LaTeX-mode-hook 'outline-minor-mode)

(add-to-list 'reftex-default-bibliography
             "/Users/dan/Dropbox/Public/t/main")

(add-to-list 'reftex-bibpath-environment-variables
             "/Users/dan/Dropbox/Public/t/")
(setq reftex-external-file-finders
      '(("tex" . "/usr/texbin/kpsewhich -format=.tex %f")
  ("bib" . "/usr/texbin/kpsewhich -format=.bib %f")))

(setq TeX-outline-extra
      '(("%%%" 3)
        ("%%%%" 6)))

(setq reftex-plug-into-AUCTeX t)

(eval-after-load "preview"
  '(add-to-list 'preview-default-preamble "\\PreviewEnvironment{tikzpicture}" t)
  )

;; ORG writing
(setq org-export-with-smart-quotes t)

(setq outline-minor-mode-hook '())
(add-hook 'outline-minor-mode-hook
          (lambda ()
            (require 'outline-magic)
            (define-key outline-minor-mode-map [(f9)] 'outline-cycle)))

