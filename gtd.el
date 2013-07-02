;;(setq load-path (cons "~/tools/org-8.0.2/contrib/lisp" load-path))

(setq load-path (append '("~/projects/emacs/org-mode/lisp" "~/projects/emacs/org-mode/contrib/lisp") load-path))

(require 'org)
(custom-set-faces
 '(org-link ((t (:foreground "aqua" :underline t))))
 '(org-date ((t (:foreground "RoyalBlue1" :underline t)))))

;; IDO
(setq org-completion-use-ido t)

(require 'org-mac-link-grabber)
(add-hook 'org-mode-hook (lambda () 
  (define-key org-mode-map (kbd "C-c g") 'omlg-grab-link)))

(defun mail-import-flagged ()
  (let ((org-mac-mail-account "Gmail"))
    (org-mac-message-insert-flagged "notes.org" "Flagged mail")))

(require 'org-mac-iCal)

(setq org-agenda-custom-commands
      (list '("I" "Import diary from iCal" agenda ""
              ((org-agenda-mode-hook
                (lambda ()
                  (org-mac-iCal)))))
            '(" " "Agenda"
               ((agenda "" ((org-agenda-span 1)))
                (tags-todo "personal"
                           ((org-agenda-overriding-header "Personal tasks")
                            (org-agenda-sorting-strategy
                             '(priority-down category-keep))))
                (tags-todo "soc"
                           ((org-agenda-overriding-header "GSoC")
                            (org-agenda-sorting-strategy
                             '(priority-down category-keep))))
                (tags-todo "work"
                           ((org-agenda-overriding-header "Work")
                            (org-agenda-sorting-strategy
                             '(priority-down category-keep)))))
               nil))) 

(setq org-agenda-compact-blocks t)
(setq org-agenda-include-diary t)
(add-hook 'org-agenda-cleanup-fancy-diary-hook
          (lambda ()
            (goto-char (point-min))
            (save-excursion
              (while (re-search-forward "^[a-z]" nil t)
                (goto-char (match-beginning 0))
                (insert "0:00-24:00 ")))
            (while (re-search-forward "^ [a-z]" nil t)
              (goto-char (match-beginning 0))
              (save-excursion
                (re-search-backward "^[0-9]+:[0-9]+-[0-9]+:[0-9]+ " nil t))
              (insert (match-string 0)))))

(setq holiday-bahai-holidays nil)
(setq org-mac-iCal-range 1)

;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/Dropbox/notes/refile.org")
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")

(setq org-todo-keywords
      '((type "TODO(t)" "STARTED(s)" "WAITING(w)" "|" "CANCELED(c)" "DONE(d)")
        (sequence "PROJECT(p)" "|" "FINISHED(f)")))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :background "black" :weight bold)
              ("STARTED" :foreground "yellow" :weight bold)
              ("PROJECT" :foreground "blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("FINISHE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold))))

(setq org-use-fast-todo-selection t)
(setq org-enforce-todo-dependencies t)


(setq org-agenda-files (list "~/Dropbox/notes/notes.org"
                             "~/Dropbox/notes/projects.org"
                             "~/Dropbox/notes/gsoc/diagrams.org"
                             "~/Dropbox/notes/gsoc/current.org"))

(global-set-key (kbd "C-M-r") 'org-capture)
(setq org-default-notes-file "~/Dropbox/notes/refile.org")
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))
;; org-document-title

(setq org-capture-templates
      '(("t" "Todo" entry (file org-default-notes-file)
         "* TODO %?%i\n%U\n%a\n")
        ("n" "Note" entry (file org-default-notes-file)
         "* %?%i\n%U\n%a\n")))

;; org-mac-protocol

(add-to-list 'load-path "/Users/dan/projects/emacs/org-mac-protocol")
(require 'org-mac-protocol)

;; org latex
(require 'ox-latex)
(require 'ox-beamer)
