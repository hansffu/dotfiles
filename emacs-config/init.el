;; (package-initialize)
;; (org-babel-load-file "~/.emacs.d/config.org")

(if (file-exists-p (concat user-emacs-directory "config.el"))
    (load-file (concat user-emacs-directory "config.el"))
  (org-babel-load-file "~/.emacs.d/config.org"))

