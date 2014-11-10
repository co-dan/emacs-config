;; General stuff for writing
(require 'ispell)
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
;; (setq TeX-parse-self t)
;; (setq-default TeX-master nil)

;; (add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)

;; (setq TeX-source-correlate-method 'synctex)

;; (add-hook 'LaTeX-mode-hook
;;       (lambda()
;;         (add-to-list 'TeX-expand-list
;;              '("%q" skim-make-url))))

;; (defun skim-make-url () (concat
;;         (TeX-current-line)
;;         " "
;;         (expand-file-name (funcall file (TeX-output-extension) t)
;;             (file-name-directory (TeX-master-file)))
;;         " "
;;         (buffer-file-name)))

;; (setq TeX-view-program-list
;;       '(("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline %q")))

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
             "/Users/dan/Dropbox/notes/lab/writings/main")

(add-to-list 'reftex-bibpath-environment-variables
             "/Users/dan/Dropbox/notes/lab/writings/")
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

;; ORG writing
(setq org-export-with-smart-quotes t)

(setq outline-minor-mode-hook '())
(add-hook 'outline-minor-mode-hook
          (lambda ()
            (require 'outline-magic)
            (define-key outline-minor-mode-map [(f9)] 'outline-cycle)))

