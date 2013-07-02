;; (require 'tex-mik)
;; (setq TeX-auto-save t)
;; (setq TeX-parse-self t)
;; (setq-default TeX-master nil)

;; (add-hook 'LaTeX-mode-hook 'auto-fill-mode)
;; (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
;; (add-hook 'LaTeX-mode-hook 'tex-pdf-mode)
;; (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;; (setq reftex-plug-into-AUCTeX t)

(setq TeX-output-view-style (quote (("^pdf$" "." "open -a Preview.app %o") ("^dvi$" "^xdvi$" "open-x11 %(o?)xdvi %dS %d") ("^dvi$" "^TeXniscope$" "open -a TeXniscope.app %o") ("^pdf$" "." "open %o") ("^html?$" "." "open %o"))))

