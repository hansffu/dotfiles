;; -*- no-byte-compile: t; -*-
;;; app/spotify/packages.el

(package! oauth2)
(package! smudge
  :recipe (:host github
           :repo "danielfm/smudge"
           :files ("*.el")))
(package! counsel-spotify)

;; (package! oauth)
;; (package! simple-httpd)
