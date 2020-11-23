;; -*- no-byte-compile: t; -*-
;;; app/spotify/packages.el

(package! spotify
  :recipe (:host github
           :repo "danielfm/spotify.el"
           :files ("*.el")))
(package! counsel-spotify)

;; (package! oauth)
;; (package! simple-httpd)
