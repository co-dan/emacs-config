;; General stuff for writing

(setq ispell-program-name "/usr/local/bin/aspell")

;; Markdown settings
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)

(defun make-markdown-look-better ()
  (interactive)
  (text-scale-increase 1)
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
