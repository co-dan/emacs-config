;; General stuff for writing
(require 'ispell)
(require 'latex)
(setq ispell-program-name "/usr/local/bin/aspell"
      ispell-extra-args '("--sug-mode=ultra"))
(setq ispell-dictionary "en")
(setq ispell-list-command "list")
(setq ispell-local-dictionary "ru")
(add-to-list 'ispell-dictionary-alist
             '("ru"
               "[АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюя]"
               "[^АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюя]"
               "" nil nil nil utf-8))

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
(setq-default TeX-engine 'xetex)
(setq-default TeX-PDF-mode t)
(add-hook 'LaTeX-mode-hook 'TeX-global-PDF-mode)

;; (setq TeX-view-program-selection '((output-pdf "Skim")))

;; (add-to-list 'TeX-output-view-style
;;              '("^pdf$" "."
;;                "/Applications/Skim.app/Contents/SharedSupport/displayline -b %n %o %b"))

(setq TeX-view-program-list
      '(("Skim" "open -a Skim.app %o")
        ("Preview" "open -a Preview.app %o")))

(setq TeX-view-program-selection '((output-pdf "Skim")))

(defun fix-latex-cmd () 
  (setf (cadr (assoc "LaTeX" TeX-command-list)) "%`%l%(mode) -file-line-error %' %t"))

(require 'reftex)

(add-hook 'LaTeX-mode-hook 'fix-latex-cmd)
(add-hook 'LaTeX-mode-hook 'reftex-mode)
(add-hook 'LaTeX-mode-hook 'outline-minor-mode)

(add-to-list 'reftex-default-bibliography
             "/Users/dan/Documents/Study/Realiz/realiz")
(add-to-list 'reftex-bibpath-environment-variables
             "/Users/dan/Documents/Study/Realiz")
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

(setq preview-gs-options '("-q" "-dNOSAFER" "-dNOPAUSE" "-DNOPLATFONTS" "-dPrinted" "-dTextAlphaBits=4" "-dGraphicsAlphaBits=4"))


;;;; latex math mode

(defun LaTeX-math-bf (char dollar)
  "Insert a \\mathbf{CHAR}.  If DOLLAR is non-nil, put $'s around it."
  (interactive "*c\nP")
  (if dollar (insert "$"))
  (insert "\\mathbf{" (char-to-string char) "}")
  (if dollar (insert "$")))

(add-to-list 'LaTeX-math-list '("," LaTeX-math-bf "Bold face" nil))
(add-to-list 'LaTeX-math-list '("." "circ" "Composition" nil))
(add-to-list 'LaTeX-math-list '("o" "models" "Modal" nil))
(add-to-list 'LaTeX-math-list '("8" "Box" "Modal" "□"))
(add-to-list 'LaTeX-math-list '("9" "Diamond" "Modal" "◇"))
(add-to-list 'LaTeX-math-list '("=" "approx" nil nil))


;; ORG writing
(setq org-export-with-smart-quotes t)

(setq outline-minor-mode-hook '())
(add-hook 'outline-minor-mode-hook
          (lambda ()
            (require 'outline-magic)
            (define-key outline-minor-mode-map [(f9)] 'outline-cycle)))

